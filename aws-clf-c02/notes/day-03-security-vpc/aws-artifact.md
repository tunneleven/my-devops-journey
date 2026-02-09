# AWS Artifact

> AWS Artifact = Your compliance document library - download AWS's security certifications and agreements

---

## The Big Picture

```
                      AWS ARTIFACT
                           │
          ┌────────────────┴────────────────┐
          │                                 │
          ▼                                 ▼
    ┌───────────┐                    ┌───────────┐
    │  REPORTS  │                    │ AGREEMENTS│
    │  📋       │                    │  📝       │
    └─────┬─────┘                    └─────┬─────┘
          │                                │
    ┌─────┴─────┐                    ┌─────┴─────┐
    │ SOC 1/2/3 │                    │    BAA    │
    │ PCI DSS   │                    │   (HIPAA) │
    │ ISO 27001 │                    │    NDA    │
    │ HIPAA     │                    │           │
    └───────────┘                    └───────────┘
```

---

## What AWS Artifact Provides

### 1. Compliance Reports

| Report | What It Proves |
|--------|----------------|
| **SOC 1** | Financial reporting controls |
| **SOC 2** | Security, availability, confidentiality |
| **SOC 3** | Public version of SOC 2 |
| **PCI DSS** | Payment card security |
| **ISO 27001** | Information security management |
| **HIPAA** | Healthcare data protection |

### 2. Agreements

| Agreement | Purpose |
|-----------|---------|
| **BAA** (Business Associate Agreement) | Required for HIPAA compliance |
| **NDA** (Non-Disclosure Agreement) | Access to sensitive reports |

---

## How to Access

```
AWS Console → Search "Artifact" → AWS Artifact
       │
       ├── Reports → Download compliance reports
       │
       └── Agreements → Accept/manage agreements
```

**No setup required** - Available to all AWS customers for free!

---

## Common Use Cases

| Scenario | Solution |
|----------|----------|
| Your auditor asks for AWS SOC 2 report | Download from **Artifact** |
| Building HIPAA-compliant app | Accept **BAA** in Artifact |
| Customer asks for AWS security certification | Download from **Artifact** |

---

## 📝 Exam Practice Questions

### Question 1
**A company's auditor requests proof of AWS's PCI DSS compliance. Where should they download this report?**

A) AWS Trusted Advisor  
B) AWS Artifact  
C) AWS Config  
D) AWS Security Hub  

<details><summary>Answer</summary>
**B) AWS Artifact** - Artifact is the self-service portal for downloading AWS compliance reports like PCI DSS.
</details>

---

### Question 2
**A healthcare company needs to sign a Business Associate Agreement (BAA) with AWS for HIPAA compliance. Which service should they use?**

A) AWS Support  
B) AWS Organizations  
C) AWS Artifact  
D) AWS IAM  

<details><summary>Answer</summary>
**C) AWS Artifact** - BAAs are managed and accepted through AWS Artifact.
</details>

---

### Question 3
**Which compliance reports are available through AWS Artifact? (Select TWO)**

A) SOC 2  
B) Customer application security reports  
C) ISO 27001  
D) Third-party vendor assessments  

<details><summary>Answer</summary>
**A) SOC 2** and **C) ISO 27001** - Artifact provides AWS compliance reports, not customer application or third-party reports.
</details>

---

### Question 4
**What is the PRIMARY purpose of AWS Artifact?**

A) Monitor AWS resource compliance  
B) Provide on-demand access to AWS compliance documentation  
C) Encrypt data at rest  
D) Manage IAM permissions  

<details><summary>Answer</summary>
**B) Provide on-demand access to AWS compliance documentation** - Artifact is for downloading compliance reports and managing agreements.
</details>

---

## Memory Summary

| Feature | Details |
|---------|---------|
| **Purpose** | Download compliance reports & agreements |
| **Reports** | SOC, PCI, ISO, HIPAA |
| **Agreements** | BAA, NDA |
| **Cost** | **FREE** |
| **Access** | AWS Console → Artifact |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Download SOC report" | **Artifact** |
| "Download PCI compliance" | **Artifact** |
| "Sign BAA for HIPAA" | **Artifact** |
| "AWS compliance documentation" | **Artifact** |
| "Audit reports" | **Artifact** |

---

## Artifact vs Other Services

| Service | Purpose |
|---------|---------|
| **Artifact** | Download AWS compliance **reports** |
| **Config** | Check YOUR resource **compliance** |
| **Trusted Advisor** | Best practice **recommendations** |
| **Security Hub** | Centralized security **findings** |

**Memory Hook:** "**Artifact** = AWS's **Art**ifacts (documents/reports)"
