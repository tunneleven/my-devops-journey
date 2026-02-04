# 05: Expressions & Functions
**Focus:** Master locals, built-in functions, and error handling with try/can.
**Time:** 2 hours
**Resource File:** [05-expressions-and-functions.md](../../learn/terraform/05-expressions-and-functions.md)

---

## 🎯 Objectives
1. Use `locals` to create reusable expressions
2. Apply built-in functions for string, list, and map manipulation
3. Handle errors gracefully with `try()` and `can()`
4. Use `templatefile()` for dynamic configuration

---

## 📚 Study (30 min)

**Read These Sections:**
1. [Local Values](../../learn/terraform/05-expressions-and-functions.md#1-local-values-locals)
2. [Built-in Functions](../../learn/terraform/05-expressions-and-functions.md#2-built-in-functions)
3. [Error Handling: try and can](../../learn/terraform/05-expressions-and-functions.md#3-error-handling-try-and-can)

---

## 💻 Lab: Dynamic Infrastructure (60 min)

### Setup
```bash
mkdir -p labs/terraform/05-expressions-and-functions
cd labs/terraform/05-expressions-and-functions
```

### Part 1: Locals for DRY Code

Create `main.tf`:
```hcl
variable "environment" {
  type    = string
  default = "dev"
}

variable "project" {
  type    = string
  default = "webapp"
}

variable "owner" {
  type    = string
  default = "devops-team"
}

locals {
  # Computed naming
  name_prefix = "${var.environment}-${var.project}"
  
  # Standardized tags
  common_tags = {
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    ManagedBy   = "Terraform"
    CreatedAt   = formatdate("YYYY-MM-DD", timestamp())
  }
  
  # Environment-based sizing
  instance_type = var.environment == "prod" ? "t2.medium" : "t2.micro"
}

output "name_prefix" {
  value = local.name_prefix
}

output "common_tags" {
  value = local.common_tags
}

output "instance_type" {
  value = local.instance_type
}
```

Run and observe:
```bash
terraform init
terraform apply -auto-approve
terraform output common_tags
```

### Part 2: String Functions

Create `string_demo.tf`:
```hcl
variable "raw_name" {
  default = "  My-Project-Name  "
}

locals {
  # Clean and format the name
  clean_name = lower(trim(var.raw_name, " "))
  slug_name  = replace(local.clean_name, "-", "_")
  
  # Format with padding
  server_names = [for i in range(3) : format("server-%02d", i)]
  
  # Extract parts
  domain     = "api.example.com"
  subdomain  = split(".", local.domain)[0]
}

output "clean_name" {
  value = local.clean_name
}

output "slug_name" {
  value = local.slug_name
}

output "server_names" {
  value = local.server_names
}

output "subdomain" {
  value = local.subdomain
}
```

Run:
```bash
terraform apply -auto-approve
terraform output server_names
```

### Part 3: try() and can()

Create `error_handling.tf`:
```hcl
variable "config" {
  type = any
  default = {
    database = {
      host = "db.example.com"
      port = 5432
    }
  }
}

variable "optional_port" {
  type    = number
  default = null
}

locals {
  # Safe nested access
  db_host = try(var.config.database.host, "localhost")
  db_port = try(var.config.database.port, 5432)
  
  # Missing key fallback
  cache_host = try(var.config.cache.host, "localhost:6379")
  
  # Null-safe with try
  port = try(var.optional_port, 8080)
}

output "database" {
  value = {
    host = local.db_host
    port = local.db_port
  }
}

output "cache_host" {
  value = local.cache_host
}

output "port" {
  value = local.port
}
```

Run:
```bash
terraform apply -auto-approve
# Notice cache_host uses fallback since config.cache doesn't exist
```

### Part 4: Validation with can()

Create `validation.tf`:
```hcl
variable "email" {
  type    = string
  default = "user@example.com"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email))
    error_message = "Must be a valid email address."
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
  
  validation {
    condition     = can(regex("^t[23]\\.(micro|small|medium|large)$", var.instance_type))
    error_message = "Must be t2 or t3 family (micro/small/medium/large)."
  }
}

output "validated_email" {
  value = var.email
}
```

Test validation:
```bash
terraform apply -auto-approve
# Try invalid values
terraform apply -var="email=invalid" -auto-approve  # Should fail
terraform apply -var="instance_type=m5.large" -auto-approve  # Should fail
```

### Part 5: Template Files

Create `templates/config.json.tpl`:
```json
{
  "app_name": "${app_name}",
  "environment": "${environment}",
  "port": ${port},
  "features": ${jsonencode(features)}
}
```

Create `template_demo.tf`:
```hcl
locals {
  config = templatefile("${path.module}/templates/config.json.tpl", {
    app_name    = "my-app"
    environment = var.environment
    port        = 8080
    features    = ["logging", "metrics", "tracing"]
  })
}

output "config_json" {
  value = local.config
}
```

Run:
```bash
mkdir -p templates
# Create the template file first, then:
terraform apply -auto-approve
terraform output config_json
```

---

## 🔬 Verification

```bash
# Check all outputs
terraform output

# Verify locals work
terraform output name_prefix
# Expected: "dev-webapp"

# Verify string functions
terraform output server_names
# Expected: ["server-00", "server-01", "server-02"]

# Verify try() fallback
terraform output cache_host
# Expected: "localhost:6379" (fallback)

# Test validation fails
terraform apply -var="email=bad" 2>&1 | grep "Must be a valid"
# Expected: Error message about email format
```

---

## 🧠 Knowledge Check

1. **Q:** When should you use `locals` vs `variable`?
   **A:** [Answer in Resource](../../learn/terraform/05-expressions-and-functions.md#when-to-use)

2. **Q:** What's the difference between `try()` and `can()`?
   **A:** [Answer in Resource](../../learn/terraform/05-expressions-and-functions.md#try-vs-can)

3. **Q:** How do you format a number with leading zeros?
   **A:** `format("%03d", 5)` → `"005"`

---

## 📝 Cleanup
```bash
terraform destroy -auto-approve
cd ../../..
```
