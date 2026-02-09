# AWS Shared Responsibility Model

> AWS secures the cloud itself. You secure what you put IN the cloud.

## Core Concept

```
┌─────────────────────────────────────────────────────────────┐
│    ☁️ SECURITY "OF" THE CLOUD                              │
│    AWS is responsible (You can't access this stuff!)       │
├─────────────────────────────────────────────────────────────┤
│    🔐 SECURITY "IN" THE CLOUD                              │
│    YOU are responsible (Your data, configs, your problem!) │
└─────────────────────────────────────────────────────────────┘
```

---

## AWS Responsibility (Security OF the Cloud)

AWS handles everything you **cannot see or touch**:

```
AWS RESPONSIBILITY
├── 🏢 Physical Data Centers
│   ├── Building security (guards, cameras)
│   ├── Environmental controls (cooling, power)
│   └── Natural disaster protection
│
├── 🖥️ Hardware
│   ├── Servers
│   ├── Storage devices
│   └── Networking equipment
│
├── 🔧 Hypervisor
│   └── The software that creates virtual machines
│
├── 🌐 Global Infrastructure
│   ├── Regions
│   ├── Availability Zones
│   └── Edge Locations
│
└── 🔒 Managed Service Infrastructure
    └── OS/patching for services like RDS, DynamoDB
```

---

## Customer Responsibility (Security IN the Cloud)

You handle everything you **can control**:

```
YOUR RESPONSIBILITY
├── 📊 Data
│   ├── What data you store
│   ├── How it's encrypted
│   └── Who can access it
│
├── 👤 Identity & Access (IAM)
│   ├── Creating users
│   ├── Setting permissions
│   └── MFA enforcement
│
├── 🖥️ Operating System (for EC2)
│   ├── Patching
│   ├── Updates
│   └── Antivirus
│
├── 🔥 Network & Firewall
│   ├── Security Groups
│   ├── NACLs
│   └── VPC configuration
│
├── 💻 Application
│   ├── Your code security
│   ├── Application updates
│   └── Dependencies
│
└── 🔐 Client-Side Encryption
    └── Encrypting data before sending to AWS
```

---

## Responsibility Changes by Service Type

The more **managed** the service, the less **you** have to do:

```
YOUR RESPONSIBILITY DECREASES ──────────────────────────────►

┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    IaaS     │    │    PaaS     │    │  SaaS-like  │
│    (EC2)    │    │ (Lambda/RDS)│    │  (S3/DDB)   │
└─────────────┘    └─────────────┘    └─────────────┘
You do MORE          Medium            You do LESS
```

---

## Service-Specific Examples

### EC2 (IaaS - You do the most)

| Layer | Who? |
|-------|------|
| Application Code | 👤 Customer |
| Application Security | 👤 Customer |
| Guest OS Patches | 👤 Customer |
| Security Groups | 👤 Customer |
| Physical Server | ☁️ AWS |
| Hypervisor | ☁️ AWS |

### RDS (PaaS - AWS does more)

| Layer | Who? |
|-------|------|
| Database Data | 👤 Customer |
| User Permissions | 👤 Customer |
| Security Groups | 👤 Customer |
| OS Patching | ☁️ AWS |
| Database Patching | ☁️ AWS |
| Backups | ☁️ AWS |

### S3 / DynamoDB (SaaS-like - AWS does most)

| Layer | Who? |
|-------|------|
| Your Data | 👤 Customer |
| Bucket/Table Policies | 👤 Customer |
| IAM Permissions | 👤 Customer |
| Everything Else | ☁️ AWS |

---

## Shared Controls (Tricky!)

Some controls are **shared but separate**:

| Control | AWS Does | You Do |
|---------|----------|--------|
| **Patch Management** | Patches infrastructure | Patches your EC2 OS, apps |
| **Configuration** | Configures their infra | Configure security groups |
| **Training** | Trains AWS employees | Train YOUR employees |

---

## Common Exam Scenarios

| Scenario | Who is responsible? |
|----------|---------------------|
| EC2 hacked due to unpatched OS | **Customer** |
| Data center floods | **AWS** |
| S3 bucket publicly exposed | **Customer** |
| RDS database OS vulnerability | **AWS** |
| IAM credentials leaked | **Customer** |
| Hypervisor exploit | **AWS** |
| Lambda function insecure code | **Customer** |
| DynamoDB service down | **AWS** |

---

## Quick Memory Table

| Layer | EC2 | RDS | Lambda | S3 |
|-------|-----|-----|--------|-----|
| **Data** | 👤 You | 👤 You | 👤 You | 👤 You |
| **Application** | 👤 You | 👤 You | 👤 You | N/A |
| **Guest OS** | 👤 You | ☁️ AWS | ☁️ AWS | ☁️ AWS |
| **Platform** | ☁️ AWS | ☁️ AWS | ☁️ AWS | ☁️ AWS |
| **Infrastructure** | ☁️ AWS | ☁️ AWS | ☁️ AWS | ☁️ AWS |

---

## Key Memory Trick

> "If you can touch it, you're responsible for it!"

**ALWAYS AWS**: Physical security, Hardware, Hypervisor, Global infrastructure

**ALWAYS CUSTOMER**: Your data, IAM, Application code, Client-side encryption, Security Group rules

**DEPENDS ON SERVICE**: OS patching, Platform patching, Database engine updates
