#!/usr/bin/env pwsh
param(
  # Where to write the markdown (your Hugo repo root)
  # If you actually want the *script folder*, prefer $PSScriptRoot.
  [string]$RepoRoot = (Resolve-Path -LiteralPath .).Path,
  # or: [string]$RepoRoot = (Get-Location).Path
  # or: [string]$RepoRoot = $PSScriptRoot  # if that's your intent

  # Section root (keep this OUT of your mainSections to avoid home pollution)
  [string]$ContentDir = 'content/updates',

  # Max items per source to keep the post readable
  [int]$MaxAzure = 20,
  [int]$MaxGitHub = 12,
  [int]$MaxTerraform = 8,

  # Which Terraform repos to watch (owner/repo)
  [string[]]$TerraformRepos = @(
    'hashicorp/terraform',
    'hashicorp/terraform-provider-azurerm'
  ),
  # Per-source publish cadence (weekly|biweekly|monthly), comma-separated key=value
  # Example: Azure=weekly,GitHub=biweekly,Terraform=weekly
  [string]$Frequencies = 'Azure=weekly,GitHub=biweekly,Terraform=weekly'
)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- Config / env
$ErrorActionPreference = 'Stop'
$GHToken = $env:GITHUB_TOKEN
if (-not $GHToken) { Write-Error 'GITHUB_TOKEN is required (with models:read, contents:write).'; exit 1 }

$HeadersGitHub = @{
  'Authorization' = "Bearer $GHToken"
  'Accept'        = 'application/vnd.github+json'
  'X-GitHub-Api-Version' = '2022-11-28'
}

function Log($m){ Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $m" }

# --- Week window (Mon–Sun) based on Europe/Brussels, formatted in UTC for APIs
$tz = [System.TimeZoneInfo]::FindSystemTimeZoneById('Romance Standard Time') # Brussels
$nowLocal = [System.TimeZoneInfo]::ConvertTimeFromUtc([DateTime]::UtcNow, $tz)
$dayOfWeek = [int]$nowLocal.DayOfWeek  # Mon=1 .. Sun=0
$daysSinceMonday = ($dayOfWeek + 6) % 7
$weekStartLocal = $nowLocal.Date.AddDays(-$daysSinceMonday)
$weekEndLocal   = $weekStartLocal.AddDays(7).AddSeconds(-1)
$weekStartUtc   = [System.TimeZoneInfo]::ConvertTimeToUtc($weekStartLocal, $tz)
$weekEndUtc     = [System.TimeZoneInfo]::ConvertTimeToUtc($weekEndLocal, $tz)

# ISO week number for title/slug
$isoWeek = [System.Globalization.ISOWeek]::GetWeekOfYear($weekStartLocal)
$yearForWeek = [System.Globalization.ISOWeek]::GetYear($weekStartLocal)

# --- GitHub Models (Inference) helper
function Invoke-GitHubModelChat {
  param(
    [Parameter(Mandatory)] [string]$Prompt,
    [string]$Model = 'openai/gpt-4o-mini',
    [decimal]$Temperature = 0.2,
    [int]$MaxTokens = 350
  )
  $body = @{
    model = $Model
    temperature = [double]$Temperature
    max_tokens = $MaxTokens
    response_format = @{ type = 'json_schema'; json_schema = @{
        name = 'summary_schema'
        schema = @{
          type = 'object'
          additionalProperties = $false
          required = @('summary')
          properties = @{
            summary = @{ type = 'string'; description = '1–2 sentences, crisp, no hype.' }
            bullets = @{ type = 'array'; maxItems = 4; items = @{ type = 'string' } }
            tags    = @{ type = 'array'; maxItems = 6; items = @{ type = 'string' } }
          }
        }
    }}
    messages = @(
      @{ role='system'; content='You summarize tech release notes and changelogs. Be factual, concise, and specific. No marketing language.'},
      @{ role='user';   content=$Prompt }
    )
  } | ConvertTo-Json -Depth 8

  $res = Invoke-RestMethod -Method POST -Uri 'https://models.github.ai/inference/chat/completions' -Headers $HeadersGitHub -ContentType 'application/json' -Body $body
  $json = $res.choices[0].message.content
  try { return ($json | ConvertFrom-Json) } catch { return @{ summary = $json } }
}

# --- Utilities
function Trunc([string]$s,[int]$n=300){ if(-not $s){return ''}; if($s.Length -le $n){return $s}; return $s.Substring(0,$n).Trim() + '…' }
function MdEscape([string]$s){ if(-not $s){return ''}; $s -replace '\|','\\|' }
function ToBulletMd($arr){ if(-not $arr -or $arr.Count -eq 0){ return '' }; ($arr | ForEach-Object { "  - " + ($_ -replace '\n',' ') }) -join "`n" }

# Wrap bare URLs in <> to avoid markdownlint MD034 (no-bare-urls)
function Fix-BareUrls([string]$text){
  if(-not $text){ return $text }
  # Skip if already part of a markdown link [text](url)
  return ($text -replace '(?<!\]\()https?://[\w\-\./%?&#=+:~]+', '<$0>')
}

# Normalize URL for markdown link: remove stray trailing ' link' and wrap in < > when query chars present
function Format-LinkUrl([string]$u){
  if(-not $u){ return '' }
  $clean = $u.Trim()
  $clean = $clean -replace '\s+link$',''  # remove literal trailing word 'link'
  # If already enclosed in <>, leave; else wrap when contains query/ampersand or spaces
  if($clean -notmatch '^<.*>$'){
    if($clean -match '[?&]|%'){ $clean = "<$clean>" }
  }
  return $clean
}

# --- Sources
$AzureRss = 'https://aztty.azurewebsites.net/rss/updates'  # Azure Charts consolidated RSS

function Fetch-AzureUpdates {
  Log 'Fetch: Azure updates (Azure Charts RSS)'
  try {
    $resp = Invoke-WebRequest -Uri $AzureRss -Headers @{ 'User-Agent'='weekly-hugo-tracker' } -UseBasicParsing -ErrorAction Stop
    if(-not $resp.Content){ throw 'Empty response body' }
    try { [xml]$rss = $resp.Content } catch { throw "RSS XML parse failed: $($_.Exception.Message)" }
    if(-not $rss.rss.channel.item){ return @() }
    $items = foreach($i in $rss.rss.channel.item){
      if(-not $i.pubDate){ continue }
      $pub = Get-Date $i.pubDate -ErrorAction SilentlyContinue
      if(-not $pub){ continue }
      if($pub -lt $weekStartUtc -or $pub -gt $weekEndUtc){ continue }
      [pscustomobject]@{
        source = 'Azure'
        title = [string]$i.title
        url   = [string]$i.link
        publishedAt = $pub.ToUniversalTime()
        raw   = [string]$i.description
      }
    }
    return ($items | Where-Object { $_ }) | Sort-Object publishedAt -Descending | Select-Object -First $MaxAzure
  } catch { Write-Warning "Azure RSS failed: $($_.Exception.Message)"; return @() }
}

$GitHubChangelogRss = 'https://github.blog/changelog/feed/'
function Fetch-GitHubChangelog {
  Log 'Fetch: GitHub Changelog RSS'
  try {
    $resp = Invoke-WebRequest -Uri $GitHubChangelogRss -Headers @{ 'User-Agent'='weekly-hugo-tracker' } -UseBasicParsing -ErrorAction Stop
    if(-not $resp.Content){ throw 'Empty response body' }
    try { [xml]$rss = $resp.Content } catch { throw "RSS XML parse failed: $($_.Exception.Message)" }
    if(-not $rss.rss.channel.item){ return @() }
    $items = foreach($i in $rss.rss.channel.item){
      if(-not $i.pubDate){ continue }
      $pub = Get-Date $i.pubDate -ErrorAction SilentlyContinue
      if(-not $pub){ continue }
      if($pub -lt $weekStartUtc -or $pub -gt $weekEndUtc){ continue }
      [pscustomobject]@{
        source = 'GitHub'
        title  = [string]$i.title
        url    = [string]$i.link
        publishedAt = $pub.ToUniversalTime()
        raw    = Trunc([string]$i.'content:encoded', 2000)
      }
    }
    return ($items | Where-Object { $_ }) | Sort-Object publishedAt -Descending | Select-Object -First $MaxGitHub
  } catch { Write-Warning "GitHub Changelog RSS failed: $($_.Exception.Message)"; return @() }
}

function Fetch-GitHubReleases([string]$owner,[string]$repo,[int]$limit=8){
  $uri = "https://api.github.com/repos/$owner/$repo/releases?per_page=$limit"
  try { return Invoke-RestMethod -Uri $uri -Headers $HeadersGitHub -Method GET }
  catch { Write-Warning "Releases fetch failed for $owner/$repo $_"; return @() }
}
function Fetch-Terraform {
  Log 'Fetch: Terraform releases'
  $items = @()
  foreach($full in $TerraformRepos){
    $parts = $full.Split('/')
    if($parts.Count -ne 2){ continue }
    $owner=$parts[0]; $repo=$parts[1]
    $rels = Fetch-GitHubReleases -owner $owner -repo $repo -limit 8
    foreach($r in $rels){
      if(-not $r.published_at){ continue }
      $pub = [datetime]::Parse($r.published_at).ToUniversalTime()
      if($pub -lt $weekStartUtc -or $pub -gt $weekEndUtc){ continue }
      $body = [string]($r.body ?? '')
      $items += [pscustomobject]@{
        source = 'Terraform'
        title  = if($r.name){ [string]$r.name } else { [string]$r.tag_name }
        url    = [string]$r.html_url
        publishedAt = $pub
        raw    = Trunc($body, 4000)
      }
    }
  }
  return $items | Sort-Object publishedAt -Descending | Select-Object -First $MaxTerraform
}

# --- Collect and summarize
$azure = Fetch-AzureUpdates
$ghchg = Fetch-GitHubChangelog
$tf    = Fetch-Terraform

$all = @($azure + $ghchg + $tf)
Log ("Collected: Azure={0}, GitHub={1}, Terraform={2}" -f $azure.Count, $ghchg.Count, $tf.Count)

function Summarize-Item($item){
  $prompt = @"
Summarize the following update for a weekly newsletter. Keep it factual. Mention product/area and any version/flag/region/date specifics.

TITLE: $($item.title)
URL: $($item.url)
DATE: $($item.publishedAt.ToString('yyyy-MM-dd'))
SOURCE: $($item.source)
RAW:\n$([string]$item.raw)
"@
  $out = Invoke-GitHubModelChat -Prompt $prompt
  if(-not $out.summary){ $out = @{ summary = Trunc($item.title, 200) } }
  $cleanSummary = Fix-BareUrls (($out.summary -replace '\s+',' ').Trim())
  $cleanBullets = @()
  foreach($b in @($out.bullets)){
    if($b){ $cleanBullets += (Fix-BareUrls (($b -replace '\s+',' ').Trim())) }
  }
  return [pscustomobject]@{
    source = $item.source
    title  = $item.title
    url    = $item.url
    date   = $item.publishedAt.ToString('yyyy-MM-dd')
    summary = $cleanSummary
    bullets = $cleanBullets
  }
}

$summaries = @()
foreach($i in $all){ if(-not $i){ continue }; try { $summaries += (Summarize-Item $i) } catch { Write-Warning "Summarize failed for item: $($_.Exception.Message)" } }
$bySource = $summaries | Group-Object source | Sort-Object Name

# --- Renderers
function New-FrontMatter([string]$title,[string]$desc,[string[]]$tags){
  $now = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ')
  $safeTitle = ($title -replace '"','\"').Trim()
  $safeDesc  = ($desc -replace '"','\"').Trim()
  $tagList = ($tags | Where-Object { $_ -and $_.Trim() -ne '' } | ForEach-Object { $_.Trim() }) -join ', '
  $lines = @(
    '---',
  "title: '$safeTitle'",
    "date: $now",
    "lastmod: $now",
    'draft: false',
    "tags: [$tagList]",
  "description: '$safeDesc'",
    '---',''
  )
  return $lines -join "`n"
}

function Render-Body($items){
  $lines = @()
  $lines += "## This week at a glance"
  # Blank line after heading (MD022)
  $lines += ''
  # Avoid MD036; no trailing explicit newline to prevent MD012
  $lines += "**Window:** $($weekStartLocal.ToString('yyyy-MM-dd')) → $($weekEndLocal.ToString('yyyy-MM-dd')) (Europe/Brussels)"
  # Blank line before list (MD032)
  $lines += ''
  foreach($x in ($items | Sort-Object date -Descending)){
    $bul = ToBulletMd $x.bullets
  $fmtUrl = Format-LinkUrl $x.url
  $line = "- **[$([string](MdEscape $x.title))]($fmtUrl)** — $([string](MdEscape $x.summary))"
    if($bul){ $line += "`n$bul" }
    $lines += $line
  }
  return ($lines -join "`n") + "`n"
}

function Write-PerTypePost($typeName,$slugBase,$items,$tag){
  if(-not $items -or $items.Count -eq 0){ return $null }
  $title = "$typeName Weekly – $yearForWeek Week $isoWeek"
  $desc  = "Highlights from $typeName between $($weekStartLocal.ToString('yyyy-MM-dd')) and $($weekEndLocal.ToString('yyyy-MM-dd'))."
    $tags  = @('weekly', $tag)
  $fm = New-FrontMatter -title $title -desc $desc -tags $tags
  $body = Render-Body -items $items

  $yearMonth = ('{0:0000}-{1:00}' -f $yearForWeek, $weekStartLocal.Month)
  $folderName = "$yearMonth-$slugBase-w$('{0:D2}' -f $isoWeek)"
  $targetDir = Join-Path $RepoRoot $ContentDir
  New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
  $folder = Join-Path $targetDir $folderName
  New-Item -ItemType Directory -Force -Path $folder | Out-Null
  $file = Join-Path $folder 'index.md'
  Log "Writing post: $file"
  Set-Content -Path $file -Value ($fm + $body) -Encoding UTF8
  return $file
}

# Map & write
$written = @()
$map = @(
  @{ Name='Azure';     Slug='azure-weekly';     Tag='azure' },
  @{ Name='GitHub';    Slug='github-weekly';    Tag='github' },
  @{ Name='Terraform'; Slug='terraform-weekly'; Tag='terraform' }
)

# Parse frequency map
$FrequencyMap = @{}
foreach($pair in ($Frequencies -split ',')){
  $p = $pair.Trim(); if(-not $p){ continue }
  $kv = $p -split '='; if($kv.Count -ne 2){ continue }
  $FrequencyMap[$kv[0]] = $kv[1].ToLowerInvariant()
}

function Should-EmitSource([string]$sourceName){
  $freq = if($FrequencyMap.ContainsKey($sourceName)){ $FrequencyMap[$sourceName] } else { 'weekly' }
  switch($freq){
    'weekly'   { return $true }
    'biweekly' { return (($isoWeek % 2) -eq 0) }  # emit on even ISO weeks only
    'monthly'  { return ($weekStartLocal.Day -le 7) } # emit only during first week of month
    default    { return $true }
  }
}

# Build simple name -> items map (avoid nesting GroupInfo objects)
$groups = @{}
foreach($g in $bySource){ $groups[$g.Name] = $g.Group }

foreach($m in $map){
  $name = $m.Name
  if($groups.ContainsKey($name)){
    if(Should-EmitSource $name){
      $itemsForSource = $groups[$name]
      $path = Write-PerTypePost -typeName $name -slugBase $m.Slug -items $itemsForSource -tag $m.Tag
      if($path){ $written += $path }
    } else {
      Log "Skipping $name this week due to frequency cadence"
    }
  }
}

Write-Host "Written files:`n - " + ($written -join "`n - ")