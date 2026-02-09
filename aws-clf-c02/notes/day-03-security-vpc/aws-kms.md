# AWS KMS (Key Management Service)

> AWS KMS = Your master keychain - one place to create, control, and audit all your encryption keys

---

## The Big Picture

```
                        AWS KMS
                           │
     ┌─────────────────────┼─────────────────────┐
     │                     │                     │
     ▼                     ▼                     ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ AWS Managed │     │  Customer   │     │ AWS Owned   │
│    Keys     │     │ Managed Keys│     │    Keys     │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                   │
   AWS creates         You create          AWS uses
   You use             You control        Invisibly
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ 100+ AWS Services   │
                │ S3, EBS, RDS, etc.  │
                └─────────────────────┘
```

---

## Key Types (EXAM FAVORITE!)

| Key Type | Who Creates | Who Manages | Cost | CloudTrail Audit |
|----------|-------------|-------------|------|------------------|
| **AWS Managed** | AWS | AWS | Free (API calls only) | ✅ Yes |
| **Customer Managed** | You | You | $1/month + API calls | ✅ Yes |
| **AWS Owned** | AWS | AWS | Free | ❌ No |

### When to Use Each

```
Decision Tree:

Need full control over keys?
├── YES → Customer Managed Key
└── NO
    ├── Need to see audit logs?
    │   ├── YES → AWS Managed Key
    │   └── NO → AWS Owned Key (default, hidden)
```

---

## Symmetric vs Asymmetric Keys

| Type | Keys | Use Case | Rotation |
|------|------|----------|----------|
| **Symmetric** | 1 key (shared secret) | Encrypt/decrypt data | ✅ Auto (yearly) |
| **Asymmetric** | 2 keys (public + private) | Sign/verify, encrypt outside AWS | ❌ Manual only |

**Default:** Symmetric AES-256 (most common, used by AWS services)

---

## KMS vs CloudHSM

| Feature | KMS | CloudHSM |
|---------|-----|----------|
| **Model** | Multi-tenant (shared) | Single-tenant (dedicated) |
| **Hardware** | AWS manages HSM | You manage HSM cluster |
| **Key Control** | AWS + You | You ONLY |
| **Compliance** | FIPS 140-2 Level 2 | **FIPS 140-2 Level 3** |
| **Cost** | ~$1/key/month | ~$1.50/hour |
| **Use Case** | Standard encryption | Strict compliance, key export |

**Memory Hook:**
- **KMS** = "**K**eep it **M**anaged (by AWS)" = Easy, integrated
- **CloudHSM** = "**H**ardware **S**elf-**M**anaged" = You control everything

---

## Integration with AWS Services

```
KMS encrypts data for 100+ services:

┌─────────────────────────────────────────────┐
│              AWS KMS Keys                   │
└─────────────────────────────────────────────┘
         │         │         │         │
         ▼         ▼         ▼         ▼
      ┌─────┐  ┌─────┐  ┌─────┐  ┌───────────┐
      │ S3  │  │ EBS │  │ RDS │  │ Secrets   │
      │     │  │     │  │     │  │ Manager   │
      └─────┘  └─────┘  └─────┘  └───────────┘
      
      SSE-KMS   Volume    Database   Secret
      Encryption Encrypt  Encrypt    Encrypt
```

### S3 Encryption Options

| Option | Key Location | Audit Trail |
|--------|--------------|-------------|
| **SSE-S3** | AWS manages | ❌ No |
| **SSE-KMS** | KMS (you pick key) | ✅ Yes (CloudTrail) |
| **SSE-C** | Customer provides | ❌ No |

---

## Key Features Summary

| Feature | Details |
|---------|---------|
| **Automatic Rotation** | Yearly for symmetric keys |
| **Multi-Region Keys** | Same key ID across regions |
| **Audit Logging** | Every key use logged in CloudTrail |
| **IAM Integration** | Control access via policies |
| **Envelope Encryption** | Data key encrypts data, KMS key encrypts data key |

---

## 📝 Exam Practice Questions

### Question 1
**A company needs to encrypt S3 data with full control over key rotation and audit every key access. Which approach should they use?**

A) SSE-S3  
B) SSE-KMS with AWS managed key  
C) SSE-KMS with customer managed key  
D) CloudHSM  

<details><summary>Answer</summary>
**C) SSE-KMS with customer managed key** - Provides full control over rotation policies and all key usage is logged in CloudTrail.
</details>

---

### Question 2
**Which AWS service should a company use if they require FIPS 140-2 Level 3 compliance for encryption keys?**

A) AWS KMS  
B) AWS CloudHSM  
C) AWS Secrets Manager  
D) AWS Certificate Manager  

<details><summary>Answer</summary>
**B) AWS CloudHSM** - Only CloudHSM provides dedicated, single-tenant HSMs with FIPS 140-2 Level 3 validation.
</details>

---

### Question 3
**What is the main difference between AWS managed keys and customer managed keys in KMS?**

A) Only customer managed keys support encryption  
B) Customer managed keys give you full control over key policies and lifecycle  
C) AWS managed keys are more secure  
D) Customer managed keys cannot be rotated  

<details><summary>Answer</summary>
**B) Customer managed keys give you full control over key policies and lifecycle** - You control rotation, deletion, and who can access the key.
</details>

---

### Question 4
**A developer needs to encrypt data in an application running outside AWS. Which KMS key type should they use?**

A) Symmetric key  
B) Asymmetric key  
C) AWS managed key  
D) AWS owned key  

<details><summary>Answer</summary>
**B) Asymmetric key** - Use the public key to encrypt outside AWS, private key in KMS to decrypt.
</details>

---

### Question 5
**Which statement about KMS key types is CORRECT?**

A) AWS owned keys are visible in CloudTrail  
B) AWS managed keys cost $1/month per key  
C) Customer managed keys support automatic yearly rotation  
D) Asymmetric keys automatically rotate  

<details><summary>Answer</summary>
**C) Customer managed keys support automatic yearly rotation** - Symmetric customer managed keys can be configured for automatic annual rotation.
</details>

---

## Memory Summary Table

| Feature | KMS | CloudHSM |
|---------|-----|----------|
| **Icon** | 🔑 | 🔐 |
| **Model** | Shared (multi-tenant) | Dedicated |
| **Control** | AWS + You | You only |
| **Compliance** | Level 2 | Level 3 |
| **Cost** | Low | High |
| **Keyword** | "Managed keys" | "Hardware", "FIPS Level 3" |

---

## Quick Decision Guide

| Scenario | Answer |
|----------|--------|
| "Encrypt with AWS managing keys" | KMS (AWS managed) |
| "Full control over encryption keys" | KMS (Customer managed) |
| "Audit every key access" | KMS + CloudTrail |
| "FIPS 140-2 Level 3" | CloudHSM |
| "Dedicated hardware for keys" | CloudHSM |
| "Encrypt S3 with audit trail" | SSE-KMS |
