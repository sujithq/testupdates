+++
title = 'Azure Weekly – 2025 Week 33'
date = 2025-08-12T14:36:22Z
lastmod = 2025-08-12T14:36:22Z
draft = false
tags = ['updates', 'weekly', 'azure']
description = 'Highlights from Azure between 2025-08-11 and 2025-08-17.'
[params]
    author = 'sujith'
+++
## This period at a glance

**Window:** 2025-08-11 → 2025-08-17 (Europe/Brussels)

- **[Private Pod Subnets in AKS Without Overlay Networking](https://techcommunity.microsoft.com/blog/appsonazureblog/private-pod-subnets-in-aks-without-overlay-networking/4442510)** — Azure Kubernetes Service (AKS) now supports private pod subnets without the need for overlay networking, addressing IP address space concerns for deployments in corporate networks.
  - Feature: Private pod subnets in AKS
  - No overlay networking required
  - Targets Kubernetes Service and Virtual Network
  - Announcement date: August 12, 2025
- **[Announcing Tenant-Level Service Health Alerts in Azure Monitor](<https://azure.microsoft.com/updates?id=499776>)** — Azure Monitor has introduced Tenant-Level Service Health Alerts in preview, allowing customers to receive notifications about service health issues affecting their entire tenant. This feature enhances management capabilities by providing a broader view of service health beyond individual subscriptions.
  - Feature: Tenant-Level Service Health Alerts
  - Product: Azure Monitor
  - Update Type: Preview
  - Date: 2025-08-11
- **[Introducing Azure App Testing: Scalable End-to-end App Validation](<https://azure.microsoft.com/updates?id=500203>)** — Azure App Testing has been introduced as a preview feature, allowing developers and QA teams to conduct large-scale functional and performance tests using frameworks like Playwright, JMeter, and Locust.
  - Product: Azure App Testing
  - Update Type: Preview
  - Services: Load Testing, Playwright Testing
  - Date: 2025-08-11
  - Categories: Features
- **[General Available: App Service Inbound IPv6 Support](<https://azure.microsoft.com/updates?id=499998>)** — Inbound IPv6 support for public multi-tenant App Service is now generally available across all public Azure regions. This feature applies to multi-tenant apps on Basic, Standard, and Premium SKUs, as well as Functions Consumption, Functions Elastic Premium, and Logic Apps Standard.
  - General availability of Inbound IPv6 support
  - Applicable to public multi-tenant App Service
  - Available in all public Azure regions
  - Supports Basic, Standard, and Premium SKUs
  - Includes Functions Consumption, Functions Elastic Premium, and Logic Apps Standard
- **[Announcing GA of Bicep templates support for Microsoft Entra ID resources](https://devblogs.microsoft.com/identity/bicep-templates-for-microsoft-entra-id-resources-is-ga/)** — Bicep templates for Microsoft Entra ID resources are now generally available as of July 29, 2025, providing declarative infrastructure as code capabilities for core Microsoft Entra ID resources.
  - General Availability (GA) of Bicep templates for Microsoft Entra ID resources.
  - Release date: July 29, 2025.
  - Supports declarative infrastructure as code (IaC) for Microsoft Graph resources.
- **[Upsert and Script Activity in Azure Data Factory and Azure Synapse Analytics for Azure Database for PostgreSQL](<https://azure.microsoft.com/updates?id=499748>)** — The Upsert method and Script activity support are now generally available in Azure Data Factory and Azure Synapse Analytics for Azure Database for PostgreSQL, enhancing data management capabilities.
  - General availability of Upsert method and Script activity support.
  - Applicable to Azure Data Factory and Azure Synapse Analytics.
  - Supports Azure Database for PostgreSQL.
  - Release date: August 11, 2025.
- **[Customer-managed keys for Fabric workspaces is now in Public Preview](https://blog.fabric.microsoft.com/en-US/blog/customer-managed-keys-for-fabric-workspaces-available-in-all-public-regions-now-preview/)** — Customer-managed keys for Microsoft Fabric workspaces are now in public preview, available in all public regions as of August 11, 2025. This feature enhances compliance and data protection options for users globally.
  - Feature: Customer-managed keys (CMK)
  - Product: Microsoft Fabric workspaces
  - Availability: Public preview
  - Regions: All public regions
  - Date: August 11, 2025
- **[Introducing support for Workspace Identity Authentication in Fabric Connectors](https://blog.fabric.microsoft.com/en-US/blog/announcing-support-for-workspace-identity-authentication-in-new-fabric-connectors-and-for-dataflow-gen2/)** — Microsoft Fabric has introduced support for Workspace Identity Authentication in Fabric Connectors as of August 11, 2025. This feature aims to simplify credential management and enhance security for data access across organizations.
  - Feature: Workspace Identity Authentication
  - Product: Microsoft Fabric
  - Update Date: August 11, 2025
  - Focus: Security and credential management
  - Excludes: My Workspaces
- **[How Microsoft OneLake seamlessly provides Apache Iceberg support for all Fabric Data](https://blog.fabric.microsoft.com/en-US/blog/how-to-access-your-microsoft-fabric-tables-in-apache-iceberg-format/)** — Microsoft OneLake now supports Apache Iceberg for all data in Microsoft Fabric, enhancing data management capabilities. This update was announced on August 11, 2025.
  - Integration of Apache Iceberg support in Microsoft OneLake.
  - Microsoft Fabric uses Delta Lake as the standard table format.
  - Enhancement aimed at unifying data management in a SaaS environment.

