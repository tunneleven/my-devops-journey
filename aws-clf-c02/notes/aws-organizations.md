# AWS Organizations

> AWS Organizations = "Parent Company" managing multiple "Child Companies" (AWS accounts)

## What AWS Organizations Does

| # | Function | Example |
|---|----------|---------|
| 1️⃣ | **Organize accounts** | Group by Production/Dev/Security |
| 2️⃣ | **Consolidated Billing** | 1 invoice for all accounts |
| 3️⃣ | **Access Control** (SCPs) | "Production can't create EC2 in unknown regions" |

---

## Core Components

### Structure Overview

```
🏢 ORGANIZATION ROOT
│
├── 💼 MANAGEMENT ACCOUNT (Root account)
│       → Pays ALL bills for the entire organization
│       → Has FULL administrative control
│       → Cannot be moved or removed
│
├── 📁 OU: PRODUCTION
│       ├── 🔷 Account: Prod-App1
│       └── 🔷 Account: Prod-App2
│
├── 📁 OU: DEVELOPMENT  
│       ├── 🔷 Account: Dev-Team1
│       └── 🔷 Account: Sandbox
│
└── 📁 OU: SECURITY
        ├── 🔷 Account: Audit
        └── 🔷 Account: Log Archive
```

---

### Management Account (💼)

The **root account** that creates the Organization.

```
Powers:
✅ Create/invite new accounts
✅ Pay ALL invoices
✅ Set rules (SCPs) for entire organization
✅ View spending per account
```

> ⚠️ **Golden Rule**: NEVER run applications in Management Account! Use for management only.

---

### Organizational Units - OUs (📁)

OUs are like **departments in a company**. Instead of managing each employee (account), you manage by department.

**Example:**
```
📁 OU: Production → Strict rules, limited regions
📁 OU: Development → Relaxed rules, sandbox allowed
📁 OU: Security → Stores logs, audit
```

**Key feature**: Rules applied to OU **automatically apply** to all accounts inside!

---

### Member Accounts (🔷)

Each account is a **separate AWS environment** with its own resources.

---

## Feature Sets

| Mode | Features |
|------|----------|
| **Consolidated Billing Only** | Shared billing only, no SCPs |
| **All Features** | Consolidated billing + SCPs + Tag Policies + AI Service Opt-outs |

---

## Consolidated Billing Benefits

```
┌─────────────────────────────────────────────────────────┐
│                 CONSOLIDATED BILLING                     │
├─────────────────────────────────────────────────────────┤
│ ✅ Single bill from Management Account                  │
│ ✅ Volume discounts (aggregate usage = better pricing)  │
│ ✅ Reserved Instances sharing across accounts           │
│ ✅ Savings Plans sharing                                │
│ ✅ Detailed cost reports per account                    │
│ ✅ Cost allocation tags                                 │
└─────────────────────────────────────────────────────────┘
```

**Example:**
```
Without Organizations:
├── Account A: 100GB S3 → $2.3/month
├── Account B: 100GB S3 → $2.3/month  
├── Account C: 100GB S3 → $2.3/month
└── TOTAL: $6.9/month

With Organizations (combined usage):
├── Total usage: 300GB S3
├── 300GB = cheaper tier pricing
└── TOTAL: $5.5/month 💰 (savings!)
```

---

## Service Control Policies (SCPs)

> SCP = Rules defining **maximum limits** that accounts can do

### Important Points to Remember

| ✅ SCP CAN | ❌ SCP CANNOT |
|-----------|--------------|
| BLOCK/DENY actions | GRANT/ALLOW permissions |
| Set guardrails | Replace IAM policies |
| Apply to entire account | Affect Management Account |

---

### How SCPs Work

Think of it as a **filter**:

```
Question: Can user create EC2 in eu-west-1?

           ┌─────────────┐
           │     SCP     │
           │  Allowed?   │
           └──────┬──────┘
                  │
        ┌─────────┴─────────┐
        ▼                   ▼
     ✅ YES               ❌ NO
        │                   │
        ▼                   ▼
 ┌─────────────┐     BLOCKED! 🚫
 │ IAM Policy  │
 │  Allowed?   │
 └──────┬──────┘
        │
 ┌──────┴──────┐
 ▼             ▼
✅ YES       ❌ NO
 │             │
 ▼             ▼
ALLOWED!    DENIED!
```

**Summary**: Must pass **BOTH** SCP and IAM to be allowed!

---

### SCP Examples

**SCP 1: Only allow 2 regions**
```json
{
  "Effect": "Deny",
  "Action": "*",
  "Resource": "*",
  "Condition": {
    "StringNotEquals": {
      "aws:RequestedRegion": ["ap-southeast-1", "us-east-1"]
    }
  }
}
```

**SCP 2: Don't allow deleting CloudTrail**
```json
{
  "Effect": "Deny",
  "Action": [
    "cloudtrail:DeleteTrail",
    "cloudtrail:StopLogging"
  ],
  "Resource": "*"
}
```

---

### SCP Inheritance

SCPs **flow down** from top to bottom:

```
🏢 Organization Root
│   └── SCP: "Deny all regions except ap-southeast-1"
│
├── 📁 OU: Production
│   │   └── SCP: "Deny delete RDS"
│   │
│   └── 🔷 Account: Prod-Web
│           → Inherits: Deny regions + Deny delete RDS
│
└── 📁 OU: Development
        └── 🔷 Account: Dev-Sandbox
                → Inherits: Deny regions only
```

---

## Exam Questions

**Q1**: Is Management Account affected by SCPs?
> **NO!** Management Account bypasses all SCPs.

**Q2**: If SCP denies EC2 but IAM allows EC2, can user create EC2?
> **NO!** SCP is a guardrail - if SCP denies, it's blocked. IAM cannot override.

**Q3**: Company wants all accounts to share Reserved Instances, which feature?
> **Consolidated Billing** in AWS Organizations.

---

## Summary

| Concept | One-line Memory |
|---------|-----------------|
| **Organizations** | Manage multiple accounts like a company |
| **Management Account** | Boss - pays bills, sets rules |
| **OUs** | Departments - group accounts |
| **Consolidated Billing** | 1 invoice, shared discounts |
| **SCPs** | Company rules - BLOCK not ALLOW |
