+++
title = 'Azure Weekly – 2025 Week 33'
date = 2025-08-13T10:19:19Z
lastmod = 2025-08-13T11:45:07Z
draft = false
tags = ['updates', 'weekly', 'azure']
description = 'Highlights from Azure between 2025-08-11 and 2025-08-17.'
[params]
    author = 'sujith'
+++
## This period at a glance

**Window:** 2025-08-11 → 2025-08-17 (Europe/Brussels)

- **[Azure App Testing: Playwright Workspaces for Local-to-Cloud Test Runs](https://techcommunity.microsoft.com/blog/appsonazureblog/azure-app-testing-playwright-workspaces-for-local-to-cloud-test-runs/4442711)** — Azure App Service now supports Playwright Workspaces, enabling users to run Playwright tests locally, against Azure Web Apps, and at cloud scale. The update includes sample apps, scripts, configurations, and troubleshooting resources.
  - Playwright Workspaces introduced for Azure App Service.
  - Supports local, Azure Web App, and cloud-scale Playwright test runs.
  - Sample app, scripts, and configs provided.
  - Troubleshooting resources included.
- **[Load data from network-protected Azure Storage accounts to Microsoft OneLake with AzCopy](https://blog.fabric.microsoft.com/en-US/blog/load-data-from-network-protected-azure-storage-accounts-to-microsoft-onelake-with-azcopy/)** — AzCopy now supports copying data from firewall-enabled Azure Storage accounts to Microsoft OneLake using trusted workspace access, improving secure data transfer capabilities.
  - AzCopy can now move data from network-protected (firewall-enabled) Azure Storage accounts to OneLake.
  - Uses trusted workspace access for secure transfers.
  - Enhances options for large-scale, secure data movement between Azure Storage and OneLake.
- **[Private Pod Subnets in AKS Without Overlay Networking](https://techcommunity.microsoft.com/blog/appsonazureblog/private-pod-subnets-in-aks-without-overlay-networking/4442510)** — Azure Kubernetes Service (AKS) now supports deploying private pod subnets without requiring overlay networking, announced on 2025-08-12. This change addresses IP address space concerns for clusters integrated with corporate networks.
  - AKS clusters can now use private pod subnets without overlay networking.
  - Reduces IP address space requirements for AKS deployments in corporate networks.
  - Announced on 2025-08-12.
- **[Real-Time Security with Continuous Access Evaluation (CAE) comes to Azure DevOps](https://devblogs.microsoft.com/devops/real-time-security-with-continuous-access-evaluation-cae-comes-to-azure-devops/)** — Azure DevOps now supports Continuous Access Evaluation (CAE), enabling near real-time enforcement of Conditional Access policies via Microsoft Entra ID.
  - CAE support added to Azure DevOps as of 2025-08-12
  - Enables near real-time security enforcement for development workflows
  - Integrates with Microsoft Entra ID Conditional Access policies
- **[OneLake costs simplified: lowering capacity utilization when accessing OneLake](https://blog.fabric.microsoft.com/en-US/blog/onelake-costs-simplified-lowering-capacity-utilization-when-accessing-onelake/)** — Azure OneLake has updated its capacity utilization model as of August 12, 2025, reducing the consumption rate for transactions via proxy to match those via redirect. This change simplifies cost management and scaling for Fabric capacity users.
  - Capacity utilization for OneLake transactions via proxy now matches the rate for transactions via redirect.
  - Update effective August 12, 2025.
  - Aims to simplify cost management and scaling for Azure Fabric users.
- **[Hunting Living Secrets: Secret Validity Checks Arrive in GitHub Advanced Security for Azure DevOps](https://devblogs.microsoft.com/devops/hunting-living-secrets-secret-validity-checks-arrive-in-github-advanced-security-for-azure-devops/)** — GitHub Advanced Security for Azure DevOps now includes secret validity checks, providing an 'Active' or 'Unknown' status for each secret scanning alert as of August 12, 2025.
  - Secret validity checks added to GitHub Advanced Security for Azure DevOps.
  - Alerts now indicate if a secret is 'Active' (usable) or 'Unknown'.
  - Feature also available in standalone Secret Protection experience.
  - Announced August 12, 2025.
- **[Supercharge Data Intelligence: Build Teams App with Azure Databricks Genie & Azure AI Agent Service](https://techcommunity.microsoft.com/blog/analyticsonazure/supercharge-data-intelligence-build-teams-app-with-azure-databricks-genie--azure/4442653)** — Microsoft announced integration between Azure Databricks Genie and Azure AI Agent Service, enabling Teams apps to leverage advanced data intelligence capabilities. The update was revealed at Microsoft BUILD 2025.
  - Azure Databricks Genie now integrates with Azure AI Agent Service.
  - Teams apps can utilize these services for enhanced data intelligence.
  - Announcement made at Microsoft BUILD 2025.
- **[🚀 General Availability: Enhanced Data Mapper Experience in Logic Apps (Standard)](<https://techcommunity.microsoft.com/blog/integrationsonazureblog/%F0%9F%9A%80-general-availability-enhanced-data-mapper-experience-in-logic-apps-standard/4442296>)** — Azure Logic Apps (Standard) has released the enhanced Data Mapper user experience for Visual Studio Code as generally available as of August 12, 2025.
  - Enhanced Data Mapper UX is now generally available in Logic Apps (Standard) for Visual Studio Code.
  - Release date: August 12, 2025.
  - Applies to: Azure Logic Apps (Standard) extension in Visual Studio Code.
- **[Public Preview: Auto agent upgrade for Azure Arc-enabled servers](https://techcommunity.microsoft.com/blog/azurearcblog/public-preview-auto-agent-upgrade-for-azure-arc-enabled-servers/4442556)** — Azure Arc-enabled servers now support automatic upgrades for the Azure Connected Machine agent in public preview as of August 12, 2025.
  - Automatic agent upgrade feature for Azure Arc-enabled servers is now in public preview.
  - Ensures Azure Connected Machine agent stays updated with latest management capabilities and fixes.
  - Available starting August 12, 2025.
- **[Introducing support for Workspace Identity Authentication in Fabric Connectors](https://blog.fabric.microsoft.com/en-US/blog/announcing-support-for-workspace-identity-authentication-in-new-fabric-connectors-and-for-dataflow-gen2/)** — Microsoft Fabric announced support for Workspace Identity Authentication in Fabric Connectors, enhancing secure and seamless data access management.
  - Workspace Identity Authentication uses an automatically managed service principal linked to workspaces, excluding My Workspaces.
  - This feature simplifies credential management and improves security for organizations using Microsoft Fabric.
  - The update was announced on August 11, 2025, by Azure.
- **[Announcing Tenant-Level Service Health Alerts in Azure Monitor](<https://azure.microsoft.com/updates?id=499776>)** — Azure Monitor has introduced a preview feature for tenant-level service health alerts, allowing users to receive notifications about service health issues affecting their entire tenant rather than just individual subscriptions.
  - Tenant-level service health alerts now available in Azure Monitor (preview).
  - Enables proactive notifications for issues impacting the whole tenant, not just single subscriptions.
  - Announced on 2025-08-11.
- **[Introducing Azure App Testing: Scalable End-to-end App Validation](<https://azure.microsoft.com/updates?id=500203>)** — Azure has introduced Azure App Testing in preview, allowing developers and QA teams to conduct large-scale functional and performance tests using frameworks such as Playwright, JMeter, and Locust.
  - Azure App Testing is now available in preview as of 2025-08-11.
  - Supports large-scale functional and performance testing.
  - Compatible with Playwright, JMeter, and Locust frameworks.
  - Combines load testing and Playwright testing capabilities.
- **[General Available: App Service Inbound IPv6 Support](<https://azure.microsoft.com/updates?id=499998>)** — Azure App Service now offers general availability of inbound IPv6 support for multi-tenant apps across all public regions and supported SKUs as of August 11, 2025.
  - Inbound IPv6 support is now generally available for public multi-tenant App Service.
  - Applies to Basic, Standard, and Premium SKUs, Functions Consumption, Functions Elastic Premium, and Logic Apps Standard.
  - Available in all public Azure regions.
  - Effective date: August 11, 2025.
- **[Announcing GA of Bicep templates support for Microsoft Entra ID resources](https://devblogs.microsoft.com/identity/bicep-templates-for-microsoft-entra-id-resources-is-ga/)** — Bicep templates for Microsoft Entra ID resources are now generally available as of July 29, 2025. This enables declarative infrastructure as code (IaC) management for core Entra ID resources via Microsoft Graph.
  - Bicep template support for Microsoft Entra ID resources is GA as of July 29, 2025.
  - Enables IaC for core Entra ID resources using Microsoft Graph.
  - Initial release focuses on core resource types.
- **[Upsert and Script Activity in Azure Data Factory and Azure Synapse Analytics for Azure Database for PostgreSQL](<https://azure.microsoft.com/updates?id=499748>)** — Azure Data Factory and Azure Synapse Analytics now support the Upsert method and Script activity for Azure Database for PostgreSQL as of August 11, 2025. These features are generally available and enable more efficient and scalable data operations.
  - Upsert method is now generally available in Data Factory and Synapse Analytics for Azure Database for PostgreSQL.
  - Script activity support added for Azure Database for PostgreSQL in both services.
  - Release date: August 11, 2025.
  - Applies to Azure Data Factory and Azure Synapse Analytics.
- **[Customer-managed keys for Fabric workspaces is now in Public Preview](https://blog.fabric.microsoft.com/en-US/blog/customer-managed-keys-for-fabric-workspaces-available-in-all-public-regions-now-preview/)** — Customer-managed keys (CMK) for Microsoft Fabric workspaces are now in public preview across all public regions. This feature allows organizations to control their own encryption keys for enhanced compliance and data protection.
  - CMK for Fabric workspaces is in public preview as of 2025-08-11.
  - Available in all public Azure regions.
  - Enables customer control over encryption keys for compliance needs.
  - Previously limited to select regions; now globally available in public preview.
- **[How Microsoft OneLake seamlessly provides Apache Iceberg support for all Fabric Data](https://blog.fabric.microsoft.com/en-US/blog/how-to-access-your-microsoft-fabric-tables-in-apache-iceberg-format/)** — Microsoft OneLake now provides seamless support for Apache Iceberg format across all Microsoft Fabric data, as announced on August 11, 2025. This enables users to access Fabric tables in Iceberg format, in addition to the default Delta Lake format.
  - Microsoft OneLake adds Apache Iceberg support for all Microsoft Fabric data.
  - Fabric tables can now be accessed in both Delta Lake and Iceberg formats.
  - Update announced on August 11, 2025.

