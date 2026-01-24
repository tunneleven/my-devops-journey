# 01: Variables & State - Parameterization
**Focus:** Stop hardcoding values! Make your Terraform code reusable and clean.

**Time:** 2 hours total

**Resource File:** [01-variables-and-state.md](../../learn/terraform/01-variables-and-state.md)

## 🎯 Objectives
1.  **Master Variable Types:** Go beyond strings. Use `list`, `map`, and `object`.
2.  **Input Validation:** Learn how to reject bad inputs *before* applying.
3.  **Variable Precedence:** Understand which value wins (CLI vs File vs Env).
4.  **Locals:** Use local values for internal logic and cleaner code.
5.  **Outputs:** Expose critical data for other users or modules.
6.  **Real-World Goal:** Push your DevOps learning repo to GitHub using Terraform!

---

## 📚 Study (30 mins)

### Before You Start - Read These Sections

Open the [resource file](../../learn/terraform/01-variables-and-state.md) and read through these core concepts:

1. **[Input Variables](../../learn/terraform/01-variables-and-state.md#️-1-input-variables-variable)** - Full syntax and type system
2. **[The Type System](../../learn/terraform/01-variables-and-state.md#-the-type-system-detailed)** - Understanding all types
3. **[Validation Patterns](../../learn/terraform/01-variables-and-state.md#-validation-rules-advanced-patterns)** - Regex, range, enum
4. **[Variable Precedence](../../learn/terraform/01-variables-and-state.md#-2-variable-precedence-the-hierarchy)** - The 6-level hierarchy
5. **[Locals](../../learn/terraform/01-variables-and-state.md#-3-local-values-locals)** - When to use locals vs variables
6. **[Outputs](../../learn/terraform/01-variables-and-state.md#-4-output-values-output)** - Exposing infrastructure data

**Key Concepts:**
- `variable` = User input (external)
- `locals` = Computed values (internal)

---

## 💻 Lab: Push DevOps Repo to GitHub (1h 30 mins)

**Real-World Goal:** Use Terraform to create a GitHub repository and push your DevOps learning folder to it!

### Prerequisites
1. GitHub account
2. GitHub Personal Access Token (PAT) with `repo` scope
   - Go to: GitHub → Settings → Developer Settings → Personal Access Tokens → Tokens (classic)
   - Generate new token with `repo` scope
   - Save the token securely!

### Project Structure
Create a new folder `terraform-github` in your DevOps directory:

```bash
# From the root of your DevOps repository
cd labs/terraform
mkdir 01-variables-and-state
cd 01-variables-and-state
```

Create these files:
```
01-variables-and-state/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars  # Don't commit this!
```

---

### Step 1: Check `.gitignore`

**Verify your root `.gitignore` already blocks secrets:**

```bash
# Check from repo root
cat ../../../.gitignore
```

Ensure it contains:
```
*.tfvars
*.pem
*.key
.terraform/
```

---

### Step 2: Define Variables (`variables.tf`)

```hcl
variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}

variable "repo_config" {
  type = object({
    name        = string
    description = string
    visibility  = string
  })
  description = "GitHub repository configuration"
  
  validation {
    condition     = contains(["public", "private"], var.repo_config.visibility)
    error_message = "Visibility must be 'public' or 'private'."
  }
}

variable "topics" {
  type        = list(string)
  description = "Repository topics/tags"
  default     = ["terraform", "devops", "learning"]
}

variable "enable_features" {
  type = object({
    issues   = bool
    wiki     = bool
    projects = bool
  })
  description = "Enable/disable repository features"
  default = {
    issues   = true
    wiki     = false
    projects = false
  }
}
```

---

### Step 3: Input Values (`terraform.tfvars`)

**IMPORTANT:** Already in `.gitignore`!

```hcl
github_token = "ghp_YourTokenHere123456789"

repo_config = {
  name        = "DevOps-Learning"
  description = "My DevOps learning journey - Terraform, Docker, AWS, and more!"
  visibility  = "public"
}

topics = ["terraform", "docker", "aws", "devops", "infrastructure-as-code"]

enable_features = {
  issues   = true
  wiki     = false
  projects = false
}
```

---

### Step 4: Implement Logic (`main.tf`)

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

locals {
  # Standardized naming
  repo_name = var.repo_config.name
  
  # Common labels/tags (add year automatically)
  common_topics = concat(var.topics, ["2026"])
  
  # Feature summary
  enabled_features = [
    for feature, enabled in var.enable_features :
    feature if enabled
  ]
}

resource "github_repository" "devops_learning" {
  name        = local.repo_name
  description = var.repo_config.description
  visibility  = var.repo_config.visibility
  
  # Features
  has_issues   = var.enable_features.issues
  has_wiki     = var.enable_features.wiki
  has_projects = var.enable_features.projects
  
  # Best practices
  has_downloads        = true
  auto_init           = false  # We'll push existing content
  allow_merge_commit  = true
  allow_squash_merge  = true
  allow_rebase_merge  = true
  delete_branch_on_merge = true
  
  # Topics
  topics = local.common_topics
}

resource "github_branch_default" "main" {
  repository = github_repository.devops_learning.name
  branch     = "main"
}
```

---

### Step 5: Define Outputs (`outputs.tf`)

```hcl
output "repository_url" {
  value       = github_repository.devops_learning.html_url
  description = "URL to view the repository on GitHub"
}

output "git_clone_url" {
  value       = github_repository.devops_learning.ssh_url
  description = "SSH URL to clone the repository"
}

output "repo_full_name" {
  value       = github_repository.devops_learning.full_name
  description = "Full name of the repository (owner/name)"
}

output "enabled_features" {
  value       = local.enabled_features
  description = "List of enabled repository features"
}

output "push_instructions" {
  value = <<-EOT
    
    🎉 Repository created! Now push your DevOps folder:
    
    cd ..  # Go back to DevOps root directory
    git init
    git add .
    git commit -m "Initial commit: DevOps learning journey"
    git branch -M main
    git remote add origin ${github_repository.devops_learning.ssh_url}
    git push -u origin main
    
    View at: ${github_repository.devops_learning.html_url}
  EOT
  description = "Instructions to push your local repo"
}
```

---

---

### Step 6: Execute the Lab

**The Standard Workflow:**
1. Use Terraform to create infrastructure (Repo)
2. Use Git to manage code (Push)

```bash
# === PART 1: Infrastructure (Terraform) ===

# 1. Initialize
terraform init

# 2. Plan and review
terraform plan

# 3. Create the repository
terraform apply

# 4. View outputs
terraform output
```

```bash
# === PART 2: Code (Git) ===

# 5. Follow the instructions from output
terraform output -raw push_instructions

# 6. Execute git commands (copying from output)
cd ..  # Go back to DevOps root directory
git init
git add .
git commit -m "Initial commit: DevOps learning journey"
git branch -M main

# Add remote (use the URL from terraform output)
git remote add origin <SSH_URL_FROM_OUTPUT>

# Push code
git push -u origin main
```

---

## 🔬 Verification (15 mins)

**Reference:** [Terraform Output Commands](../../learn/terraform/01-variables-and-state.md#terraform-output-commands)

1.  **Test Validation:**
    ```bash
    # Temporarily change visibility to "internal" in terraform.tfvars
    # Run: terraform plan
    # Expected: Error "Visibility must be 'public' or 'private'."
    ```

2.  **Test Precedence:**
    ```bash
    # Override repo name via CLI
    terraform plan -var='repo_config={name="CLI-Override",description="test",visibility="public"}'
    # Check plan output - should show "CLI-Override"
    ```

3.  **Check Outputs:**
    ```bash
    terraform output
    # Verify repository_url is displayed
    # Verify github_token is NOT shown (it's sensitive in provider)
    ```

4.  **Verify on GitHub:**
    - Open `repository_url` from outputs
    - Check topics include "terraform", "docker", "aws", "devops", "2026"
    - Verify issues enabled, wiki disabled
    - Confirm your DevOps files are visible

## 📝 Checklist
- [ ] Created `terraform-github` project folder
- [ ] `.gitignore` created with terraform.tfvars excluded
- [ ] `variables.tf` uses `object` type and `validation` block
- [ ] `locals` used for computed values (topics, enabled features)
- [ ] Terraform successfully created GitHub repository
- [ ] Manually pushed DevOps folder using Git commands
- [ ] Repository visible on GitHub with correct settings

---

## 🧠 Knowledge Check

Can you answer these without looking?

1. What are the 6 levels of variable precedence (high to low)?
2. When should you use `locals` vs `variable`?
3. How do you validate that a variable matches a regex pattern?
4. What's the difference between `sensitive = true` and hiding data from state?
5. What command lets you interactively test expressions?

**Answers:** [Resource File](../../learn/terraform/01-variables-and-state.md)

---

## 💡 Pro Tips

1. **Use `terraform console`** to test expressions before coding
2. **Validation is free testing** - catch errors at plan time, not apply time  
3. **`sensitive = true`** only hides from CLI, NOT from state file
4. **Document your variables** - fill in the `description` field
5. **Use `.auto.tfvars`** for environment-specific configs
6. **Terraform ≠ Git** - Use Terraform for infrastructure, Git for code (not both!)
7. **Create `.gitignore` FIRST** - never commit secrets!

---

## 🎯 Next Day
[02: Docker & Terraform](02-docker-terraform.md) - Deep dive into container infrastructure
