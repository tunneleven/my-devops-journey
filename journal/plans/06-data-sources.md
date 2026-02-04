# Day 7: The Grand Review & Mini-Project
**Date:** Wednesday, Jan 28
**Focus:** Consolidation. Proving you are ready for Sprint 2 (Modules).

## 🎯 Objectives
1.  Combine everything: Docker/AWS + Variables + Outputs + Data Sources + Dependencies.
2.  Clean up the code (Formatting and Validation).
3.  Take a Mini-Mock Exam (10 questions) or extensive Quiz.

## 📚 Study (30 mins)
*   **Concepts:**
    *   **Data Sources:** Querying AWS for the "Latest Ubuntu AMI" instead of hardcoding IDs.
    *   **Terraform Commands:** `fmt` (Format), `validate` (Syntax Check), `taint` (Force Recreate).
*   **Reading:**
    *   *Docs:* [Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## 💻 Lab: The "Sprint 1" Capstone (2h 30 mins)
**Scenario:** Deploy a "Production-Ready" Nginx container or EC2 instance using dynamic data.

### Step 1: Dynamic AMI (The Data Source)
*   Use `data "aws_ami" "ubuntu"` to find the canonical Ubuntu 22.04 image.
*   Update your `aws_instance` to use `data.aws_ami.ubuntu.id`.

### Step 2: The Capstone Build
*   Create a single directory `capstone-sprint1`.
*   **Requirements:**
    1.  Use `variables.tf` for everything (Region, Instance Type, Project Name).
    2.  Use `providers.tf` with version constraints.
    3.  Launch an EC2 Instance with a Web Server (User Data).
    4.  Use a `random_id` resource (Terraform Random Provider) to generate a unique S3 Bucket name.
    5.  Create the S3 Bucket.
    6.  Output the `http://<public-ip>` and the S3 Bucket Name.

### Step 3: Polish
*   Run `terraform fmt -recursive`.
*   Run `terraform validate`.
*   Run `terraform plan` and save it: `terraform plan -out=tfplan`.
*   Run `terraform apply "tfplan"`.

## 📝 Checklist
- [ ] Used `data` source to fetch AMI/Image.
- [ ] Used `random` provider.
- [ ] Code is formatted (`fmt`) and validated (`validate`).
- [ ] Saved a plan file (`-out`).
- [ ] **CONFIDENCE CHECK:** Do you feel ready to start writing Modules next week?
