# 00: Terraform Basics

**Reading Time:** ~15 min  
**Summary:** What is Terraform, installation methods, IDE setup, and first configuration.

## 🧠 Core Concepts

### 1. What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool created by HashiCorp. It allows you to define and provision infrastructure using a declarative configuration language called **HCL** (HashiCorp Configuration Language).

### Key Characteristics
- **Declarative:** You specify *what* you want, not *how* to build it
- **Provider-Based:** Works with AWS, Azure, GCP, Docker, Kubernetes, and 3000+ providers
- **State-Driven:** Maintains a state file to track deployed resources
- **Plan Before Apply:** Preview changes before execution
- **Version Control Friendly:** Code can be committed to Git

---

## 🛠️ Installation

> **Official HashiCorp Installation Methods** - Choose the method that best suits your system.

### macOS

#### Option 1: Homebrew (Recommended)
```bash
# Install HashiCorp tap
brew tap hashicorp/tap

# Install Terraform
brew install hashicorp/tap/terraform
```

#### Option 2: Manual Binary Download
1. Download from [releases.hashicorp.com](https://releases.hashicorp.com/terraform/)
2. Choose your architecture:
   - **AMD64**: For Intel Macs
   - **ARM64**: For Apple Silicon (M1/M2/M3)
3. Extract and move to PATH:
```bash
unzip terraform_*.zip
sudo mv terraform /usr/local/bin/
```

---

### Linux

#### Ubuntu/Debian (Package Manager - Recommended)

**Step 1: Install prerequisites**
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

**Step 2: Install HashiCorp GPG key**
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

**Step 3: Verify GPG key fingerprint**
```bash
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

**Step 4: Add HashiCorp repository**
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```

**Step 5: Install Terraform**
```bash
sudo apt update
sudo apt-get install terraform
```

---

#### RHEL/CentOS (Package Manager)

**Step 1: Install yum-config-manager**
```bash
sudo yum install -y yum-utils
```

**Step 2: Add HashiCorp repository**
```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
```

**Step 3: Install Terraform**
```bash
sudo yum -y install terraform
```

---

#### Fedora (Package Manager)

```bash
# Install dnf config-manager
sudo dnf install -y dnf-plugins-core

# Add HashiCorp repository
sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

# Install Terraform
sudo dnf -y install terraform
```

---

#### Amazon Linux (Package Manager)

```bash
# Install yum-config-manager
sudo yum install -y yum-utils

# Add HashiCorp repository
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum -y install terraform
```

---

#### Manual Binary Download (All Linux Distributions)

**Step 1: Download**
```bash
# Get latest version (check releases.hashicorp.com for current version)
wget https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip
```

**Step 2: Extract**
```bash
unzip terraform_1.7.0_linux_amd64.zip
```

**Step 3: Move to PATH**
```bash
sudo mv terraform /usr/local/bin/
```

**Step 4: Verify permissions**
```bash
chmod +x /usr/local/bin/terraform
```

---

### Windows

#### Option 1: Chocolatey
```powershell
choco install terraform
```

> **Note:** HashiCorp does not maintain the Chocolatey package. For guaranteed latest version, use manual installation.

#### Option 2: Manual Binary Download (Recommended)
1. Download from [releases.hashicorp.com](https://releases.hashicorp.com/terraform/)
2. Extract .zip file
3. Add terraform.exe to your PATH

---

### Verify Installation

After installation, verify Terraform is working:

```bash
terraform version
```

**Expected output:**
```
Terraform v1.7.0
on linux_amd64
```

#### Enable Tab Completion (Optional)

**Bash:**
```bash
terraform -install-autocomplete
```

**Zsh:**
```bash
terraform -install-autocomplete
```

**PowerShell:**
```powershell
terraform -install-autocomplete
```

Then restart your shell.

---

## 🔄 Terraform CLI Commands (Detailed)

### `terraform init` - Initialize Working Directory

Downloads providers, modules, and prepares the backend.

**Basic Usage:**
```bash
terraform init
```

**Common Options:**

| Option | Description | Use Case |
|--------|-------------|----------|
| `-upgrade` | Upgrade providers to latest allowed version | After changing version constraints |
| `-reconfigure` | Reconfigure backend, ignoring saved config | Switching backends (local → S3) |
| `-migrate-state` | Migrate state from old backend to new | Moving state between backends |
| `-backend-config="key=value"` | Set backend configuration | Dynamic backend config (CI/CD) |
| `-get=false` | Don't download modules | Debugging provider issues |
| `-plugin-dir=PATH` | Use custom plugin directory | Offline/air-gapped environments |

**Examples:**
```bash
# Upgrade all providers to latest
terraform init -upgrade

# Reconfigure backend (e.g., switching from local to S3)
terraform init -reconfigure

# Dynamic backend configuration (CI/CD)
terraform init -backend-config="bucket=my-terraform-state"
```

---

### `terraform plan` - Preview Changes

Shows what Terraform will do **without making changes**.

**Basic Usage:**
```bash
terraform plan
```

**Common Options:**

| Option | Description | Use Case |
|--------|-------------|----------|
| `-out=FILE` | Save plan to file | Two-step apply (plan then apply saved plan) |
| `-target=RESOURCE` | Plan only specific resource | Incremental changes, debugging |
| `-var='key=value'` | Set variable value | Override defaults |
| `-var-file=FILE` | Load variables from file | Environment-specific configs |
| `-destroy` | Plan a destroy operation | Preview what destroy will do |
| `-refresh=false` | Don't query real infrastructure | Faster planning (use with caution) |
| `-parallelism=N` | Limit concurrent operations | Avoid API rate limits |
| `-compact-warnings` | Show warnings in compact form | Cleaner output |

**Examples:**
```bash
# Save plan for later apply
terraform plan -out=tfplan

# Plan changes to specific resource only
terraform plan -target=aws_instance.web

# Plan with custom variables
terraform plan -var='instance_type=t2.large'

# Plan using environment-specific variables
terraform plan -var-file=prod.tfvars

# Preview destroy
terraform plan -destroy

# Fast plan (skip refresh)
terraform plan -refresh=false
```

---

### `terraform apply` - Execute Changes

Applies the changes required to reach the desired state.

**Basic Usage:**
```bash
terraform apply
```

**Common Options:**

| Option | Description | Use Case |
|--------|-------------|----------|
| `-auto-approve` | Skip interactive approval | CI/CD pipelines (use carefully!) |
| `-target=RESOURCE` | Apply only specific resource | Incremental deployments |
| `FILE` | Apply a saved plan file | Ensure plan matches apply |
| `-parallelism=N` | Limit concurrent operations | API rate limits |
| `-refresh=false` | Don't update state from real infrastructure | Faster apply (risky) |
| `-replace=RESOURCE` | Force replacement of resource | Fix corrupted resources |

**Examples:**
```bash
# Apply saved plan (recommended for CI/CD)
terraform apply tfplan

# Apply without confirmation (CI/CD only!)
terraform apply -auto-approve

# Apply to specific resource only
terraform apply -target=aws_instance.web

# Force replace a corrupted resource
terraform apply -replace=aws_instance.web
```

---

### `terraform destroy` - Destroy Infrastructure

Deletes all resources managed by Terraform.

**Basic Usage:**
```bash
terraform destroy
```

**Common Options:**

| Option | Description | Use Case |
|--------|-------------|----------|
| `-auto-approve` | Skip confirmation | Scripts, cleanup automation |
| `-target=RESOURCE` | Destroy only specific resource | Selective cleanup |
| `-parallelism=N` | Limit concurrent operations | Avoid overwhelming APIs |

**Examples:**
```bash
# Destroy everything (with confirmation)
terraform destroy

# Destroy without confirmation (dangerous!)
terraform destroy -auto-approve

# Destroy only specific resource
terraform destroy -target=docker_container.web
```

---

### Additional Essential Commands

#### `terraform fmt` - Format Code
```bash
# Format all .tf files in current directory
terraform fmt

# Format recursively
terraform fmt -recursive

# Check if files are formatted (CI/CD)
terraform fmt -check
```

#### `terraform validate` - Validate Configuration
```bash
# Check syntax and internal consistency
terraform validate

# Validate with JSON output
terraform validate -json
```

#### `terraform show` - Inspect State or Plan
```bash
# Show current state
terraform show

# Show saved plan
terraform show tfplan

# Show in JSON format
terraform show -json
```

#### `terraform output` - View Outputs
```bash
# Show all outputs
terraform output

# Show specific output
terraform output instance_ip

# Show in JSON format
terraform output -json

# Show raw value (no quotes)
terraform output -raw instance_ip
```

#### `terraform console` - Interactive Expression Evaluation
```bash
# Start interactive console
terraform console

# Example usage:
> var.instance_type
"t2.micro"

> local.common_tags
{
  "Environment" = "prod"
}
```

#### `terraform refresh` - Update State
```bash
# Sync state with real infrastructure
terraform refresh

# WARNING: Rarely needed in modern Terraform
# Use 'terraform apply -refresh-only' instead
```

#### `terraform graph` - Generate Dependency Graph
```bash
# Generate DOT format graph
terraform graph

# Generate and visualize (requires Graphviz)
terraform graph | dot -Tpng > graph.png
```

---

## 🔌 Understanding Providers

A **provider** is a plugin that enables Terraform to interact with APIs (cloud platforms, SaaS, etc.).

### Provider Block Syntax
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### Common Providers

| Provider | Source | Use Case |
|----------|--------|----------|
| AWS | `hashicorp/aws` | EC2, S3, RDS, etc. |
| Docker | `kreuzwerker/docker` | Containers |
| GitHub | `integrations/github` | Repositories, teams |
| Azure | `hashicorp/azurerm` | Azure resources |
| Google Cloud | `hashicorp/google` | GCP resources |
| Kubernetes | `hashicorp/kubernetes` | K8s clusters |

### Version Constraints

| Constraint | Meaning | Example |
|------------|---------|---------|
| `~> 3.0` | Allow minor updates (3.1, 3.2) but not major (4.0) | Recommended |
| `>= 3.0` | Any version 3.0 or higher | Risky |
| `= 3.0.1` | Exact version only | Very strict |
| `>= 3.0, < 4.0` | Range | Explicit control |

---

## 🔄 Common Workflows

### Workflow 1: Standard Development
```bash
1. Edit .tf files
2. terraform fmt          # Format code
3. terraform validate     # Check syntax
4. terraform plan         # Preview changes
5. terraform apply        # Execute (review first!)
```

### Workflow 2: Saved Plan (CI/CD)
```bash
1. terraform plan -out=tfplan
2. Review plan file
3. terraform apply tfplan  # Exactly what was planned
```

### Workflow 3: Targeted Changes
```bash
# Only update specific resource
terraform plan -target=aws_instance.web
terraform apply -target=aws_instance.web
```

### Workflow 4: Provider Upgrade
```bash
1. Edit version constraint in providers.tf
2. terraform init -upgrade
3. terraform plan          # Check for breaking changes
4. terraform apply
```

---

## 📁 Basic File Structure

```
project/
├── main.tf          # Primary configuration
├── variables.tf     # Input variables (we'll learn this next)
├── outputs.tf       # Output values
├── providers.tf     # Provider configuration
└── .gitignore       # Ignore state files
```

**Minimal Example (main.tf):**
```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}
```

---

## 🔍 Understanding terraform.tfstate

After `terraform apply`, a file called `terraform.tfstate` is created. This file:
- Maps your configuration to real-world resource IDs
- **Contains sensitive data** (API keys, passwords)
- **Must not be committed to Git** (add to `.gitignore`)
- Is the "source of truth" for what's deployed

**Example state snippet:**
```json
{
  "resources": [{
    "type": "docker_container",
    "name": "web",
    "instances": [{
      "attributes": {
        "id": "abc123",
        "name": "my-nginx-container"
      }
    }]
  }]
}
```

---

## 🐛 Troubleshooting Common Issues

### Issue 1: Provider Not Found
```
Error: provider "aws" not found
```
**Solution:** Run `terraform init` to download providers.

### Issue 2: State Lock Error
```
Error: Error acquiring the state lock
```
**Solution:** Someone else is running `terraform apply`. Wait or force unlock (dangerous):
```bash
terraform force-unlock LOCK_ID
```

### Issue 3: Version Constraint Conflict
```
Error: no available releases match the given constraints
```
**Solution:** Check version constraint syntax. Use `terraform init -upgrade`.

### Issue 4: Resource Already Exists
```
Error: resource already exists
```
**Solution:** Import existing resource:
```bash
terraform import aws_instance.web i-1234567890abcdef0
```

### Issue 5: Refresh Errors
```
Error: error reading resource
```
**Solution:** Resource was deleted outside Terraform. Remove from state:
```bash
terraform state rm aws_instance.web
```

---

## ⚠️ Common Beginner Mistakes

1. **Forgetting `terraform init`** after adding a new provider
   - Error: `provider "aws" not found`
   
2. **Not reading the plan** before applying
   - Risk: Accidentally deleting production resources

3. **Committing `terraform.tfstate` to Git**
   - Risk: Exposing secrets

4. **Using `-auto-approve` in production**
   - Best Practice: Always review the plan first

5. **Using `latest` tags in production**
   - Risk: Breaking changes on updates

6. **Not using `-target` carefully**
   - Risk: Can create dependency issues

---

## 💡 Pro Tips

1. **Always use version constraints:** `~> 3.0` instead of no version
2. **Create a .gitignore immediately:**
   ```
   .terraform/
   *.tfstate
   *.tfstate.backup
   *.tfvars
   ```
3. **Use `terraform fmt`** before every commit
4. **Save plans in CI/CD:** `terraform plan -out=tfplan`
5. **Destroy test resources daily** to avoid surprise AWS bills
6. **Use `terraform console`** to debug expressions
7. **Limit parallelism** if hitting API rate limits: `-parallelism=5`

---

## 🎓 Next Steps

Now that you understand Terraform basics:
- [01: Variables & State](01-variables-and-state.md) - Learn how to parameterize your code
- [02: Docker Integration](02-docker-terraform.md) - Deep dive into Docker provider
- [04: AWS EC2](04-aws-ec2.md) - Deploy cloud infrastructure

---

*All code examples are tested and ready to run.*
