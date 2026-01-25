# 01: Variables & State - Parameterization
**Focus:** Stop hardcoding values! Make your Terraform code reusable and clean.

**Time:** 2.5 hours total

**Resource File:** [01-variables-and-state.md](../../learn/terraform/01-variables-and-state.md)

## 🎯 Objectives
1.  **Master Variable Types:** Go beyond strings. Use `list`, `map`, and `object`.
2.  **Input Validation:** Learn how to reject bad inputs *before* applying.
3.  **Variable Precedence:** Understand which value wins (CLI vs File vs Env).
4.  **Locals:** Use local values for internal logic and cleaner code.
5.  **Outputs:** Expose critical data for other users or modules.
6.  **State Awareness:** Understand what Terraform stores and why it matters.
7.  **Real-World Goal:** Push your DevOps learning repo to GitHub using Terraform!

---

## 📚 Study (30 mins)

### Before You Start - Read These Sections

Open the [resource file](../../learn/terraform/01-variables-and-state.md) and read through these core concepts:

1. **[Input Variables](../../learn/terraform/01-variables-and-state.md#1-input-variables-variable)** - Full syntax and type system
2. **[The Type System](../../learn/terraform/01-variables-and-state.md#-the-type-system-detailed)** - Understanding all types (`string`, `list`, `map`, `object`)
3. **[Validation Rules](../../learn/terraform/01-variables-and-state.md#-validation-rules-advanced-patterns)** - Regex, range, enum patterns
4. **[Variable Precedence](../../learn/terraform/01-variables-and-state.md#-2-variable-precedence-the-hierarchy)** - The 6-level hierarchy
5. **[Locals](../../learn/terraform/01-variables-and-state.md#-3-local-values-locals)** - When to use locals vs variables
6. **[Outputs](../../learn/terraform/01-variables-and-state.md#-4-output-values-output)** - Exposing infrastructure data
7. **[Terraform State](../../learn/terraform/01-variables-and-state.md#-5-terraform-state-the-brain)** - What's stored and why it's sensitive

**Key Concepts:**
- `variable` = User input (external)
- `locals` = Computed values (internal)
- `terraform.tfstate` = Terraform's memory (NEVER commit!)

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
Create a new folder `01-variables-and-state` in your labs/terraform directory:

```bash
cd labs/terraform
mkdir 01-variables-and-state
cd 01-variables-and-state
```

Create these files:
```
01-variables-and-state/
├── main.tf
├── variables.tf
├── locals.tf
├── outputs.tf
└── terraform.tfvars  # Don't commit this!
```

---

### Step 1: Check `.gitignore`

**Verify your root `.gitignore` already blocks secrets:**

```bash
cat ../../../.gitignore
```

Ensure it contains:
```
*.tfvars
*.pem
*.key
.terraform/
terraform.tfstate*
```

> **Important:** Also block `terraform.tfstate*` - state files contain sensitive data!

---

### Step 2: Explore with `terraform console`

Before writing any code, practice with the console:

```bash
# Start interactive console (no init needed for expressions)
terraform console
```

Try these expressions:
```hcl
> length("hello")
5

> contains(["a", "b", "c"], "b")
true

> concat(["one", "two"], ["three"])
["one", "two", "three"]

> can(regex("^ami-", "ami-123"))
true

> can(regex("^ami-", "invalid"))
false
```

Type `exit` when done. This skill helps you test before coding!

---

### Step 3: Define Variables (`variables.tf`)

#### Variable 1: `github_token`
| Attribute | Value |
|-----------|-------|
| Type | `string` |
| Sensitive | `true` |
| Description | "GitHub Personal Access Token" |

---

#### Variable 2: `repo_config` (Object with Multiple Validations)
| Attribute | Value |
|-----------|-------|
| Type | `object` with 3 attributes: `name` (string), `description` (string), `visibility` (string) |

**Validations to add (use multiple `validation` blocks):**

1. **Name validation:** Use `can()` + `regex()` to ensure `name` is 1-100 characters and contains only letters, numbers, underscores, hyphens
   - Pattern: `^[a-zA-Z0-9_-]{1,100}$`
   - Reference: [Pattern 1: Regex Validation](../../learn/terraform/01-variables-and-state.md#pattern-1-regex-validation-regex--can)

2. **Visibility validation:** Use `contains()` to ensure `visibility` is either "public" or "private"
   - Reference: [Pattern 3: Enum/Membership](../../learn/terraform/01-variables-and-state.md#pattern-3-enummembership-contains)

---

#### Variable 3: `topics`
| Attribute | Value |
|-----------|-------|
| Type | `list(string)` |
| Default | `["terraform", "devops", "learning"]` |
| Description | "Repository topics/tags" |

---

#### Variable 4: `enable_features` (Object of Bools)
| Attribute | Value |
|-----------|-------|
| Type | `object` with 3 boolean attributes: `issues`, `wiki`, `projects` |
| Default | issues=true, wiki=false, projects=false |

---

#### Variable 5: `extra_tags` (Map Exercise)
| Attribute | Value |
|-----------|-------|
| Type | `map(string)` |
| Default | `{ "ManagedBy" = "Terraform", "Course" = "DevOps" }` |
| Description | "Additional metadata tags" |

**Validation:** Use `contains()` + `keys()` to ensure the map always has a "ManagedBy" key.
- Reference: [Pattern 8: Map Keys](../../learn/terraform/01-variables-and-state.md#pattern-8-map-keys-keys--contains)

---

### Step 4: Input Values (`terraform.tfvars`)

**IMPORTANT:** Already in `.gitignore`!

Create the tfvars file with values for all 5 variables:
- Your real GitHub token
- A repo config object with your desired name, description, and visibility
- Your chosen topics list
- Your feature preferences
- Your extra tags map

---

### Step 5: Implement Logic (`main.tf` + `locals.tf`)

#### In `main.tf`:

1. **Provider Configuration:**
   - Required provider: `integrations/github` version `~> 6.0`
   - Configure with your token variable

2. **Resource: `github_repository`**
   - Use locals for the name (see below)
   - Map `enable_features` object attributes to: `has_issues`, `has_wiki`, `has_projects`
   - Set best practices: `auto_init = false`, enable all merge types
   - Apply topics from locals

3. **Resource: `github_branch_default`**
   - Set default branch to "main"

---

#### In `locals.tf`:

Create these local values:

| Local | Logic |
|-------|-------|
| `repo_name` | Reference from `var.repo_config.name` |
| `common_topics` | Use `concat()` to merge `var.topics` with `["2026"]` |
| `all_tags` | Use `merge()` to combine `var.extra_tags` with `{ "Year" = "2026" }` |

---

### Step 6: Define Outputs (`outputs.tf`)

Create these outputs:

| Output Name | Value | Description |
|-------------|-------|-------------|
| `repository_url` | `.html_url` | URL to view the repository on GitHub |
| `git_clone_url` | `.ssh_clone_url` | SSH URL to clone the repository |
| `repo_full_name` | `.full_name` | Full name (owner/name) |
| `all_tags` | `local.all_tags` | Combined tags map |
| `push_instructions` | Heredoc with git commands | Instructions to push your local repo |

> **Note:** The SSH clone attribute is `ssh_clone_url` (NOT `ssh_url`)

For `push_instructions`, use a heredoc (`<<-EOT`) that includes:
- `git init`, `git add .`, `git commit`
- `git branch -M main`
- `git remote add origin ${...ssh_clone_url}`
- `git push -u origin main`

---

### Step 7: Execute the Lab

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
git remote add origin <SSH_CLONE_URL_FROM_OUTPUT>

# Push code
git push -u origin main
```

---

### Step 8: Understand Terraform State

After `terraform apply`, a `terraform.tfstate` file is created. **Explore it:**

```bash
# View the state file (it's JSON)
cat terraform.tfstate | head -50
```

**What you'll see:**
- Resource IDs (e.g., your GitHub repo ID)
- All attribute values Terraform tracks
- Provider metadata

> ⚠️ **CRITICAL:** This file contains your **github_token** in plain text! That's why we add `terraform.tfstate*` to `.gitignore`.

**Key State Concepts:**
- Terraform uses this file to know what exists in the real world
- It compares state vs. your code to calculate changes
- For teams, use **remote state** (S3, Terraform Cloud) with **locking**

---

## 🔬 Verification (15 mins)

1.  **Test Validation (Name - Regex with `can()`):**
    ```bash
    # Change repo name to "invalid name with spaces" in terraform.tfvars
    # Run: terraform plan
    # Expected: Error about invalid characters
    ```

2.  **Test Validation (Visibility - `contains()`):**
    ```bash
    # Change visibility to "internal" in terraform.tfvars
    # Run: terraform plan
    # Expected: Error "Visibility must be 'public' or 'private'."
    ```

3.  **Test Validation (Map - required key):**
    ```bash
    # Remove "ManagedBy" from extra_tags in terraform.tfvars
    # Run: terraform plan
    # Expected: Error about missing "ManagedBy" key
    ```

4.  **Test Precedence:**
    ```bash
    # Override repo name via CLI
    terraform plan -var='repo_config={name="CLI-Override",description="test",visibility="public"}'
    # Check plan output - should show "CLI-Override"
    ```

5.  **Check Outputs:**
    ```bash
    terraform output
    # Verify repository_url is displayed
    # Verify github_token is NOT shown (it's sensitive)
    ```

6.  **Verify State Security:**
    ```bash
    # Check that state is NOT tracked by git
    git status terraform.tfstate
    # Expected: Should show as untracked or not listed
    ```

7.  **Verify on GitHub:**
    - Open `repository_url` from outputs
    - Check topics include your list + "2026"
    - Verify issues enabled, wiki disabled
    - Confirm your DevOps files are visible

## 📝 Checklist
- [ ] Practiced expressions in `terraform console`
- [ ] Created `01-variables-and-state` project folder
- [ ] `.gitignore` blocks terraform.tfvars AND terraform.tfstate*
- [ ] `variables.tf` uses `object`, `list`, AND `map` types
- [ ] `variables.tf` has **3 validation blocks** (regex, contains, keys)
- [ ] `locals` used for computed values (`concat`, `merge`)
- [ ] Terraform successfully created GitHub repository
- [ ] Explored `terraform.tfstate` and understand its sensitivity
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
6. Why should you never commit `terraform.tfstate` to git?

**Answers:** [Resource File](../../learn/terraform/01-variables-and-state.md)

---

## 💡 Pro Tips

1. **Use `terraform console`** to test expressions before coding
2. **Validation is free testing** - catch errors at plan time, not apply time  
3. **`sensitive = true`** only hides from CLI, NOT from state file
4. **Document your variables** - fill in the `description` field
5. **Use `.auto.tfvars`** for environment-specific configs
6. **Terraform ≠ Git** - Use Terraform for infrastructure, Git for code (not both!)
7. **Create `.gitignore` FIRST** - never commit secrets or state!
8. **Remote state for teams** - Use S3 + DynamoDB for state locking

---

## 🎯 Next Day
[02: Docker & Terraform](02-docker-terraform.md) - Deep dive into container infrastructure
