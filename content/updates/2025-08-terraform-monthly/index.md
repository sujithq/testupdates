---
title: 'Terraform Monthly – August 2025'
date: 2025-08-12T12:03:16Z
lastmod: 2025-08-12T12:03:16Z
draft: false
tags: [updates, monthly, terraform]
description: 'Highlights from Terraform between 2025-08-01 and 2025-08-17.'
---
## This period at a glance

**Window:** 2025-08-01 → 2025-08-17 (Europe/Brussels)

- **[v4.39.0](https://github.com/hashicorp/terraform-provider-azurerm/releases/tag/v4.39.0)** — The Terraform AzureRM provider has been updated to version 4.39.0 on August 8, 2025, introducing new resources for API Management and Event Grid.
  - Added new resource: `azurerm_api_management_standalone_gateway`
  - Added new resource: `azurerm_eventgrid_partner_namespace`
- **[v1.14.0-alpha20250806](https://github.com/hashicorp/terraform/releases/tag/v1.14.0-alpha20250806)** — The Terraform v1.14.0-alpha20250806 update includes enhancements to the 'terraform test' command, specifically adding expected diagnostics to verbose output and modifying behavior to ignore the prevent_destroy attribute during cleanup.
  - Expected diagnostics included in verbose output for 'terraform test'
  - 'terraform test' now ignores prevent_destroy attribute during cleanup
- **[v1.13.0-rc1](https://github.com/hashicorp/terraform/releases/tag/v1.13.0-rc1)** — Terraform v1.13.0-rc1 was released on August 6, 2025, introducing the `terraform stacks` command for stack operations via CLI, with subcommands based on the stacks plugin implementation.
  - New command `terraform stacks` added for stack operations via CLI.
  - Subcommands available depend on the stacks plugin implementation.
  - Refer to `terraform stacks -help` for available commands.

