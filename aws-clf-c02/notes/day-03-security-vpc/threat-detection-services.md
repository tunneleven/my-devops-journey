# AWS Threat Detection Services

> AWS Threat Detection = Your security team that never sleeps - GuardDuty watches for intruders, Inspector checks for weak locks, Macie finds sensitive papers

## The Big Picture

```
                    AWS THREAT DETECTION SERVICES
                              │
           ┌──────────────────┼──────────────────┐
           │                  │                  │
     ┌─────▼─────┐      ┌─────▼─────┐      ┌─────▼─────┐
     │ GuardDuty │      │ Inspector │      │   Macie   │
     │  (Threats)│      │  (Vulns)  │      │   (Data)  │
     └─────┬─────┘      └─────┬─────┘      └─────┬─────┘
           │                  │                  │
     ┌─────▼─────┐      ┌─────▼─────┐      ┌─────▼─────┐
     │CloudTrail │      │   EC2     │      │    S3     │
     │ VPC Logs  │      │Containers │      │ Buckets   │
     │ DNS Logs  │      │  Lambda   │      │           │
     └───────────┘      └───────────┘      └───────────┘
           │                  │                  │
           └──────────────────┼──────────────────┘
                              │
                    ┌─────────▼─────────┐
                    │   Security Hub    │
                    │ (Central Console) │
                    └───────────────────┘
```

---

## Service Comparison (EXAM FAVORITE!)

| Service | What It Does | What It Monitors | Trigger Keywords |
|---------|--------------|------------------|------------------|
| **GuardDuty** | Threat detection (ML-based) | CloudTrail, VPC Logs, DNS | "Threats", "API activity", "malicious" |
| **Inspector** | Vulnerability scanning | EC2, Containers, Lambda | "Vulnerabilities", "CVEs", "patching" |
| **Macie** | Sensitive data discovery | S3 buckets | "PII", "sensitive data", "GDPR" |
| **Detective** | Investigation/forensics | CloudTrail, VPC Logs, GuardDuty | "Investigate", "root cause", "forensics" |

---

## Amazon GuardDuty

> **The Security Guard** - Watches for intruders 24/7

**What:** Intelligent threat detection using ML and threat intelligence.

**Data Sources:**
```
GuardDuty Analyzes:
├── CloudTrail Logs → API activity (who did what)
├── VPC Flow Logs → Network traffic patterns
├── DNS Logs → Suspicious domain queries
├── S3 Data Events → Bucket access patterns
└── EKS Audit Logs → Kubernetes activity
```

**Detects:**
- 🔴 Compromised EC2 instances
- 🔴 Cryptocurrency mining
- 🔴 Reconnaissance attacks
- 🔴 Data exfiltration
- 🔴 Unusual API calls

**Key Points:**
| Feature | Detail |
|---------|--------|
| Deployment | **One-click enable** - no agents |
| Monitoring | **24/7 continuous** |
| Technology | **ML-based** anomaly detection |
| Cost | Pay per logs analyzed |

**Memory Hook:** *"GuardDuty GUARDS your account from threats"*

---

## Amazon Inspector

> **The Building Inspector** - Checks for weak locks and broken windows

**What:** Automated vulnerability assessment service.

**What It Scans:**
```
Inspector Targets:
├── EC2 Instances → OS and software vulnerabilities
├── ECR Images → Container vulnerabilities
└── Lambda Functions → Code dependencies
```

**Checks For:**
- Software vulnerabilities (CVEs)
- Network exposure
- Unpatched packages
- Best practice deviations

**Key Points:**
| Feature | Detail |
|---------|--------|
| EC2 Requirement | **SSM Agent** must be installed |
| Scanning | **Continuous** when enabled |
| Output | Findings with **severity ratings** |
| Coverage | EC2, Lambda, ECR containers |

**Memory Hook:** *"Inspector INSPECTS for vulnerabilities (CVEs)"*

---

## Amazon Macie

> **The Document Classifier** - Finds sensitive papers in your filing cabinet

**What:** Data discovery and protection service using ML.

**Focus:** Amazon S3 ONLY

**What It Detects:**
```
Macie Finds:
├── PII (names, SSN, addresses)
├── Financial (credit cards, bank accounts)
├── Health (PHI, medical records)
├── Credentials (API keys, passwords in files)
└── Bucket Issues (public, unencrypted)
```

**Key Points:**
| Feature | Detail |
|---------|--------|
| Scope | **S3 buckets only** |
| Technology | **ML-based** data classification |
| Compliance | Helps with **GDPR, HIPAA, PCI-DSS** |
| Alerts | Findings on sensitive data exposure |

**Memory Hook:** *"Macie finds MY data (PII) in S3"*

---

## Amazon Detective

> **The Investigator** - Figures out what happened after GuardDuty sounds the alarm

**What:** Security investigation and forensics service.

**How It Works:**
```
GuardDuty Alert: "Suspicious activity detected!"
         │
         ▼
Detective: "Let me investigate..."
├── Collects data from CloudTrail, VPC Logs
├── Creates visual timelines
├── Shows resource relationships
└── Helps find root cause
```

**Key Points:**
| Feature | Detail |
|---------|--------|
| Trigger | Works **after** GuardDuty finds threat |
| Data | Uses CloudTrail, VPC Flow Logs |
| Output | Visual investigation graphs |
| Purpose | **Root cause analysis** |

**Memory Hook:** *"Detective DETECTS the cause (investigates)"*

---

## How They Work Together

```
DETECTION FLOW:

1. GuardDuty → "Something suspicious is happening!"
         │
         ▼
2. Detective → Investigate what happened
         │
         ▼
3. Security Hub → Centralized view of all findings

PREVENTION FLOW:

1. Inspector → "Found unpatched vulnerability"
         │
         ▼
2. Patch the system before attackers exploit

DATA PROTECTION FLOW:

1. Macie → "Found exposed PII in S3"
         │
         ▼
2. Encrypt or restrict access
```

---

## Decision Tree

```
What's the security concern?
├── "Threats/malicious activity" → GuardDuty
├── "Vulnerabilities/CVEs" → Inspector
├── "Sensitive data in S3" → Macie
├── "Investigate an incident" → Detective
└── "Central security view" → Security Hub
```

---

## 📝 Exam Practice Questions

### Question 1
**A company wants to detect unusual API activity in their AWS account. Which service should they use?**

A) Amazon Inspector  
B) Amazon Macie  
C) Amazon GuardDuty  
D) AWS Config  

<details><summary>Answer</summary>
**C) Amazon GuardDuty** - GuardDuty monitors CloudTrail logs to detect unusual API activity using ML-based threat detection.
</details>

---

### Question 2
**Which AWS service scans EC2 instances for software vulnerabilities and CVEs?**

A) Amazon GuardDuty  
B) Amazon Inspector  
C) Amazon Macie  
D) AWS Shield  

<details><summary>Answer</summary>
**B) Amazon Inspector** - Inspector is specifically designed for vulnerability scanning of EC2, containers, and Lambda functions.
</details>

---

### Question 3
**A healthcare company needs to find PHI (Protected Health Information) stored in their S3 buckets. Which service helps?**

A) Amazon GuardDuty  
B) Amazon Inspector  
C) Amazon Macie  
D) Amazon Detective  

<details><summary>Answer</summary>
**C) Amazon Macie** - Macie uses ML to discover and classify sensitive data (including PHI) stored in Amazon S3.
</details>

---

### Question 4
**After GuardDuty detects a security threat, which service helps investigate the root cause?**

A) AWS Config  
B) Amazon Inspector  
C) Amazon Detective  
D) AWS CloudTrail  

<details><summary>Answer</summary>
**C) Amazon Detective** - Detective is designed for security investigation and root cause analysis after threats are detected.
</details>

---

### Question 5
**Which statement about threat detection services is CORRECT?**

A) Inspector monitors CloudTrail logs for threats  
B) GuardDuty scans EC2 for vulnerabilities  
C) Macie only works with S3 data  
D) Detective requires agents on EC2  

<details><summary>Answer</summary>
**C) Macie only works with S3 data** - Macie is specifically focused on discovering sensitive data in Amazon S3 buckets.
</details>

---

## Memory Summary Table

| Service | Icon | What | Where | Keyword |
|---------|------|------|-------|---------|
| **GuardDuty** | 🛡️ | Threat detection | Account/VPC | "Threats" |
| **Inspector** | 🔍 | Vulnerability scan | EC2/Lambda | "CVEs" |
| **Macie** | 📄 | Data discovery | S3 only | "PII" |
| **Detective** | 🕵️ | Investigation | Post-incident | "Root cause" |

**Ultimate Memory Hook:**
> **G**uards watch for **I**ntrusions, **M**acie finds **D**ata
> (GuardDuty → Inspector → Macie → Detective)

---

## Quick Reference

| "Need to..." | Use This |
|--------------|----------|
| Detect malicious activity | GuardDuty |
| Find unpatched software | Inspector |
| Locate PII in S3 | Macie |
| Investigate a breach | Detective |
| See all findings in one place | Security Hub |
