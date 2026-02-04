# 📘 Day 7 Resources: Data Sources & Polish

## 🧠 Core Concepts

### 1. Data Sources (`data`)
Resources create infrastructure. Data Sources **read** existing infrastructure.
*   **Most Common Use:** Finding the latest Amazon Linux 2 or Ubuntu AMI dynamically, rather than hardcoding `ami-0123...`.
*   **Syntax:**
    ```hcl
    data "aws_ami" "ubuntu" {
      most_recent = true
      owners      = ["099720109477"] # Canonical
      filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
      }
    }
    ```

### 2. The Random Provider (`random`)
Sometimes you need a unique name for an S3 bucket (which must be globally unique).
*   **Resource:** `random_id`, `random_pet`, `random_string`.
*   **Example:** `bucket = "my-app-${random_id.bucket_suffix.hex}"` -> `my-app-fe3a1d`.

### 3. Terraform Polish
*   `terraform fmt`: Rewrites your code to canonical style (indents, spacing). **Run this before every commit.**
*   `terraform validate`: Checks for syntax errors and internal consistency (e.g., checking if variable names match).

---

## 📖 Helpful Documentation
*   [Data Sources Overview](https://developer.hashicorp.com/terraform/language/data-sources)
*   [AWS AMI Data Source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)
*   [Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

---

## 💡 Pro Tips
*   **Filter Logic:** When using Data Sources, always double-check your `filter`. Use the AWS Console -> AMIs page to verify the "Name" or "Owner Alias" you are filtering for.
*   **Outputs from Data:** You can output data just like resources:
    ```hcl
    output "ami_id_found" {
      value = data.aws_ami.ubuntu.id
    }
    ```
