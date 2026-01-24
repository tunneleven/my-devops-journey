# 🧪 Labs: Terraform

> Hands-on practice code for Terraform Infrastructure as Code

---

## 📋 Lab Index

| # | Lab Name | Topics Covered | Status |
|---|----------|----------------|--------|
| 01 | [Basics Day 1](01-basics-day01/) | Docker, AWS, GitHub providers | ✅ Complete |
| 02 | Variables Demo | TBD | ⏳ Planned |
| 03 | Docker Nginx | TBD | ⏳ Planned |
| 04 | AWS EC2 Web Server | TBD | ⏳ Planned |

---

## 🎯 Learning Objectives

Each lab is designed to reinforce specific concepts through hands-on practice:

- **Lab 01**: Basic provider usage (Docker, AWS, GitHub)
- **Lab 02**: Variables, locals, and outputs
- **Lab 03**: Docker Compose → Terraform migration
- **Lab 04**: EC2 instance with user data and security groups

---

## 📝 Lab Structure

Each lab folder should contain:
```
lab-name/
├── README.md          # Lab instructions & objectives
├── main.tf            # Main configuration
├── variables.tf       # Variable declarations
├── outputs.tf         # Output definitions
├── terraform.tfvars.example  # Example values
└── .gitignore         # Ignore state files
```

---

## 🚀 Getting Started

1. Navigate to a lab folder
2. Copy `terraform.tfvars.example` to `terraform.tfvars`
3. Fill in your values
4. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
5. Don't forget to cleanup:
   ```bash
   terraform destroy
   ```

---

*All labs are safe to run in your local environment or AWS free tier.*
