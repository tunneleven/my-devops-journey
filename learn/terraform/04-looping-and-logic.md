# 04: Looping & Logic

**Reading Time:** ~18 min  
**Summary:** count, for_each, splat, for expressions, conditionals, and dynamic blocks.

## 🧠 Core Concepts

### 1. The `count` Meta-Argument

#### What It Does
Creates **multiple instances** of a resource based on a number. Each instance gets an index (0, 1, 2...).

#### Syntax
```hcl
resource "aws_instance" "server" {
  count         = 3
  ami           = "ami-0123456789"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Server-${count.index}"
  }
}
```

#### Key Properties

| Property | Description | Example |
|:---|:---|:---|
| `count` | Number of instances to create | `count = 3` |
| `count.index` | Zero-based index of current instance | `0`, `1`, `2` |

#### Referencing Count Resources
```hcl
# All instances (list)
aws_instance.server[*].id

# Specific instance
aws_instance.server[0].id
aws_instance.server[1].id
```

#### ⚠️ The Count Problem: Index Shift

**Critical Flaw:** If you remove an item from the middle, ALL subsequent indices shift.

```hcl
# Before: servers = ["web", "api", "db"]
# count = 3 → server[0]=web, server[1]=api, server[2]=db

# After: servers = ["web", "db"]  (removed "api")
# count = 2 → server[0]=web, server[1]=db
# PROBLEM: Terraform will DESTROY server[2] (db) and RECREATE server[1] (was api, now db)
```

**Rule:** Use `count` only when:
1. All instances are identical
2. Order doesn't matter
3. You won't remove items from the middle

---

### 2. The `for_each` Meta-Argument

#### What It Does
Creates instances based on a **map** or **set**. Each instance has a **key** (not an index).

#### Syntax
```hcl
resource "aws_instance" "server" {
  for_each      = toset(["web", "api", "db"])
  ami           = "ami-0123456789"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Server-${each.key}"
  }
}
```

#### Key Properties

| Property | Description | Example |
|:---|:---|:---|
| `for_each` | Map or Set to iterate | `toset(["a", "b"])` |
| `each.key` | Current key in iteration | `"web"`, `"api"` |
| `each.value` | Current value (same as key for sets) | `"web"`, `"api"` |

#### With Maps (Key-Value Pairs)
```hcl
variable "servers" {
  default = {
    web = "t2.micro"
    api = "t2.small"
    db  = "t2.medium"
  }
}

resource "aws_instance" "server" {
  for_each      = var.servers
  ami           = "ami-0123456789"
  instance_type = each.value
  
  tags = {
    Name = "Server-${each.key}"
    Type = each.value
  }
}
```

#### Referencing For_Each Resources
```hcl
# All instances (map)
aws_instance.server["web"].id
aws_instance.server["api"].id

# All IDs as a list
values(aws_instance.server)[*].id
```

#### ✅ Why For_Each is Better

**No Index Shift Problem:**
```hcl
# Before: servers = ["web", "api", "db"]
# After: servers = ["web", "db"]

# With for_each:
# server["web"] = unchanged
# server["api"] = DESTROYED (correct!)
# server["db"] = unchanged (not shifted!)
```

---

### 3. Splat Expressions (`[*]`)

#### What It Does
Extracts a **list of values** from a collection of resources.

#### Syntax
```hcl
# Extract all IDs from count-based resources
output "all_ids" {
  value = aws_instance.server[*].id
}

# Extract all IPs
output "all_ips" {
  value = aws_instance.server[*].public_ip
}
```

#### Splat vs For Expression

| Method | Syntax | When to Use |
|:---|:---|:---|
| **Splat** | `resource[*].attr` | Simple attribute extraction |
| **For** | `[for r in resource : r.attr]` | Complex transformations |

```hcl
# Equivalent expressions
aws_instance.server[*].id
[for s in aws_instance.server : s.id]

# For is more powerful (can filter, transform)
[for s in aws_instance.server : s.id if s.instance_state == "running"]
```

---

### 4. For Expressions

#### What It Does
Transforms collections (lists, maps, sets) into new collections with filtering and modification.

#### List Syntax
```hcl
[for item in list : transform(item)]
[for item in list : transform(item) if condition]
```

#### Map Syntax
```hcl
{for key, value in map : new_key => new_value}
```

#### Examples
```hcl
# Transform list - uppercase all names
locals {
  names = ["web", "api", "db"]
  upper_names = [for n in local.names : upper(n)]
  # Result: ["WEB", "API", "DB"]
}

# Filter list - only items starting with "a"
locals {
  filtered = [for n in local.names : n if substr(n, 0, 1) == "a"]
  # Result: ["api"]
}

# Transform map - add prefix to all values
variable "ports" {
  default = { web = 80, api = 8080 }
}
locals {
  prefixed = {for k, v in var.ports : k => "port-${v}"}
  # Result: { web = "port-80", api = "port-8080" }
}

# List to map conversion
locals {
  servers = ["web", "api", "db"]
  server_map = {for s in local.servers : s => "${s}-server"}
  # Result: { web = "web-server", api = "api-server", db = "db-server" }
}
```

#### Common Functions with For
| Function | Purpose | Example |
|:---|:---|:---|
| `flatten()` | Flatten nested lists | `flatten([[1,2], [3,4]])` → `[1,2,3,4]` |
| `merge()` | Combine maps | `merge({a=1}, {b=2})` → `{a=1, b=2}` |
| `lookup()` | Safe map access | `lookup(var.map, "key", "default")` |
| `keys()` | Get map keys | `keys({a=1, b=2})` → `["a", "b"]` |
| `values()` | Get map values | `values({a=1, b=2})` → `[1, 2]` |

---

### 5. Conditional Expressions

#### Syntax
```hcl
condition ? true_value : false_value
```

#### Examples
```hcl
# Conditional resource creation
resource "aws_instance" "debug" {
  count         = var.environment == "dev" ? 1 : 0
  ami           = "ami-debug"
  instance_type = "t2.micro"
}

# Conditional value
instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"

# Conditional with for_each
for_each = var.create_alarms ? var.alarm_configs : {}
```

#### Common Patterns

| Pattern | Code |
|:---|:---|
| Enable/Disable resource | `count = var.enabled ? 1 : 0` |
| Environment sizing | `var.env == "prod" ? "large" : "small"` |
| Default fallback | `var.custom_name != "" ? var.custom_name : "default"` |

---

### 6. Dynamic Blocks

#### What It Does
Generates **nested blocks** dynamically (for resources that have repeatable sub-blocks).

#### Use Case: Security Group Rules
```hcl
variable "ingress_rules" {
  default = [
    { port = 22, cidr = "10.0.0.0/8" },
    { port = 80, cidr = "0.0.0.0/0" },
    { port = 443, cidr = "0.0.0.0/0" },
  ]
}

resource "aws_security_group" "web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr]
    }
  }
}
```

#### Anatomy

| Part | Description |
|:---|:---|
| `dynamic "block_name"` | Name of the block to generate |
| `for_each` | Collection to iterate |
| `content { }` | The actual block content |
| `block_name.value` | Current item in iteration |
| `block_name.key` | Current key (if map) |

---

## 🛠️ Quick Reference Table

| Need | Use | Example |
|:---|:---|:---|
| Create N identical resources | `count` | `count = 3` |
| Create named resources | `for_each` | `for_each = toset(["a","b"])` |
| Extract list of attrs | Splat | `resource[*].id` |
| Conditional creation | `count` + ternary | `count = var.x ? 1 : 0` |
| Generate nested blocks | `dynamic` | `dynamic "ingress" { }` |

---

## ⚠️ Common Pitfalls

### 1. Count + List = Danger
```hcl
# ❌ BAD: Removing "api" shifts all indices
variable "names" {
  default = ["web", "api", "db"]
}
resource "aws_instance" "server" {
  count = length(var.names)
  tags  = { Name = var.names[count.index] }
}

# ✅ GOOD: Use for_each
resource "aws_instance" "server" {
  for_each = toset(var.names)
  tags     = { Name = each.key }
}
```

### 2. For_Each Requires Set or Map
```hcl
# ❌ ERROR: List is not valid
for_each = ["a", "b", "c"]

# ✅ CORRECT: Convert to set
for_each = toset(["a", "b", "c"])
```

### 3. Can't Use count AND for_each Together
```hcl
# ❌ ERROR: Only one allowed per resource
resource "aws_instance" "x" {
  count    = 3
  for_each = toset(["a"])  # INVALID
}
```

---

## 💡 Pro Tips

1. **Default to for_each:** Unless you have a simple "create N of the same thing" scenario.

2. **Use locals for complex logic:**
   ```hcl
   locals {
     servers = {
       for name in var.server_names :
       name => {
         instance_type = name == "db" ? "t2.large" : "t2.micro"
       }
     }
   }
   ```

3. **Debug with terraform console:**
   ```bash
   terraform console
   > toset(["a", "b", "c"])
   > [for x in ["a", "b"] : upper(x)]
   ```

4. **Splat only works on lists:** For `for_each` resources, use `values(resource)[*].attr`.
