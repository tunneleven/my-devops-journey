# AWS Config

> AWS Config = Your compliance auditor - continuously checks if resources are configured correctly

---

## The Big Picture

```
                     AWS RESOURCES
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
   ┌────────┐        ┌────────┐        ┌────────┐
   │  EC2   │        │   S3   │        │  RDS   │
   │Instance│        │ Bucket │        │  DB    │
   └────┬───┘        └────┬───┘        └────┬───┘
        │                 │                 │
        └─────────────────┼─────────────────┘
                          │
                          ▼
                  ┌───────────────┐
                  │   AWS Config  │
                  │  📋 Evaluate  │
                  └───────┬───────┘
                          │
            ┌─────────────┼─────────────┐
            │             │             │
            ▼             ▼             ▼
       ┌────────┐   ┌──────────┐   ┌────────┐
       │COMPLIANT│   │NON-COMPLIANT│ │REMEDIATE│
       │   ✅    │   │    ❌     │   │  🔧    │
       └────────┘   └──────────┘   └────────┘
```

---

## What AWS Config Does

| Function | Description |
|----------|-------------|
| **Track** | Records configuration changes over time |
| **Evaluate** | Checks resources against rules |
| **Alert** | Notifies on non-compliance |
| **Remediate** | Auto-fixes non-compliant resources |

---

## Config Rules (EXAM FAVORITE!)

```
Config Rule = "Is encryption enabled on S3 buckets?"
                              │
                              ▼
               ┌──────────────────────────────┐
               │     Evaluate All Buckets     │
               └──────────────┬───────────────┘
                              │
           ┌──────────────────┼──────────────────┐
           │                  │                  │
           ▼                  ▼                  ▼
    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
    │ bucket-prod │    │ bucket-dev  │    │ bucket-logs │
    │ ✅ COMPLIANT │    │❌ NON-COMPLIANT│   │ ✅ COMPLIANT │
    │ (encrypted) │    │ (no encrypt)│    │ (encrypted) │
    └─────────────┘    └─────────────┘    └─────────────┘
```

### Rule Types

| Type | Description | Example |
|------|-------------|---------|
| **AWS Managed** | Pre-built by AWS | `s3-bucket-ssl-requests-only` |
| **Custom** | You create with Lambda | Check for specific tags |

---

## Remediation

| Type | How It Works |
|------|--------------|
| **Manual** | Alert sent → You fix it |
| **Automatic** | Config triggers Lambda/SSM → Auto-fixes |

```
Non-Compliant Resource Detected
              │
              ▼
    ┌─────────────────┐
    │ Remediation     │
    │ Action Trigger  │
    └────────┬────────┘
             │
    ┌────────┼────────┐
    │                 │
    ▼                 ▼
┌────────┐      ┌────────────┐
│ Lambda │      │ SSM        │
│Function│      │ Automation │
└────────┘      └────────────┘
```

---

## CloudTrail vs Config (EXAM FAVORITE!)

| Aspect | CloudTrail | Config |
|--------|------------|--------|
| **Focus** | **Actions** (API calls) | **State** (configurations) |
| **Question** | "Who did what?" | "Is it configured correctly?" |
| **Example** | "Who deleted the bucket?" | "Is encryption enabled?" |
| **Trigger** | API call made | Configuration changes |

### Memory Hook

```
Cloud TRAIL = Follow the TRAIL of WHO did WHAT
Config      = Is the CONFIG-uration CORRECT?
```

---

## Conformance Packs

| Feature | Description |
|---------|-------------|
| **What** | Bundle of Config rules for a standard |
| **Use Case** | PCI-DSS, HIPAA, SOC 2 compliance |
| **Benefit** | Deploy many rules at once |

```
Conformance Pack: "PCI-DSS"
├── s3-bucket-ssl-requests-only ✅
├── rds-storage-encrypted ✅
├── ec2-instance-managed-by-ssm ❌
└── ... 20 more rules
```

---

## 📝 Exam Practice Questions

### Question 1
**A company needs to ensure all S3 buckets have encryption enabled. Which service should they use?**

A) AWS CloudTrail  
B) AWS Config  
C) Amazon Inspector  
D) AWS GuardDuty  

<details><summary>Answer</summary>
**B) AWS Config** - Config rules can continuously evaluate S3 buckets for encryption compliance.
</details>

---

### Question 2
**What is the PRIMARY difference between CloudTrail and AWS Config?**

A) CloudTrail tracks configuration, Config tracks API calls  
B) CloudTrail tracks API calls, Config tracks compliance  
C) CloudTrail is free, Config is paid  
D) CloudTrail is regional, Config is global  

<details><summary>Answer</summary>
**B) CloudTrail tracks API calls, Config tracks compliance** - CloudTrail logs who did what; Config checks if resources are configured correctly.
</details>

---

### Question 3
**How can AWS Config automatically fix non-compliant resources?**

A) By sending email alerts  
B) By using remediation actions with Lambda or SSM  
C) By deleting the resource  
D) Config cannot auto-remediate  

<details><summary>Answer</summary>
**B) By using remediation actions with Lambda or SSM** - Config can trigger Lambda functions or SSM Automation to fix non-compliant resources.
</details>

---

### Question 4
**A company needs to deploy multiple Config rules for PCI-DSS compliance. What should they use?**

A) Config Aggregator  
B) Config Rule Group  
C) Conformance Pack  
D) Security Hub  

<details><summary>Answer</summary>
**C) Conformance Pack** - Conformance packs bundle multiple Config rules for compliance frameworks like PCI-DSS.
</details>

---

### Question 5
**Which AWS Config feature provides a historical record of resource configurations?**

A) Config Rules  
B) Configuration History  
C) Config Dashboard  
D) Remediation Actions  

<details><summary>Answer</summary>
**B) Configuration History** - Config maintains configuration items showing how resources changed over time.
</details>

---

## Memory Summary

| Service | Question It Answers |
|---------|---------------------|
| **CloudTrail** | "Who deleted the bucket?" |
| **Config** | "Is encryption enabled?" |
| **GuardDuty** | "Is there a threat?" |
| **Inspector** | "Are there vulnerabilities?" |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Compliance" | **Config** |
| "Is encryption enabled?" | **Config** |
| "Track configuration changes" | **Config** |
| "Auto-remediate" | **Config** |
| "Conformance pack" | **Config** |
| "Who did what?" | CloudTrail |
| "API activity" | CloudTrail |
