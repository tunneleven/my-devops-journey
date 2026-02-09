# AWS Secrets Manager

> Secrets Manager = Your password manager for AWS - stores, rotates, and retrieves secrets automatically

---

## The Big Picture

```
WITHOUT Secrets Manager:              WITH Secrets Manager:
                                        
┌─────────────────────┐               ┌─────────────────────┐
│   Your App Code     │               │   Your App Code     │
│  ┌───────────────┐  │               │  ┌───────────────┐  │
│  │ password =    │  │               │  │ call Secrets  │  │
│  │ "MyP@ssw0rd!" │←── Exposed!     │  │ Manager API   │───┤
│  └───────────────┘  │               │  └───────────────┘  │
└─────────────────────┘               └─────────────────────┘
                                                  │
Hardcoded secrets = BAD                           ▼
                                      ┌─────────────────────┐
                                      │  Secrets Manager    │
                                      │  🔐 Encrypted       │
                                      │  🔄 Auto-rotates    │
                                      └─────────────────────┘
```

---

## What It Stores

| Secret Type | Examples |
|-------------|----------|
| **Database credentials** | RDS username/password |
| **API keys** | Third-party service keys |
| **OAuth tokens** | Access/refresh tokens |
| **SSH keys** | Private keys |
| **Any sensitive data** | Connection strings, configs |

---

## Key Features

```
Secrets Manager Features:

┌────────────────────────────────────────────────────────┐
│                    SECRETS MANAGER                      │
├───────────────┬───────────────┬───────────────┬────────┤
│   🔐 Store    │  🔄 Rotate    │  📡 Retrieve  │ 🔗     │
│   Encrypted   │  Automatic    │  API/SDK      │ Integrate
│   with KMS    │  (Lambda)     │  calls        │ RDS    │
└───────────────┴───────────────┴───────────────┴────────┘
```

### Automatic Rotation (EXAM FAVORITE!)

```
Rotation Flow:

Day 1: password = "OldP@ss123"
              │
         ┌────▼────┐
         │ Lambda  │  ← Secrets Manager triggers
         │ Rotator │
         └────┬────┘
              │
Day 30: password = "NewP@ss456" (auto-generated!)
              │
              ▼
         ┌─────────┐
         │   RDS   │  ← Automatically updated!
         │Database │
         └─────────┘
```

**No downtime, no manual work!**

---

## Integration with RDS & Redshift

| Feature | How It Works |
|---------|--------------|
| **Store credentials** | Secrets Manager holds DB username/password |
| **Auto-rotate** | Lambda function updates DB password periodically |
| **Seamless access** | Apps call Secrets Manager API to get current creds |

```
App → Secrets Manager → "What's the DB password?" 
                      ← "Here: NewP@ss456"
                                ↓
                               RDS
```

---

## Secrets Manager vs Parameter Store

| Feature | Secrets Manager | Parameter Store |
|---------|-----------------|-----------------|
| **Purpose** | **Secrets** (passwords, keys) | **Config** (settings, strings) |
| **Auto Rotation** | ✅ **Built-in** | ❌ Manual only |
| **Encryption** | Always KMS | Optional (SecureString) |
| **Cost** | $0.40/secret/month | Free tier available |
| **Best For** | DB creds, API keys | App configs, feature flags |

### Decision Tree

```
What are you storing?
├── Database password → Secrets Manager ✅
├── API key that rotates → Secrets Manager ✅
├── App config string → Parameter Store ✅
├── Feature flag → Parameter Store ✅
└── Need auto-rotation? → Secrets Manager ✅
```

**Memory Hook:** 
- **Secrets** Manager = **S**ensitive stuff that **R**otates
- **Parameter** Store = **P**lain configs, **S**tatic values

---

## Pricing

| Component | Cost |
|-----------|------|
| **Per secret** | $0.40/month |
| **API calls** | $0.05 per 10,000 calls |
| **Rotation** | Lambda charges (~$0.0004/request) |

**Exam Tip:** Use Parameter Store for non-rotating configs to save money!

---

## 📝 Exam Practice Questions

### Question 1
**A company wants to automatically rotate their RDS database passwords every 30 days. Which service should they use?**

A) AWS Systems Manager Parameter Store  
B) AWS Secrets Manager  
C) AWS KMS  
D) AWS IAM  

<details><summary>Answer</summary>
**B) AWS Secrets Manager** - It provides built-in automatic rotation for database credentials with native RDS integration.
</details>

---

### Question 2
**What is the PRIMARY difference between Secrets Manager and Parameter Store?**

A) Secrets Manager is free, Parameter Store is paid  
B) Secrets Manager has built-in automatic rotation  
C) Parameter Store encrypts data, Secrets Manager does not  
D) Only Parameter Store integrates with RDS  

<details><summary>Answer</summary>
**B) Secrets Manager has built-in automatic rotation** - This is the key differentiator. Parameter Store requires manual updates.
</details>

---

### Question 3
**A developer needs to store application configuration settings that rarely change. Which is the most cost-effective option?**

A) AWS Secrets Manager  
B) AWS Systems Manager Parameter Store  
C) AWS CloudHSM  
D) Amazon S3  

<details><summary>Answer</summary>
**B) AWS Systems Manager Parameter Store** - It's free for basic use and perfect for static configuration data.
</details>

---

### Question 4
**How does Secrets Manager encrypt secrets at rest?**

A) Using S3 encryption  
B) Using SSL/TLS  
C) Using AWS KMS  
D) Secrets are not encrypted  

<details><summary>Answer</summary>
**C) Using AWS KMS** - Secrets Manager always encrypts secrets using KMS keys.
</details>

---

### Question 5
**Which AWS service should be used to securely store and automatically rotate API keys for a third-party service?**

A) AWS IAM  
B) AWS KMS  
C) AWS Secrets Manager  
D) AWS Certificate Manager  

<details><summary>Answer</summary>
**C) AWS Secrets Manager** - It's designed for storing and rotating secrets like API keys.
</details>

---

## Memory Summary

| Feature | Secrets Manager | Parameter Store |
|---------|-----------------|-----------------|
| **Icon** | 🔐 | 📝 |
| **Stores** | Secrets | Configs |
| **Rotates** | ✅ Auto | ❌ Manual |
| **Cost** | Paid | Free tier |
| **Keyword** | "Rotate", "Credentials" | "Config", "Settings" |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Rotate database credentials" | **Secrets Manager** |
| "Automatic password rotation" | **Secrets Manager** |
| "Store API keys securely" | **Secrets Manager** |
| "Store application config" | **Parameter Store** |
| "Cost-effective config storage" | **Parameter Store** |
| "Encrypt secrets with KMS" | **Secrets Manager** |
