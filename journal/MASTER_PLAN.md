# 🗺️ The Master Plan V2: Container-Native DevOps

**Goal:** Zero-Gap Terraform Knowledge + AWS Container Mastery + 004 Certification.
**Schedule:** Mon-Fri 2h/day | Sat-Sun 3h/day (16h/week)
**New Certification Window:** Feb 19 – Feb 22, 2026 (Shifted +1 week for complete coverage)

---

## 📅 Sprint 1: The Protocol (Local Foundation)
**Duration:** Days 00-08 (Jan 22 - Jan 30)
**Focus:** Git, Docker, Terraform Basics, and Core Logic.

| Day | Topic | Key Labs | Est. Time |
|:---|:---|:---|:---:|
| **00** | Basics & Setup | Install TF, VSCode Ext. | 2h |
| **01** | Variables & State | GitHub Repo, Validation Rules | 2h |
| **02** | Providers & Resources | Nginx via Docker | 2h |
| **03** | AWS Bridge (EC2) | Web Server + SSH Key | 2h |
| **04** | Looping & Logic | `count`, `for_each`, `splat` | 2h |
| **05** | Expressions & Functions | `locals`, `try`, `can` | 2h |
| **06** | Replace & Debugging | `terraform apply -replace`, `console`, `fmt` | 2h |
| **07** | **Provisioners** | `local-exec`, `remote-exec` (Exam Topic) | 2h |
| **08** | **Capstone 1 + Buffer** | Local Nginx Controller App + Review | 3h |

**Sprint 1 Total:** ~19 hours

---

## 📅 Sprint 2: The Architect (Team & Scale)
**Duration:** Days 09-17 (Jan 31 - Feb 8)
**Focus:** Modules, State, Workspaces, Lifecycle Management.

| Day | Topic | Key Labs | Est. Time |
|:---|:---|:---|:---:|
| **09** | Remote State | S3 Backend + DynamoDB Lock | 2h |
| **10** | Module Basics | Refactor Day 03 to Module | 2h |
| **11** | Advanced Modules | Child vs Root, Sources, Registry | 2h |
| **12** | Workspaces | Dev/Staging/Prod envs | 2h |
| **13** | **Lifecycles & Conditions** | `lifecycle`, `precondition`, `postcondition` | 2h |
| **14** | **Check & Moved Blocks** | `check {}`, `moved {}` (004 Topics) | 2h |
| **15** | Data Sources | Dynamic AMI, VPC lookup | 2h |
| **16** | **Ephemeral Values** | `ephemeral`, write-only args (004 Topic) | 2h |
| **17** | **Capstone 2 + Buffer** | Multi-Env AWS Platform + Review | 3h |

**Sprint 2 Total:** ~19 hours

---

## 📅 Sprint 3: The Engineer (Cloud Native & Ops)
**Duration:** Days 18-28 (Feb 9 - Feb 18)
**Focus:** ECS, Networking, CI/CD, Security, Production.

| Day | Topic | Key Labs | Est. Time |
|:---|:---|:---|:---:|
| **18** | Security Primer | Sentinel, Vault (Theory), Sensitive vars | 2h |
| **19** | **VPC Deep Dive** | VPC, Subnets, Route Tables | 2h |
| **20** | **Load Balancing** | ALB, Target Groups, Listeners | 2h |
| **21** | Containers (ECS) | Task Def, Service (Fargate) | 2h |
| **22** | Serverless (Lambda) | Zipmap func, Lambda resource | 2h |
| **23** | CI/CD Pipeline | GitHub Actions + `terraform test` | 2h |
| **24** | Performance | Parallelism, `terraform graph` | 2h |
| **25** | **Import & Drift** | `terraform import`, `-generate-config-out` | 2h |
| **26** | Multi-Region | East/West Failover | 2h |
| **27** | **Final Capstone** | The ECS "Hard Way" Cluster | 3h |
| **28** | **Buffer Day** | Review + Fix Any Capstone Issues | 3h |

**Sprint 3 Total:** ~24 hours

---

## 🏆 Certification Phase (Feb 19 - Feb 22)
**Duration:** 3 days intensive prep

| Day | Topic | Key Labs | Est. Time |
|:---|:---|:---|:---:|
| **29** | HCP Terraform (Cloud) | Workspaces, CLI Runs, Sentinel | 3h |
| **30** | Practice Exams | Bryan Krausen 004 Tests | 3h |
| **31** | **Exam Day** | Sit Terraform Associate 004 | - |

---

## 📊 Complete Topic Coverage (004 Aligned)

### Core Domains ✅
- [x] IaC Concepts (Day 00-01)
- [x] Terraform Purpose (Day 00-02)
- [x] Terraform Basics (Day 00-03)
- [x] CLI Commands (Day 06, 25)
- [x] Modules (Day 10-11)
- [x] Workflow (Day 00-03)
- [x] State Management (Day 01, 09)

### 004-Specific Topics ✅
- [x] Input Variable Validation (Day 01)
- [x] Preconditions/Postconditions (Day 13)
- [x] Check Blocks (Day 14)
- [x] Moved Blocks (Day 14)
- [x] Ephemeral Values (Day 16)
- [x] Import Workflow (Day 25)
- [x] Provisioners (Day 07)

### Production Skills ✅
- [x] Remote State Locking (Day 09)
- [x] VPC Networking (Day 19)
- [x] Load Balancing (Day 20)
- [x] Container Deployment (Day 21, 27)
- [x] CI/CD Pipeline (Day 23)
- [x] Multi-Region (Day 26)

---

## 🧭 How to Use This Plan

1. **Follow the Order:** Days build on each other. Don't skip.
2. **Respect Buffer Days:** Use D08, D17, D28 for catch-up if needed.
3. **Capstone = Boss Fight:** Must complete before moving to next Sprint.
4. **Time Budget:** 2h weekday, 3h weekend. Adjust if falling behind.

---

## 📅 Calendar View

```
Week 1 (Jan 22-26): Days 00-04 (Foundation)
Week 2 (Jan 27-Feb 2): Days 05-10 (Logic + Modules Start)
Week 3 (Feb 3-9): Days 11-17 (Architecture Complete)
Week 4 (Feb 10-16): Days 18-24 (Cloud Native)
Week 5 (Feb 17-22): Days 25-31 (Final Capstone + Exam)
```

**Total Learning Days:** 31
**Total Hours:** ~65 hours
**Certification Date:** Feb 19-22, 2026
