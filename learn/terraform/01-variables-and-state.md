# 01: Variables & State

**Reading Time:** ~20 min  
**Summary:** Input variables, type system, validation rules, locals, outputs, and state management.

## 🧠 Core Concepts

### 1. Input Variables (`variable`)

Variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's own source code.

### Full Block Syntax
```hcl
variable "image_id" {
  type        = string
  default     = "ami-123456"
  description = "The id of the machine image (AMI) to use for the server."
  
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }

  sensitive = false  # If true, suppresses output in CLI
  nullable  = false  # If false, null values are rejected
}
```

### 🧠 The Type System (Detailed)

| Type | Description | Example | When to Use |
| :--- | :--- | :--- | :--- |
| **`string`** | A sequence of Unicode characters. | `"t2.micro"` | Names, IDs, single values |
| **`number`** | A numeric value (integer or float). | `5`, `3.1415` | Counts, sizes, ports |
| **`bool`** | A boolean value. | `true`, `false` | Feature flags, toggles |
| **`list(T)`** | Ordered sequence of type T. | `["us-east-1a", "us-east-1b"]` | Availability zones, CIDR blocks |
| **`set(T)`** | Unordered unique values of type T. | `[1, 2, 3]` | IAM policies, security groups |
| **`map(T)`** | Key-value pairs of type T. | `{ Owner = "DevOps" }` | Tags, configuration options |
| **`object({...})`** | Structured type with named attributes. | `object({ name=string, count=number })` | Complex configuration blocks |
| **`tuple([...])`** | Ordered elements of different types. | `["a", 1, true]` | Fixed-structure data |
| **`any`** | Placeholder allowing any type. | ⚠️ **Avoid** | Only for generic reusable modules |

### 🔍 Validation Rules (Advanced Patterns)

Terraform supports **any built-in function** in validation conditions, provided it is "pure" (depends only on the variable) and evaluates to `true` or `false`.

#### Pattern 1: Regex Validation (`regex` + `can`)
```hcl
variable "instance_type" {
  type     = string
  nullable = false
  validation {
    # can() catches errors if regex fails to match
    condition     = can(regex("^t[23]\\.(micro|small|medium)$", var.instance_type))
    error_message = "Instance type must be t2 or t3 family, micro/small/medium only."
  }
}
```

#### Pattern 2: Range Checking (Comparison Operators)
```hcl
variable "disk_size" {
  type     = number
  nullable = false
  validation {
    condition     = var.disk_size >= 20 && var.disk_size <= 100
    error_message = "Disk size must be between 20 and 100 GB."
  }
}
```

#### Pattern 3: Enum/Membership (`contains`)
```hcl
variable "environment" {
  type     = string
  nullable = false
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
```

#### Pattern 4: String Length (`length`)
```hcl
variable "project_name" {
  type     = string
  nullable = false
  validation {
    condition     = length(var.project_name) >= 3 && length(var.project_name) <= 20
    error_message = "Project name must be 3-20 characters."
  }
}
```

#### Pattern 5: Prefix/Suffix (`startswith`, `endswith`)
```hcl
variable "image_id" {
  type     = string
  nullable = false
  validation {
    condition     = startswith(var.image_id, "ami-")
    error_message = "Image ID must start with 'ami-'."
  }
}
```

#### Pattern 6: List Element Validation (`alltrue`)
```hcl
variable "ports" {
  type     = list(number)
  nullable = false
  validation {
    # Checks EVERY item in the list
    condition     = alltrue([for p in var.ports : p > 0 && p <= 65535])
    error_message = "All ports must be valid (1-65535)."
  }
}
```

#### Pattern 7: Any Element Validation (`anytrue`)
```hcl
variable "tags" {
  type     = list(string)
  nullable = false
  validation {
    # Checks if AT LEAST ONE item validates
    condition     = anytrue([for tag in var.tags : length(tag) > 0])
    error_message = "At least one non-empty tag is required."
  }
}
```

#### Pattern 8: Map Keys (`keys` + `contains`)
```hcl
variable "resource_tags" {
  type     = map(string)
  nullable = false
  validation {
    condition     = contains(keys(var.resource_tags), "Environment")
    error_message = "Tags map must contain the 'Environment' key."
  }
}
```

#### Pattern 9: Type Conversion Check (`try` / `can`)
```hcl
variable "raw_timestamp" {
  type     = string
  nullable = false
  validation {
    # Verifies if string CAN be parsed as a timestamp
    condition     = can(formatdate("YYYY-MM-DD", var.raw_timestamp))
    error_message = "Must be a valid RFC 3339 timestamp string."
  }
}
```

---

### 🗝️ Deep Dive: The `can()` Function

The `can()` function is the MVP of validation. It evaluates an expression and returns `true` if it works, or `false` if it produces an error.

**Why is this critical?**
Validation conditions **MUST** return a boolean. If you write a condition that crashes (e.g., `regex` failing to match), Terraform halts with a system error. `can()` catches that crash and converts it to `false`.

#### Without `can()` (CRASH)
```hcl
condition = regex("^ami-", var.id) 
# If var.id is "foo", regex() ERRORS. Terraform crashes.
```

#### With `can()` (SAFE)
```hcl
condition = can(regex("^ami-", var.id)) 
# If var.id is "foo", regex() errors, can() catches it and returns FALSE.
# Terraform displays your 'error_message'.
```

**Use `can()` when:**
1.  Using `regex()` (it errors on no match).
2.  Accessing object attributes that might not exist (`var.config.setting`).
3.  Converting types (`tonumber("abc")` errors).

---

## 🏆 2. Variable Precedence (The Hierarchy)

When a variable is defined in multiple places, Terraform resolves the value using this strict order (Highest to Lowest):

| Priority | Source | Example | Notes |
| :---: | :--- | :--- | :--- |
| **1** | **CLI Flags** | `-var="foo=bar"` | Overrides everything |
| **2** | **CLI Variable Files** | `-var-file="prod.tfvars"` | Can specify multiple |
| **3** | **`*.auto.tfvars`** | `production.auto.tfvars` | Loaded automatically (alphabetical) |
| **4** | **`terraform.tfvars`** | Standard file | Loaded automatically |
| **5** | **Environment Variables** | `export TF_VAR_region=us-west-2` | Prefixed with `TF_VAR_` |
| **6** | **Default Value** | `default = "t2.micro"` | Fallback |

> **CRITICAL:** If no value is found in steps 1-6, Terraform will **interactively prompt** you on the command line during `plan` or `apply`.

### Variable File Formats

#### `.tfvars` Format (HCL)
```hcl
# terraform.tfvars
region        = "us-east-1"
instance_type = "t2.micro"
tags = {
  Environment = "prod"
  Team        = "platform"
}
```

#### `.tfvars.json` Format
```json
{
  "region": "us-east-1",
  "instance_type": "t2.micro",
  "tags": {
    "Environment": "prod",
    "Team": "platform"
  }
}
```

#### `*.auto.tfvars` Format
Files ending in `.auto.tfvars` are **automatically loaded** by Terraform without needing a `-var-file` flag. They are processed in **alphabetical order**.

**Common Use Cases:**
1.  **`secret.auto.tfvars`** (Gitignored): For local API keys and passwords.
2.  **`backend.auto.tfvars`**: For S3 bucket settings that shouldn't change.
3.  **`global.auto.tfvars`**: For company-wide constants.

**Example (`secret.auto.tfvars`):**
```hcl
db_password = "super-secret-password-123"
api_key     = "xyz-999-abc"
```

---

## 📍 3. Local Values (`locals`)

A local value assigns a name to an expression, so you can use it multiple times within a module without repeating it.

### Syntax & Practical Examples
```hcl
locals {
  # Simple constants
  service_name = "forum"
  owner        = "Community Team"
  
  # Computed values
  full_name = "${var.project}-${var.environment}"
  
  # Date/Time operations
  backup_time = formatdate("YYYY-MM-DD-hhmm", timestamp())
  
  # Merging tags
  common_tags = {
    Service     = local.service_name
    Owner       = local.owner
    ManagedBy   = "Terraform"
    Environment = var.environment
  }
  
  # Conditional logic
  instance_count = var.environment == "prod" ? 3 : 1
  
  # String manipulation
  resource_prefix = lower(replace(var.project_name, " ", "-"))
}
```

### Variables vs Locals Decision Tree
```
Need input from user/CI/parent module? 
    YES → Use `variable`
    NO  → Is it a constant or computed value?
        Constant/Computed → Use `locals`
```

---

## 📤 4. Output Values (`output`)

Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use.

### Full Syntax
```hcl
output "instance_ip_addr" {
  value       = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
  
  sensitive   = true # Hides value from CLI output
  
  # Advanced: Conditional & Dynamic Outputs
  depends_on = [aws_security_group.allow_ssh]
}
```

### Practical Output Patterns

#### Pattern 1: Connection Strings
```hcl
output "ssh_command" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.web.public_ip}"
  description = "Command to SSH into the instance"
}
```

#### Pattern 2: URLs
```hcl
output "website_url" {
  value = "https://${aws_instance.web.public_ip}"
  description = "URL to access the web application"
}
```

#### Pattern 3: Resource IDs (for other modules)
```hcl
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID for use in other modules"
}
```

### `terraform output` Commands
| Command | Purpose | Example Output |
| :--- | :--- | :--- |
| `terraform output` | All outputs (human-readable) | `instance_ip = "52.12.34.56"` |
| `terraform output instance_ip` | Specific output | `52.12.34.56` |
| `terraform output -json` | All outputs (JSON) | `{"instance_ip":{"value":"52.12.34.56"}}` |
| `terraform output -raw instance_ip` | Raw value (no quotes) | `52.12.34.56` |

---

## 🧠 5. Terraform State (The Brain)

Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

### Key Purposes
1.  **Mapping to the Real World:** Terraform needs to know that `aws_instance.web` in your code corresponds to `i-0f7236d91ccf` in AWS.
2.  **Metadata:** It tracks dependencies (Resource A needs Resource B).
3.  **Performance:** Caching attribute values to avoid querying API for every attribute every time.
4.  **Syncing:** In a team, remote state ensures everyone is working on the same version of reality.

### State File Structure (Simplified)
```json
{
  "version": 4,
  "terraform_version": "1.5.0",
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web",
      "instances": [{
        "attributes": {
          "id": "i-0f7236d91ccf",
          "public_ip": "52.12.34.56"
        }
      }]
    }
  ]
}
```

### State Locking
*   **What is it?** Prevents concurrent `terraform apply` operations from corrupting the state file.
*   **Local Backend:** Uses file system locks (single developer).
*   **Remote Backend (S3):** Uses **DynamoDB** table for locking (team collaboration).

---

## 🛠️ Essential Functions Reference
These are built-in functions you will use constantly in variables and locals.

### String Functions
| Function | Description | Example |
| :--- | :--- | :--- |
| `lower(string)` | Converts to lowercase | `lower("PROD")` → `"prod"` |
| `upper(string)` | Converts to uppercase | `upper("dev")` → `"DEV"` |
| `substr(string, start, len)` | Extract substring | `substr("ami-123", 0, 3)` → `"ami"` |
| `format(spec, ...)` | Printf-style formatting | `format("server-%02d", 5)` → `"server-05"` |

### Collection Functions
| Function | Description | Example |
| :--- | :--- | :--- |
| `length(collection)` | Number of items | `length(["a", "b"])` → `2` |
| `merge(map1, map2)` | Combine maps | `merge({a=1}, {b=2})` → `{a=1, b=2}` |
| `concat(list1, list2)` | Join lists | `concat([1], [2])` → `[1, 2]` |
| `contains(list, value)` | Check membership | `contains(["a"], "a")` → `true` |

### Validation Functions
| Function | Description | Example |
| :--- | :--- | :--- |
| `can(expression)` | Test if expression succeeds | `can(regex("^t2", "t2.micro"))` → `true` |
| `regex(pattern, string)` | Match regex pattern | Returns match or error |

---

## 🐛 Common Errors & Troubleshooting

### Error 1: Variable Not Declared
```
Error: Reference to undeclared input variable
```
**Cause:** You used `var.foo` but didn't define `variable "foo" {}` in `variables.tf`.
**Fix:** Add the variable declaration.

### Error 2: Type Mismatch
```
Error: Invalid value for input variable
```
**Cause:** You passed a string when the variable expects a number.
**Fix:** Check `type` in variable block matches your input.

### Error 3: Validation Failed
```
Error: Invalid value for variable
╷
│ Disk size must be between 20 and 100 GB.
```
**Cause:** Your input violated the `validation` condition.
**Fix:** Provide a value that meets the validation criteria.

### Error 4: Missing Required Variable
```
Error: No value for required variable
```
**Cause:** Variable has no `default` and you didn't provide a value.
**Fix:** Either add a `default` or provide value via `-var`, `.tfvars`, or environment variable.

---

## 💻 Using `terraform console` (Interactive Debugging)

The `terraform console` command provides an interactive console for evaluating expressions.

### Usage Examples
```bash
$ terraform console
> var.instance_type
"t2.micro"

> local.common_tags
{
  "Environment" = "prod"
  "Owner" = "DevOps"
}

> length(var.availability_zones)
3

> format("server-%02d", 5)
"server-05"

> can(regex("^t2", "t2.micro"))
true
```

**Pro Tip:** Use `terraform console` to test complex expressions before putting them in your code!

---

## 🧙‍♂️ Pro Tips

1.  **The "Any" Trap:** Never use `type = any` unless absolutely necessary. It disables all type checking and makes debugging harder.

2.  **Validation is Free Testing:** Use `validation {}` blocks liberally. Catching errors at `plan` time is infinitely better than at `apply` time.
    *   *Bad:* Waiting 4 minutes for AWS to say "Invalid Instance Type".
    *   *Good:* Terraform says "Error: Invalid Type" in 1 second.

3.  **Hiding Secrets:** `sensitive = true` only hides values from CLI output. They are **STILL VISIBLE** in `terraform.tfstate`. **Never commit state files to Git.**

4.  **Use `.auto.tfvars` for Environments:** Create `dev.auto.tfvars`, `prod.auto.tfvars` and Terraform will automatically load the correct one based on which directory you're in.

5.  **Document Your Variables:** Always fill in the `description` field. Your future self (and teammates) will thank you.

6.  **Test with `terraform console`:** Before writing complex expressions, test them interactively in the console to verify they work as expected.
