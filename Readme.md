# Fabric Infrastructure as Code
![intro](<documentation/Terraform Submodules Fabric.drawio (1).svg>)
## Why This Exists

Managing Microsoft Fabric infrastructure manually through the Azure portal doesn't scale. As our analytics platform grows, we need a way to provision and manage dozens of workspaces, capacities, and supporting resources consistently across environments. Manual processes lead to configuration drift, inconsistent naming, missing tags, and deployment errors that slow down teams.

This repository solves these problems by treating infrastructure as code. Every resource is defined in version-controlled configuration files, deployed automatically, and tracked through GitHub. This means we can spin up new environments in minutes, enforce organizational standards, and maintain a complete audit trail of every infrastructure change.

## What This Repository Manages

This is the single source of truth for our Microsoft Fabric infrastructure:

- **Azure Resource Groups** - Organizational containers for Fabric resources
- **Fabric Capacities** - The compute resources that power workspaces (F2, F4, F8, etc.)
- **Fabric Workspaces** - Analytics environments where teams build solutions
- **Git Integration** - Version control connections for workspace items (notebooks, pipelines, reports)

## The Technology Stack

### Terraform

Terraform is our infrastructure automation tool. It reads our configuration files, compares them to what exists in Azure, and makes the necessary changes to bring infrastructure into the desired state. Think of it as declarative infrastructure - we describe what we want, and Terraform figures out how to make it happen.

### GitHub

All infrastructure code lives in GitHub. This gives us version control, change tracking, code review workflows, and integration with CI/CD pipelines. Every change goes through a pull request with appropriate reviews before being applied to production.

### Git Submodules

We use Git submodules to organize reusable Terraform modules. Each module (resource groups, capacities, workspaces) lives in its own repository and can be versioned independently. This allows us to share common infrastructure patterns across teams and projects while maintaining clear ownership and release cycles.

The submodule approach means:
- Changes to modules are isolated and versioned
- Multiple projects can reference the same module code
- Module updates are explicit and controlled via submodule version pinning
- Teams can contribute improvements back to shared modules

## How It Works

### Infrastructure as Code Principles

Instead of clicking through Azure portals, we define infrastructure in `.tf` files using Terraform's declarative syntax. These files describe the desired end state, and Terraform handles the actual API calls to Azure and Fabric. This approach provides:

- **Repeatability** - Deploy identical environments every time
- **Version Control** - Track who changed what and when
- **Code Review** - Infrastructure changes go through the same review process as application code
- **Automation** - CI/CD pipelines can deploy infrastructure automatically
- **Documentation** - The code itself documents how infrastructure is configured

### Module Architecture

We've organized our code into reusable modules that act as templates:

**Resource Group Module** - Standard Azure resource groups with naming conventions and tagging
**Fabric Capacity Module** - Fabric compute resources with SKU sizing and ownership configuration  
**Fabric Workspace Module** - Workspace creation with capacity assignment, RBAC, and optional Git integration

These modules are referenced via Git submodules, allowing us to version and share them across different infrastructure repositories.

### VCS Integration for Workspaces

When we provision a Fabric workspace through this repository, we can optionally connect it to a GitHub repository. This links the workspace to version control so that workspace items (notebooks, semantic models, data pipelines) are automatically backed up and versioned in Git. Teams can then use standard Git workflows - branches, pull requests, merges - to manage changes to their analytics artifacts.

## Repository Structure

```
nr-dap-fabric-ci/build
├── artifacts                        # resources are created and managed
├── modules/azure                    # Git submodules for reusable 
│   ├── resource-group/              # Submodule for RG provisioning
│   ├── fabric_rm_capacity/          # Submodule for capacity management
│   └── fabric_workspace/            # Submodule for workspace creation
└── README.md
```

## Workflow

### Making Infrastructure Changes

1. **Branch** - Create a feature branch from main
2. **Modify** - Update Terraform configurations or module references
3. **Plan** - Run `terraform plan` to preview changes
4. **Review** - Open a pull request for team review
5. **Apply** - Merge triggers automated deployment via CI/CD

### Provisioning New Resources

To create a new Fabric workspace, you add a module reference to the appropriate environment configuration:

```hcl
module "analytics_workspace" {
  source = "./modules/fabric-workspace"
  
  workspace_name = "team-analytics-workspace"
  capacity_id    = module.fabric_capacity.id
  owners         = ["team@company.com"]
  
  enable_git_integration = true
  git_repository         = "analytics-artifacts"
}
```

Terraform handles the actual provisioning, role assignments, and Git integration setup.

## Key Benefits

**Consistency** - Every workspace is configured the same way, following organizational standards for naming, tagging, and permissions.

**Speed** - Provisioning a new workspace with full Git integration takes minutes instead of hours of manual clicking.

**Auditability** - Every infrastructure change is tracked in Git with author, timestamp, and reason.

**Reliability** - Infrastructure is tested in dev/test before reaching production, and can be rolled back via Git if issues arise.

**Reusability** - Modules are shared across teams via Git submodules, so improvements benefit everyone.

**Collaboration** - Infrastructure changes go through code review, bringing more eyes to potential issues.

## Getting Started

To work with this repository:

1. Clone the repo with submodules: `git clone --recursive <repo-url>`
2. Initialize Terraform: `terraform init`
3. Select an environment: `terraform workspace select dev`
4. Make changes to configuration files
5. Preview changes: `terraform plan`
6. Apply changes: `git commit -am 'add the reason for change' 'git push'`

For detailed module usage and configuration options, see the README in each module's subdirectory.

## Contributing

Infrastructure changes should follow the standard development workflow - branch, modify, review, merge. All changes require at least one approval from a platform engineering team member. Refer to individual module documentation for specific configuration parameters and best practices.
