# 04: Looping & Logic
**Focus:** Master count, for_each, and splat to create multiple resources efficiently.
**Time:** 2 hours
**Resource File:** [04-looping-and-logic.md](../../learn/terraform/04-looping-and-logic.md)

---

## 🎯 Objectives
1. Understand the difference between `count` and `for_each`
2. Know when to use each approach
3. Use splat expressions to extract resource attributes
4. Apply conditional logic for resource creation

---

## 📚 Study (30 min)

**Read These Sections:**
1. [The count Meta-Argument](../../learn/terraform/04-looping-and-logic.md#-1-the-count-meta-argument)
2. [The for_each Meta-Argument](../../learn/terraform/04-looping-and-logic.md#-2-the-for_each-meta-argument)
3. [Splat Expressions](../../learn/terraform/04-looping-and-logic.md#-3-splat-expressions-)
4. [Common Pitfalls](../../learn/terraform/04-looping-and-logic.md#️-common-pitfalls)

---

## 💻 Lab: Multi-Server Deployment (60 min)

### Setup
```bash
mkdir -p labs/terraform/04-looping-and-logic
cd labs/terraform/04-looping-and-logic
```

### Part 1: Count (The Simple Way)

Create `count_demo.tf`:
```hcl
# Using count to create 3 identical instances
resource "null_resource" "count_demo" {
  count = 3

  triggers = {
    id   = count.index
    name = "server-${count.index}"
  }
}

output "count_names" {
  value = null_resource.count_demo[*].triggers.name
}
```

Run and observe:
```bash
terraform init
terraform apply -auto-approve
terraform output count_names
```

### Part 2: For_Each (The Better Way)

Create `for_each_demo.tf`:
```hcl
# Using for_each with a set
variable "server_names" {
  type    = set(string)
  default = ["web", "api", "db"]
}

resource "null_resource" "for_each_demo" {
  for_each = var.server_names

  triggers = {
    name = each.key
    type = each.key == "db" ? "database" : "application"
  }
}

output "server_types" {
  value = {
    for name, server in null_resource.for_each_demo :
    name => server.triggers.type
  }
}
```

Run:
```bash
terraform apply -auto-approve
terraform output server_types
```

### Part 3: The Index Shift Problem

1. Comment out `"api"` from `server_names`:
   ```hcl
   default = ["web", "db"]  # Removed "api"
   ```

2. Run plan and observe:
   ```bash
   terraform plan
   ```

3. **Notice:** With `for_each`, only the "api" resource is destroyed. No index shifting!

### Part 4: For_Each with Maps

Create `map_demo.tf`:
```hcl
variable "servers" {
  type = map(object({
    instance_type = string
    port          = number
  }))
  default = {
    web = { instance_type = "t2.micro", port = 80 }
    api = { instance_type = "t2.small", port = 8080 }
    db  = { instance_type = "t2.medium", port = 5432 }
  }
}

resource "null_resource" "server" {
  for_each = var.servers

  triggers = {
    name = each.key
    type = each.value.instance_type
    port = each.value.port
  }
}

# Splat-like extraction for for_each
output "all_ports" {
  value = [for s in null_resource.server : s.triggers.port]
}
```

Run:
```bash
terraform apply -auto-approve
terraform output all_ports
```

### Part 5: Conditional Creation

Create `conditional_demo.tf`:
```hcl
variable "environment" {
  type    = string
  default = "dev"
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

# Only create in dev environment
resource "null_resource" "debug_server" {
  count = var.environment == "dev" ? 1 : 0

  triggers = {
    purpose = "debugging"
  }
}

# Conditional based on bool
resource "null_resource" "monitoring" {
  count = var.enable_monitoring ? 1 : 0

  triggers = {
    type = "cloudwatch"
  }
}

output "debug_created" {
  value = length(null_resource.debug_server) > 0
}
```

Test:
```bash
terraform apply -auto-approve
terraform apply -var="environment=prod" -auto-approve
# Notice: debug_server is destroyed in prod
```

---

## 🔬 Verification

```bash
# Check all resources created
terraform state list

# Verify count output
terraform output count_names

# Verify for_each output
terraform output server_types

# Verify map extraction
terraform output all_ports

# Test conditional
terraform output debug_created
```

**Expected Results:**
- [ ] `count_names` shows `["server-0", "server-1", "server-2"]`
- [ ] `server_types` shows `{api = "application", db = "database", web = "application"}`
- [ ] `all_ports` shows `["80", "8080", "5432"]`
- [ ] When `environment=prod`, debug_server is not created

---

## 🧠 Knowledge Check

1. **Q:** When should you use `count` vs `for_each`?
   **A:** [Answer in Resource](../../learn/terraform/04-looping-and-logic.md#️-common-pitfalls)

2. **Q:** What is the "index shift" problem?
   **A:** [Answer in Resource](../../learn/terraform/04-looping-and-logic.md#️-the-count-problem-index-shift)

3. **Q:** How do you extract all IDs from a `for_each` resource?
   **A:** `values(resource)[*].id` or `[for r in resource : r.id]`

---

## 📝 Cleanup
```bash
terraform destroy -auto-approve
cd ../../..
```
