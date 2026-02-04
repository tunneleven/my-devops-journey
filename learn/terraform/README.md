# 📚 Learn: Terraform

> Comprehensive knowledge base for Terraform Infrastructure as Code
> **Aligned with:** [Master Plan V2](../journal/MASTER_PLAN.md)

---

## 📖 Table of Contents

This is your curated Terraform reference guide, organized by Sprint.

### Sprint 1: The Protocol (Local Foundation)

| Day | Resource | Topic | Key Concepts |
|:---:|----------|-------|--------------|
| 00 | [Terraform Basics](00-terraform-basics.md) | Setup & Workflow | Install, init, plan, apply, destroy |
| 01 | [Variables & State](01-variables-and-state.md) | Input/Output Variables | Types, Validation, Precedence, State |
| 02 | [Docker & Terraform](02-docker-terraform.md) | Providers & Resources | Docker Provider, Compose Translation |
| 03 | [AWS EC2 Basics](03-aws-ec2.md) | AWS Bridge | EC2, Security Groups, SSH Keys |
| 04 | [Looping & Logic](04-looping-and-logic.md) | Meta-Arguments | `count`, `for_each`, `splat` |
| 05 | [Expressions & Functions](05-expressions-and-functions.md) | HCL Functions | `locals`, `try`, `can` |
| 06 | *Replace & Debugging* | CLI Mastery | `apply -replace`, `console`, `fmt` |
| 07 | *Provisioners* | Exam Topic | `local-exec`, `remote-exec` |

### Sprint 2: The Architect (Team & Scale)

| Day | Resource | Topic | Key Concepts |
|:---:|----------|-------|--------------|
| 09 | *Remote State* | Backend Config | S3 + DynamoDB Lock |
| 10 | *Module Basics* | Refactoring | Child vs Root Modules |
| 11 | *Advanced Modules* | Registry | Sources, Versioning |
| 12 | *Workspaces* | Environments | Dev/Staging/Prod |
| 13 | *Lifecycles* | Meta-Arguments | `lifecycle`, pre/postcondition |
| 14 | *Check & Moved Blocks* | 004 Exam | `check {}`, `moved {}` |
| 15 | [Data Sources](06-data-sources.md) | Dynamic Lookups | AMI, VPC lookup |
| 16 | *Ephemeral Values* | 004 Exam | Write-only arguments |

### Sprint 3: The Engineer (Cloud Native & Ops)

| Day | Resource | Topic | Key Concepts |
|:---:|----------|-------|--------------|
| 18 | *Security Primer* | Sensitive Data | Vault, Sentinel |
| 19 | *VPC Deep Dive* | Networking | Subnets, Route Tables |
| 20 | *Load Balancing* | ALB | Target Groups, Listeners |
| 21 | *ECS* | Containers | Task Def, Fargate |
| 22 | *Lambda* | Serverless | Zipmap, Lambda resource |
| 23 | *CI/CD* | Automation | GitHub Actions, `terraform test` |
| 25 | *Import & Drift* | 004 Exam | `terraform import` |

---

## 🎯 Quick Reference

| Topic | File | Sprint |
|-------|------|:------:|
| **Basics** | [00-terraform-basics](00-terraform-basics.md) | 1 |
| Variables | [01-variables-and-state](01-variables-and-state.md) | 1 |
| Docker | [02-docker-terraform](02-docker-terraform.md) | 1 |
| AWS EC2 | [03-aws-ec2](03-aws-ec2.md) | 1 |
| Loops | [04-looping-and-logic](04-looping-and-logic.md) | 1 |
| Functions | [05-expressions-and-functions](05-expressions-and-functions.md) | 1 |
| Data Sources | [06-data-sources](06-data-sources.md) | 2 |
| Modules | [07-modules](07-modules.md) | 2 |

---

## 🔍 Search by Use Case

**"I need to..."**
- Create multiple resources → [Looping & Logic (Day 04)](04-looping-and-logic.md)
- Manage secrets securely → [Variables (Day 01)](01-variables-and-state.md#validation-rules)
- Find the latest Ubuntu AMI → [Data Sources (Day 15)](06-data-sources.md)
- Run Docker containers → [Docker Integration (Day 02)](02-docker-terraform.md)
- Deploy to AWS → [AWS EC2 (Day 03)](03-aws-ec2.md)
- Make my code reusable → [Modules (Day 10-11)](07-modules.md)

---

*All resources are self-contained. Follow the Master Plan order for best results.*
