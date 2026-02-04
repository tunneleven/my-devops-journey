# 05: Expressions & Functions

**Reading Time:** ~15 min  
**Summary:** locals, built-in functions, try/can error handling, string manipulation, and collection functions.

## 🧠 Core Concepts

### 1. Local Values (`locals`)

#### What It Does
Creates reusable named expressions within a module. Unlike variables, locals are not exposed to callers.

#### Syntax
```hcl
locals {
  # Simple constants
  project_name = "my-app"
  
  # Computed values
  full_name = "${var.environment}-${local.project_name}"
  
  # Complex expressions
  common_tags = {
    Environment = var.environment
    Project     = local.project_name
    ManagedBy   = "Terraform"
  }
}
```

#### Usage
```hcl
resource "aws_instance" "web" {
  tags = local.common_tags
}
```

#### When to Use

| Scenario | Use Variable | Use Local |
|:---|:---:|:---:|
| Value comes from user/caller | ✅ | ❌ |
| Value is computed internally | ❌ | ✅ |
| Value is a constant | ❌ | ✅ |
| Value combines other variables | ❌ | ✅ |

---

### 2. Built-in Functions

#### String Functions

| Function | Description | Example |
|:---|:---|:---|
| `upper(string)` | Uppercase | `upper("hello")` → `"HELLO"` |
| `lower(string)` | Lowercase | `lower("HELLO")` → `"hello"` |
| `format(spec, ...)` | Printf formatting | `format("server-%02d", 5)` → `"server-05"` |
| `substr(str, start, len)` | Substring | `substr("hello", 0, 2)` → `"he"` |
| `replace(str, search, replace)` | Replace all | `replace("a-b-c", "-", "_")` → `"a_b_c"` |
| `split(sep, str)` | Split to list | `split(",", "a,b,c")` → `["a","b","c"]` |
| `join(sep, list)` | Join list | `join("-", ["a","b"])` → `"a-b"` |
| `trim(str, chars)` | Trim characters | `trim(" hi ", " ")` → `"hi"` |
| `trimprefix(str, prefix)` | Remove prefix | `trimprefix("ami-123", "ami-")` → `"123"` |

#### Collection Functions

| Function | Description | Example |
|:---|:---|:---|
| `length(collection)` | Count items | `length(["a","b"])` → `2` |
| `element(list, index)` | Get by index | `element(["a","b"], 0)` → `"a"` |
| `index(list, value)` | Find index | `index(["a","b"], "b")` → `1` |
| `contains(list, value)` | Check membership | `contains(["a","b"], "a")` → `true` |
| `concat(list1, list2)` | Join lists | `concat(["a"], ["b"])` → `["a","b"]` |
| `flatten(list)` | Flatten nested | `flatten([[1,2],[3]])` → `[1,2,3]` |
| `distinct(list)` | Remove duplicates | `distinct(["a","a","b"])` → `["a","b"]` |
| `sort(list)` | Sort strings | `sort(["c","a","b"])` → `["a","b","c"]` |
| `reverse(list)` | Reverse list | `reverse([1,2,3])` → `[3,2,1]` |
| `slice(list, start, end)` | Get sublist | `slice(["a","b","c"], 0, 2)` → `["a","b"]` |

#### Map Functions

| Function | Description | Example |
|:---|:---|:---|
| `keys(map)` | Get all keys | `keys({a=1, b=2})` → `["a","b"]` |
| `values(map)` | Get all values | `values({a=1, b=2})` → `[1, 2]` |
| `lookup(map, key, default)` | Safe access | `lookup({a=1}, "b", 0)` → `0` |
| `merge(map1, map2)` | Combine maps | `merge({a=1}, {b=2})` → `{a=1, b=2}` |
| `zipmap(keys, values)` | Create map | `zipmap(["a","b"], [1,2])` → `{a=1, b=2}` |

#### Numeric Functions

| Function | Description | Example |
|:---|:---|:---|
| `min(nums...)` | Minimum | `min(1, 5, 3)` → `1` |
| `max(nums...)` | Maximum | `max(1, 5, 3)` → `5` |
| `abs(num)` | Absolute value | `abs(-5)` → `5` |
| `ceil(num)` | Round up | `ceil(2.1)` → `3` |
| `floor(num)` | Round down | `floor(2.9)` → `2` |
| `parseint(str, base)` | Parse integer | `parseint("10", 16)` → `16` |

---

### 3. Error Handling: `try` and `can`

#### `try(expression, fallback)`
Attempts an expression and returns fallback if it fails.

```hcl
locals {
  # If var.port is null or undefined, use 8080
  port = try(var.port, 8080)
  
  # Try nested access with fallback
  db_host = try(var.config.database.host, "localhost")
  
  # Chain multiple fallbacks
  name = try(var.custom_name, var.default_name, "unnamed")
}
```

#### `can(expression)`
Returns `true` if expression succeeds, `false` if it fails. **Does not return the value.**

```hcl
variable "instance_type" {
  type = string
  validation {
    condition     = can(regex("^t[23]\\.", var.instance_type))
    error_message = "Must be t2.* or t3.* family."
  }
}
```

#### try vs can

| Function | Returns | Use Case |
|:---|:---|:---|
| `try()` | The value or fallback | Get a safe value with default |
| `can()` | `true` or `false` | Validation conditions |

#### Common Patterns

```hcl
# Safe JSON decode
locals {
  config = try(jsondecode(file("config.json")), {})
}

# Safe map access
locals {
  region = try(var.regions[var.env], "us-east-1")
}

# Validate format
variable "email" {
  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.email))
    error_message = "Invalid email format."
  }
}
```

---

### 4. Type Conversion Functions

| Function | Description | Example |
|:---|:---|:---|
| `tostring(value)` | Convert to string | `tostring(123)` → `"123"` |
| `tonumber(value)` | Convert to number | `tonumber("42")` → `42` |
| `tobool(value)` | Convert to bool | `tobool("true")` → `true` |
| `tolist(value)` | Convert to list | `tolist(toset(["a"]))` → `["a"]` |
| `toset(value)` | Convert to set | `toset(["a","a"])` → `["a"]` |
| `tomap(value)` | Convert to map | `tomap({a=1})` → `{a=1}` |

---

### 5. Date/Time Functions

| Function | Description | Example |
|:---|:---|:---|
| `timestamp()` | Current UTC time | `"2024-01-23T12:00:00Z"` |
| `formatdate(spec, time)` | Format date | `formatdate("YYYY-MM-DD", timestamp())` |
| `timeadd(time, duration)` | Add time | `timeadd(timestamp(), "24h")` |

#### Date Format Specifiers

| Specifier | Description | Example |
|:---|:---|:---|
| `YYYY` | 4-digit year | `2024` |
| `MM` | 2-digit month | `01` |
| `DD` | 2-digit day | `23` |
| `hh` | 2-digit hour (24h) | `14` |
| `mm` | 2-digit minute | `30` |
| `ss` | 2-digit second | `45` |

---

### 6. File Functions

| Function | Description | Example |
|:---|:---|:---|
| `file(path)` | Read file contents | `file("script.sh")` |
| `fileexists(path)` | Check if file exists | `fileexists("config.json")` |
| `filebase64(path)` | Read as base64 | `filebase64("image.png")` |
| `templatefile(path, vars)` | Render template | `templatefile("user_data.tpl", { port = 80 })` |
| `abspath(path)` | Absolute path | `abspath(".")` |
| `dirname(path)` | Directory name | `dirname("/a/b/c")` → `"/a/b"` |
| `basename(path)` | File name | `basename("/a/b/c")` → `"c"` |
| `pathexpand(path)` | Expand ~ | `pathexpand("~/.ssh")` |

---

## 🛠️ Quick Reference Table

| Need | Use | Example |
|:---|:---|:---|
| Reusable expression | `locals` | `local.project_name` |
| Safe value with default | `try()` | `try(var.x, "default")` |
| Validation check | `can()` | `can(regex("^t2", var.x))` |
| Transform string | `format()`, `upper()` | `format("%s-%d", name, i)` |
| Combine lists | `concat()`, `flatten()` | `concat(list1, list2)` |
| Combine maps | `merge()` | `merge(defaults, overrides)` |
| Read file | `file()` | `file("script.sh")` |
| Template file | `templatefile()` | `templatefile("tpl", vars)` |

---

## ⚠️ Common Pitfalls

### 1. Locals vs Variables Confusion
```hcl
# ❌ WRONG: Trying to override local from outside
module "x" {
  source     = "./mod"
  project    = "new"  # Won't override locals!
}

# ✅ CORRECT: Use variables for inputs
variable "project" { }
```

### 2. try() with Complex Types
```hcl
# ❌ WRONG: try() on list access
value = try(var.list, [])[0]  # Still errors if list is empty!

# ✅ CORRECT: Put entire expression in try
value = try(var.list[0], "default")
```

### 3. can() Returns Bool, Not Value
```hcl
# ❌ WRONG: can() doesn't return the value
port = can(var.port)  # Returns true/false, not port!

# ✅ CORRECT: Use try() for values
port = try(var.port, 8080)
```

---

## 💡 Pro Tips

1. **Use locals for DRY code:**
   ```hcl
   locals {
     name_prefix = "${var.env}-${var.project}"
   }
   # Use local.name_prefix everywhere instead of repeating
   ```

2. **Combine try() for nested access:**
   ```hcl
   db_host = try(var.config.database.host, "localhost")
   ```

3. **Use templatefile() for complex user_data:**
   ```hcl
   user_data = templatefile("${path.module}/init.sh.tpl", {
     port    = var.port
     db_host = var.db_host
   })
   ```

4. **Debug functions with terraform console:**
   ```bash
   terraform console
   > format("server-%03d", 5)
   > try(var.missing, "fallback")
   ```
