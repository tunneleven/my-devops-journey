# Day 8: Introduction to Modules (Sprint 2 Begin)
**Date:** Thursday, Jan 29
**Focus:** The most import concept for scaling Terraform. DRY (Don't Repeat Yourself).

## 🎯 Objectives
1.  Understand what a Module is (Folder structure).
2.  Call a "Child Module" from a "Root Module".
3.  Pass variables INTO modules and get outputs OUT of modules.

## 📚 Study (45 mins)
*   **Concepts:**
    *   **Root vs. Child Modules.**
    *   **Inputs:** `variable` blocks in the child.
    *   **Outputs:** `output` blocks in the child (to expose data).
*   **Reading/Video:**
    *   *Zeal Vora Course:* Section on Modules.
    *   *Docs:* [Modules Overview](https://developer.hashicorp.com/terraform/language/modules)

## 💻 Lab: Your First Module (1h 15 mins)
**Scenario:** Convert your "One-Click Web Server" from Day 5 into a reusable module.

### Step 1: Create Structure
*   `modules/web_server/main.tf`
*   `modules/web_server/variables.tf`
*   `modules/web_server/outputs.tf`
*   `main.tf` (The Root)

### Step 2: Move Code
*   Move `aws_instance` and `aws_security_group` resources into `modules/web_server/main.tf`.
*   Replace hardsets with variables (e.g., `ami`, `instance_type`).

### Step 3: Call the Module
*   In `main.tf` (Root), add:
    ```hcl
    module "my_web_server" {
      source        = "./modules/web_server"
      instance_id   = "ami-123456" # pass variable
      instance_type = "t2.micro"
    }
    ```

### Step 4: Verify
*   Run `terraform init` (Required for modules!).
*   Run `terraform apply`.

## 📝 Checklist
- [ ] File structure created: `modules/` folder.
- [ ] `main.tf` (Root) is clean and only contains `module` blocks.
- [ ] Successfully passed a variable into the module.
- [ ] `terraform init` run successfully.
