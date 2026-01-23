# GitHub Rulesets for Fabric Infrastructure Repository

## Purpose

These rulesets protect the integrity of environment-specific branches and production Fabric workspaces by:

- Ensuring environment isolation (dev changes stay in dev, test in test, prod in prod)
- Requiring appropriate review before infrastructure changes are promoted
- Enforcing CI/CD checks before merging
- Maintaining a clean commit history
- Allowing admins to override rules when necessary

## Branch Strategy

This repository follows an **environment-isolated branch strategy** where each environment has its own independent main branch:

- **`dev`** - Development environment infrastructure configurations
- **`test`** - Test/staging environment infrastructure configurations  
- **`main`** - Production environment infrastructure configurations

**Critical Rule**: Each environment branch is completely independent. Infrastructure configurations differ between environments, so branches should NEVER merge between environments.

### Allowed Merge Patterns

✅ **Merge feature branches to their source environment:**
- `feature/new-workspace-dev` → `dev`
- `feature/new-workspace-test` → `test`
- `feature/new-workspace-prod` → `main`

✅ **Create feature branches from the target environment:**
- Create from `dev` for dev changes
- Create from `test` for test changes
- Create from `main` for production changes

❌ **NEVER merge between environment branches:**
- ❌ Never merge `dev` → `test`
- ❌ Never merge `test` → `main`
- ❌ Never merge `main` → `test` or `dev`
- ❌ Never merge `feature/something-dev` → `test` or `main`

### Rationale for Environment Isolation

Each environment branch contains different infrastructure configurations:
- Different resource names and naming conventions
- Different capacity SKUs and scaling configurations
- Different workspace configurations and Git integrations
- Different tags, owners, and RBAC assignments
- Environment-specific variable values

Merging between environment branches would cause configuration conflicts and could deploy dev-specific resources to production or vice versa.

### Promoting Changes Across Environments

To apply the same logical change across environments:

1. **Make the change in dev first** via feature branch → `dev`
2. **Manually recreate the change** for test environment:
   - Create new feature branch from `test`
   - Apply equivalent configuration changes
   - Open PR to `test`
3. **Manually recreate the change** for production:
   - Create new feature branch from `main`
   - Apply equivalent configuration changes (with prod values)
   - Open PR to `main`

This manual process ensures environment-specific values are correctly applied at each stage.

## Rulesets Overview

### Dev Branch Protection (`dev-branch-ruleset.json`)

**Protection Level**: Basic  
**Purpose**: Enable rapid iteration while maintaining code quality

**Rules**:
- Branch deletion protection
- Required linear history (no merge commits from complex merges)
- 1 approving review required
- Code owner approval required
- CI checks required: `terraform-validate`, `terraform-plan-dev`
- All merge methods allowed (merge, squash, rebase)

**Rationale**: Dev branch allows faster iteration with basic protections. Linear history keeps the branch clean.

### Test Branch Protection (`test-branch-ruleset.json`)

**Protection Level**: Moderate  
**Purpose**: Validate changes in a production-like environment with stricter controls

**Rules**:
- Branch deletion protection
- Block force pushes
- Block branch creation/updates outside of PRs
- Required linear history
- 1 approving review required
- Code owner approval required
- All review threads must be resolved
- Strict status checks (must be up-to-date with base branch)
- CI checks required: `terraform-validate`, `terraform-plan-test`
- Limited merge methods (merge, squash only - no rebase)

**Rationale**: Test branch mirrors production behavior more closely. Strict checks ensure only validated changes proceed.

### Prod/Main Branch Protection (`prod-branch-ruleset.json`)

**Protection Level**: Maximum  
**Purpose**: Protect production infrastructure with comprehensive safeguards

**Rules**:
- Branch deletion protection
- Block force pushes
- Block branch creation/updates outside of PRs
- Block non-fast-forward merges
- Required linear history
- **2 approving reviews required**
- Code owner approval required
- Dismiss stale reviews on new pushes
- Require approval from latest push (prevents self-approval loop)
- All review threads must be resolved
- Strict status checks (must be up-to-date)
- CI checks required: `terraform-validate`, `terraform-plan-prod`, `security-scan`
- Only merge commits allowed (preserves full history)

**Rationale**: Production requires maximum protection. Two reviewers catch issues one might miss. Full history preservation supports audit requirements.

## Bypass Actors
All rulesets allow **Repository Admins** to bypass rules when necessary for:

- Emergency hotfixes
- Breaking build fixes
- Administrative tasks

**Important**: Bypass should be used sparingly and documented in commit messages or incident reports.

## Status Checks

Each environment requires passing CI/CD checks before merge:

| Check | Dev | Test | Prod | Purpose |
|-------|-----|------|------|---------|
| `terraform-validate` | ✓ | ✓ | ✓ | Syntax validation |
| `terraform-plan-dev` | ✓ | - | - | Preview dev changes |
| `terraform-plan-test` | - | ✓ | - | Preview test changes |
| `terraform-plan-prod` | - | - | ✓ | Preview prod changes |
| `security-scan` | - | - | ✓ | Security vulnerability scan |

Configure these checks in your CI/CD pipeline (GitHub Actions, Azure DevOps, etc.).

## CODEOWNERS Configuration

The `.github/CODEOWNERS` file defines automatic review assignments:

- **Platform Engineering** - Reviews all infrastructure code
- **Data Foundations** - Reviews test/prod environment changes
- **Security Team** - Reviews production secrets and sensitive configs
- **DevOps Team** - Reviews CI/CD pipeline changes

Update team names in CODEOWNERS to match your GitHub organization structure.

## How to Apply These Rulesets

### Prerequisites

- Repository admin access
- At least 2 team members with admin role
- GitHub organization teams configured (`platform-engineering`, `datafoundations`, etc.)

### Step-by-Step Application

1. **Save the ruleset files**
   - Download `dev-branch-ruleset.json`
   - Download `test-branch-ruleset.json`
   - Download `prod-branch-ruleset.json`

2. **Update source repository reference**
   - Open each JSON file
   - Replace `"source": "your-org/your-repo"` with your actual org/repo
   - Save changes

3. **Import rulesets to GitHub**
   - Navigate to your repository on GitHub
   - Go to **Settings** → **Rules** → **Rulesets**
   - Click **New ruleset** → **Import a ruleset**
   - Select `dev-branch-ruleset.json`
   - Review the configuration
   - Click **Create**
   - Repeat for `test-branch-ruleset.json` and `prod-branch-ruleset.json`

4. **Add CODEOWNERS file**
   - Create `.github/` directory in repository root if it doesn't exist
   - Copy `CODEOWNERS` file to `.github/CODEOWNERS`
   - Update team names to match your organization
   - Commit and push to main branch

5. **Configure required status checks**
   - Set up CI/CD workflows in `.github/workflows/`
   - Ensure job names match status check contexts in rulesets
   - Test that checks run on pull requests

6. **Verify configuration**
   - Create a test branch: `git checkout -b test/ruleset-validation`
   - Make a small change
   - Open PR to `dev` branch
   - Confirm required reviews and status checks appear
   - Close/delete test PR

### Post-Implementation

1. **Communicate changes** to the team
2. **Document bypass procedures** for emergencies
3. **Monitor** for rule violations or issues
4. **Adjust** as needed based on team feedback

## Branch Workflow Example

### Scenario: Adding a new Fabric workspace to all environments

Since each environment branch is independent, you'll create separate feature branches for each environment.

#### Step 1: Add workspace to Dev environment

1. **Create feature branch from dev**
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/analytics-workspace-dev
   ```

2. **Make changes with dev-specific values**
   ```bash
   # Edit terraform configs with dev environment values
   # Example: capacity SKU = F2, naming prefix = cdd
   git add .
   git commit -m "Add analytics workspace to dev environment"
   git push origin feature/analytics-workspace-dev
   ```

3. **Open PR to dev branch**
   - Request review from code owners
   - Wait for CI checks to pass (`terraform-plan-dev`)
   - Address review feedback
   - Merge once approved

4. **Deploy to dev and validate**
   ```bash
   # CI/CD applies changes to dev environment
   # Team validates workspace functions correctly
   ```

#### Step 2: Add workspace to Test environment

1. **Create NEW feature branch from test** (NOT from dev)
   ```bash
   git checkout test
   git pull origin test
   git checkout -b feature/analytics-workspace-test
   ```

2. **Manually recreate the changes with test-specific values**
   ```bash
   # Apply EQUIVALENT changes with test environment values
   # Example: capacity SKU = F4, naming prefix = cdt, different tags
   git add .
   git commit -m "Add analytics workspace to test environment"
   git push origin feature/analytics-workspace-test
   ```

3. **Open PR to test branch**
   - Review and approve changes
   - Wait for test-specific CI checks (`terraform-plan-test`)
   - Merge once approved and validated

#### Step 3: Add workspace to Production

1. **Create NEW feature branch from main** (NOT from test or dev)
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/analytics-workspace-prod
   ```

2. **Manually recreate the changes with production values**
   ```bash
   # Apply EQUIVALENT changes with production environment values
   # Example: capacity SKU = F8, naming prefix = cdp, production owners/tags
   git add .
   git commit -m "Add analytics workspace to production environment"
   git push origin feature/analytics-workspace-prod
   ```

3. **Open PR to main branch**
   - Requires 2 approvals
   - Security scan must pass
   - Final production validation
   - Merge once approved

### Key Points

- Each environment gets its own feature branch created from that environment's branch
- Changes are manually adapted to each environment's specific configuration
- Never merge `dev` → `test` → `main` as this would copy dev configs to production
- Validate in dev first, then recreate tested changes in test and prod with appropriate values

## Troubleshooting

### "Required status check is failing"
- Check CI/CD pipeline logs
- Ensure Terraform validates successfully
- Run `terraform plan` locally to preview issues

### "CODEOWNERS approval required but no reviewers assigned"
- Verify CODEOWNERS file syntax
- Confirm GitHub teams exist and members have access
- Check team names match exactly (case-sensitive)

### "Cannot force push to protected branch"
- This is expected behavior
- Use normal PR workflow instead
- Admins can bypass if absolutely necessary

### "I accidentally created a PR from dev to test (or test to main)"
- **Close the PR immediately** - Do not merge
- Cross-environment merges will cause configuration conflicts
- Create a new feature branch from the target environment instead
- Manually recreate your changes with environment-specific values

### "I merged dev into test by mistake"
- **Do not deploy** - This will apply dev configs to test environment
- Revert the merge commit immediately
- Assess what configuration damage occurred
- Restore test branch to last known good state
- Recreate intended changes properly via new feature branch from test

### "Need to bypass rules for emergency"
- Document reason in commit message
- Notify team of bypass action
- Create follow-up issue to address properly
- Update runbook if this becomes recurring

## Best Practices

1. **Never merge between environment branches** - Each environment is independent with different configs
2. **Always create feature branches from the target environment** - `dev` features from `dev`, `main` features from `main`
3. **Test in dev first** - Validate logic in dev before recreating in test/prod
4. **Manually adapt changes per environment** - Copy the logic, not the values
5. **Keep PRs focused** - Smaller changes are easier to review and recreate across environments
6. **Write descriptive commits** - Explain why, not just what (helps when recreating in other environments)
7. **Use consistent feature branch naming** - Example: `feature/workspace-name-dev`, `feature/workspace-name-test`, `feature/workspace-name-prod`
8. **Respond to review feedback** - Engage with reviewers constructively
9. **Run terraform plan locally** - Catch issues before CI for each environment
10. **Document environment-specific values** - Makes recreation in other environments easier

## Maintenance

Review and update rulesets quarterly or when:
- Team size changes significantly
- New compliance requirements emerge
- Deployment patterns evolve
- Tool integrations change

## Support

For issues with rulesets:
- Check GitHub documentation on branch protection
- Review audit logs for bypass actions
- Contact platform engineering team
- Create issue in this repository

## References

- [GitHub Rulesets Documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets)
- [CODEOWNERS Syntax](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Branch Protection Best Practices](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
