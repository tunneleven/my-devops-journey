# AWS Security Hub

> Security Hub = Your security command center - one dashboard to see ALL security findings across AWS

---

## The Big Picture

```
                    SECURITY SOURCES
                          │
    ┌─────────────────────┼─────────────────────┐
    │           │         │         │           │
    ▼           ▼         ▼         ▼           ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│Guard   │ │Inspector│ │ Macie │ │ Config │ │3rd Party│
│Duty    │ │        │ │       │ │        │ │Tools   │
└────┬───┘ └────┬───┘ └───┬───┘ └────┬───┘ └────┬───┘
     │          │         │          │          │
     └──────────┴─────────┼──────────┴──────────┘
                          │
                          ▼
              ┌───────────────────────┐
              │    SECURITY HUB       │
              │  📊 Single Dashboard  │
              │  🔍 Prioritized View  │
              │  ✅ Compliance Checks │
              └───────────────────────┘
```

---

## What Security Hub Does

| Function | Description |
|----------|-------------|
| **Aggregate** | Collects findings from multiple services |
| **Prioritize** | Shows critical issues first |
| **Standardize** | Common format (ASFF) for all findings |
| **Automate** | Compliance checks against standards |

---

## Integrated Services

```
Security Hub Collects From:
├── GuardDuty → Threat detection findings
├── Inspector → Vulnerability findings
├── Macie → Sensitive data findings
├── Config → Compliance findings
├── Firewall Manager → Firewall findings
└── 3rd Party Tools → Partner integrations
```

---

## Security Standards (EXAM FAVORITE!)

| Standard | What It Checks |
|----------|----------------|
| **CIS AWS Foundations** | Best practice security controls |
| **PCI DSS** | Payment card security |
| **AWS Foundational Security** | AWS best practices |
| **NIST** | Government security framework |

```
Security Hub Compliance:
┌────────────────────────────────────────┐
│ CIS AWS Foundations Benchmark          │
├────────────────────────────────────────┤
│ ✅ 1.1 Root account MFA enabled        │
│ ✅ 1.2 IAM password policy             │
│ ❌ 1.3 No root access keys (FAILED)    │
│ ✅ 1.4 CloudTrail enabled              │
└────────────────────────────────────────┘
        │
        ▼
   Auto-remediate or investigate
```

---

## How It Works

```
Step 1: Enable Security Hub
              │
              ▼
Step 2: Enable Integrations (GuardDuty, Inspector, etc.)
              │
              ▼
Step 3: Select Security Standards (CIS, PCI)
              │
              ▼
Step 4: View Unified Dashboard
              │
              ▼
Step 5: Investigate & Remediate Findings
```

---

## 📝 Exam Practice Questions

### Question 1
**A company needs a centralized view of security findings from GuardDuty, Inspector, and Macie. Which service should they use?**

A) AWS Config  
B) AWS Security Hub  
C) AWS CloudTrail  
D) AWS Trusted Advisor  

<details><summary>Answer</summary>
**B) AWS Security Hub** - Security Hub aggregates findings from multiple security services into a single dashboard.
</details>

---

### Question 2
**Which security standard can AWS Security Hub automatically check against?**

A) OWASP Top 10  
B) CIS AWS Foundations Benchmark  
C) SANS Top 25  
D) ISO 9001  

<details><summary>Answer</summary>
**B) CIS AWS Foundations Benchmark** - Security Hub supports CIS, PCI DSS, and AWS Foundational Security standards.
</details>

---

### Question 3
**What is the PRIMARY benefit of AWS Security Hub?**

A) Encrypt data at rest  
B) Provide centralized security findings and compliance checks  
C) Detect malware in EC2 instances  
D) Manage IAM permissions  

<details><summary>Answer</summary>
**B) Provide centralized security findings and compliance checks** - Security Hub aggregates, prioritizes, and checks compliance across multiple services.
</details>

---

### Question 4
**A security team wants to automatically check if their AWS environment meets PCI DSS requirements. Which service helps?**

A) AWS Artifact  
B) AWS Security Hub  
C) AWS GuardDuty  
D) AWS Shield  

<details><summary>Answer</summary>
**B) AWS Security Hub** - It can run automated compliance checks against PCI DSS standards.
</details>

---

## Memory Summary

| Feature | Details |
|---------|---------|
| **Purpose** | Centralized security dashboard |
| **Integrates with** | GuardDuty, Inspector, Macie, Config |
| **Standards** | CIS, PCI, AWS Foundational |
| **Cost** | Pay per finding/check |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Centralized security findings" | **Security Hub** |
| "Single dashboard for security" | **Security Hub** |
| "CIS/PCI compliance checks" | **Security Hub** |
| "Aggregate GuardDuty + Inspector" | **Security Hub** |
| "Security posture management" | **Security Hub** |

---

## Security Hub vs Other Services

| Service | Purpose |
|---------|---------|
| **Security Hub** | **Aggregates** all security findings |
| **GuardDuty** | Detects threats |
| **Inspector** | Finds vulnerabilities |
| **Macie** | Finds sensitive data |
| **Config** | Checks configuration compliance |

**Memory Hook:** "Security Hub = The **HUB** where all security services meet"
