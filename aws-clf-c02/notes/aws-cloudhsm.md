# AWS CloudHSM (Hardware Security Module)

> CloudHSM = Your personal safe deposit box at AWS - you have the ONLY keys, not even AWS can open it

---

## What is an HSM?

**HSM = Hardware Security Module** - A dedicated physical device that:
- Generates encryption keys
- Stores keys securely
- Performs crypto operations
- Keys **never leave** the hardware

```
Traditional Software Encryption:        HSM Encryption:
                                        
┌─────────────────────┐               ┌─────────────────────┐
│     Server RAM      │               │   Tamper-Resistant  │
│  ┌───────────────┐  │               │      Hardware       │
│  │ 🔑 Keys in    │  │               │  ┌───────────────┐  │
│  │   memory      │←──────Steal      │  │ 🔐 Keys in    │  │
│  └───────────────┘  │               │  │   hardware    │  │
│                     │               │  └───────────────┘  │
│  Vulnerable!        │               │  Keys NEVER leave!  │
└─────────────────────┘               └─────────────────────┘
```

---

## CloudHSM Architecture

```
                    YOUR VPC
        ┌──────────────────────────────┐
        │                              │
        │   ┌────────────────────┐     │
        │   │  CloudHSM Cluster  │     │
        │   │  ┌──────┐ ┌──────┐ │     │
        │   │  │ HSM  │ │ HSM  │ │     │
        │   │  │  1   │ │  2   │ │     │
        │   │  └──────┘ └──────┘ │     │
        │   │   You control!     │     │
        │   └─────────┬──────────┘     │
        │             │                │
        │   ┌─────────▼──────────┐     │
        │   │   Your Apps/EC2    │     │
        │   └────────────────────┘     │
        └──────────────────────────────┘
                      │
                      ▼
            ┌───────────────┐
            │   AWS = $0    │
            │ Access to Keys│
            └───────────────┘
```

**Key Point:** AWS provisions the hardware, but **YOU control the keys** - AWS has ZERO access!

---

## FIPS 140-2 Levels (EXAM IMPORTANT!)

| Level | Security | Who Uses |
|-------|----------|----------|
| Level 1 | Basic, software-only | General |
| Level 2 | Tamper-evident seals | **KMS** |
| **Level 3** | Tamper-resistant hardware | **CloudHSM** ✅ |
| Level 4 | Physical penetration protection | Rare |

**Memory Hook:** CloudHSM = **Level 3** = "**3** letters in HSM"

---

## KMS vs CloudHSM

| Feature | KMS | CloudHSM |
|---------|-----|----------|
| **Hardware** | Shared (multi-tenant) | **Dedicated** (single-tenant) |
| **Key Access** | AWS can access | **Only YOU** |
| **Compliance** | FIPS 140-2 Level 2 | **FIPS 140-2 Level 3** |
| **Management** | AWS manages | **You manage** |
| **Cost** | ~$1/key/month | **~$1.50/hour** |
| **Custom Crypto** | Limited | **Full control** |

---

## When to Use CloudHSM

```
Decision Tree:

Need FIPS 140-2 Level 3?
├── YES → CloudHSM ✅
└── NO
    ├── Need AWS to have ZERO key access?
    │   ├── YES → CloudHSM ✅
    │   └── NO → KMS
    ├── Need custom crypto operations?
    │   ├── YES → CloudHSM ✅
    │   └── NO → KMS
    └── Just want easy encryption?
        └── KMS ✅
```

### CloudHSM Use Cases

| Use Case | Why CloudHSM |
|----------|--------------|
| **Payment processing** | PCI-DSS requires Level 3 |
| **PKI/Certificate Authority** | Store CA private keys |
| **Database encryption (Oracle TDE)** | Custom crypto support |
| **Healthcare (HIPAA)** | Strict compliance |
| **Financial transactions** | Zero AWS access to keys |
| **Migrate on-prem HSM** | Replace datacenter HSMs |

---

## KMS Custom Key Store (Best of Both!)

```
                    ┌───────────────────┐
                    │      KMS API      │  ← Easy to use
                    │   (Managed UI)    │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   Custom Key      │  ← Your choice
                    │     Store         │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    CloudHSM       │  ← FIPS Level 3
                    │    Cluster        │  ← Keys stay here
                    └───────────────────┘
```

**Why?** Get KMS's easy API + CloudHSM's dedicated hardware

---

## Pricing

| Component | Cost |
|-----------|------|
| **HSM instance** | ~$1.50/hour (~$1,080/month) |
| **Backup storage** | Per GB/month |
| **Scale to zero** | $0 when no HSMs running |

**vs KMS:** $1/key/month - much cheaper for simple needs!

---

## 📝 Exam Practice Questions

### Question 1
**A financial company requires FIPS 140-2 Level 3 compliance for storing encryption keys. Which service should they use?**

A) AWS KMS  
B) AWS CloudHSM  
C) AWS Secrets Manager  
D) AWS Certificate Manager  

<details><summary>Answer</summary>
**B) AWS CloudHSM** - Only CloudHSM provides FIPS 140-2 Level 3 validated hardware security modules.
</details>

---

### Question 2
**Which statement about AWS CloudHSM is CORRECT?**

A) AWS manages and has access to your encryption keys  
B) CloudHSM uses shared (multi-tenant) hardware  
C) Keys are stored in dedicated, single-tenant hardware  
D) CloudHSM is cheaper than KMS  

<details><summary>Answer</summary>
**C) Keys are stored in dedicated, single-tenant hardware** - CloudHSM provides single-tenant HSMs where only you control the keys.
</details>

---

### Question 3
**A company wants to use KMS APIs but store keys in dedicated hardware. Which solution works?**

A) Use AWS managed keys  
B) Use customer managed keys  
C) Create a KMS custom key store backed by CloudHSM  
D) Use AWS Secrets Manager  

<details><summary>Answer</summary>
**C) Create a KMS custom key store backed by CloudHSM** - This combines KMS's managed interface with CloudHSM's dedicated hardware.
</details>

---

### Question 4
**What is the main difference between KMS and CloudHSM regarding key access?**

A) KMS keys are more secure than CloudHSM  
B) AWS can access KMS keys but has zero access to CloudHSM keys  
C) CloudHSM keys can be shared between AWS accounts  
D) KMS provides FIPS 140-2 Level 3 compliance  

<details><summary>Answer</summary>
**B) AWS can access KMS keys but has zero access to CloudHSM keys** - With CloudHSM, you are the only one who controls the keys.
</details>

---

## Memory Summary

| Term | Remember |
|------|----------|
| **HSM** | **H**ardware **S**ecurity **M**odule - physical device for keys |
| **CloudHSM** | "Cloud-based safe" - you have the only key |
| **FIPS 140-2 L3** | "**3** letters in HSM" = Level **3** |
| **Single-tenant** | Dedicated hardware just for you |
| **Zero AWS access** | AWS CAN'T see your CloudHSM keys |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "FIPS 140-2 Level 3" | **CloudHSM** |
| "Dedicated hardware" | **CloudHSM** |
| "AWS has no access to keys" | **CloudHSM** |
| "Single-tenant HSM" | **CloudHSM** |
| "Custom crypto operations" | **CloudHSM** |
| "Easy managed encryption" | **KMS** |
| "Cost-effective encryption" | **KMS** |
