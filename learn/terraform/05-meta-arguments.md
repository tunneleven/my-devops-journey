# 📘 Day 6 Resources: Loops & Meta-Arguments

## 🧠 Core Concepts

### 1. Count (`count`)
The simplest loop. Creates `N` copies of a resource.
*   **Access:** `count.index` (0, 1, 2...).
*   **Risk:** If you remove item #1 from the middle of the list, item #2 becomes #1, and Terraform recreates everything after it.
*   **Use Case:** Identical resources (e.g., "3 Web Servers").

### 2. For Each (`for_each`)
The safer loop. Iterates over a `map` or `set` of strings.
*   **Access:** `each.key` and `each.value`.
*   **Stability:** Removing "Bob" from the map doesn't affect "Alice" or "Charlie".
*   **Use Case:** Distinct resources (e.g., "IAM Users", "S3 Buckets with specific names").

### 3. Splat Expressions (`[*]`)
When using `count`, the resource becomes a **List**. You can't ask for `aws_instance.web.id` anymore because there are many IDs.
*   **Syntax:** `aws_instance.web[*].id` returns `["id-1", "id-2", "id-3"]`.

---

## 🛠️ Code Comparison

### Using Count (The Old Way)
```hcl
resource "aws_instance" "server" {
  count = 3
  tags = {
    Name = "Server-${count.index}"
  }
}
```

### Using For_Each (The Modern Way)
```hcl
variable "users" {
  type    = list(string)
  default = ["alice", "bob"]
}

resource "aws_iam_user" "example" {
  for_each = toset(var.users)
  name     = each.value
}
```

---

## 📖 Helpful Documentation
*   [The `count` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
*   [The `for_each` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
*   [Splat Expressions](https://developer.hashicorp.com/terraform/language/expressions/splat)

---

## 💡 Pro Tips
*   **`toset()`:** `for_each` only accepts Sets or Maps. If you have a List `["a", "b"]`, you MUST wrap it: `for_each = toset(var.list)`.
*   **Outputting Map Values:** If you used `for_each`, you might need a `for` loop in your `output` to make it pretty:
    ```hcl
    output "all_users" {
      value = [for user in aws_iam_user.example : user.name]
    }
    ```
