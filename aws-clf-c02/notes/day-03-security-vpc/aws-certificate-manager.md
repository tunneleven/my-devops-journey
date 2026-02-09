# AWS Certificate Manager (ACM)

> ACM = Free SSL certificates for AWS - never pay for HTTPS again, and never manually renew

---

## The Big Picture

```
WITHOUT ACM:                          WITH ACM:

Buy cert → $100+/year                 Request cert → FREE!
     │                                      │
     ▼                                      ▼
Install manually                      Auto-deploy to AWS services
     │                                      │
     ▼                                      ▼
Remember to renew                     Auto-renew forever
     │                                      │
     ▼                                      ▼
EXPIRED! Site down! 😱                 Always valid! 🎉
```

---

## What ACM Does

```
                        AWS Certificate Manager
                                  │
          ┌───────────────────────┼───────────────────────┐
          │                       │                       │
          ▼                       ▼                       ▼
    ┌──────────┐           ┌──────────┐           ┌──────────┐
    │ Provision│           │  Manage  │           │  Deploy  │
    │   Certs  │           │  & Renew │           │ to AWS   │
    └──────────┘           └──────────┘           └──────────┘
          │                       │                       │
          ▼                       ▼                       ▼
      Request                 Auto-renew            CloudFront
      FREE cert               before expiry         ALB, API GW
```

---

## Public vs Private Certificates

| Type | Use Case | Validation | Cost |
|------|----------|------------|------|
| **Public** | Internet-facing websites | DNS or Email | **FREE** ✅ |
| **Private** | Internal apps (VPC) | ACM Private CA | ~$0.75/cert/month |

### When to Use Each

```
Is your app public on the internet?
├── YES → Public certificate (FREE) ✅
└── NO (internal only)
    └── Need internal HTTPS? → Private certificate (ACM Private CA)
```

---

## Auto-Renewal (EXAM FAVORITE!)

| Validation Method | Auto-Renewal | Note |
|-------------------|--------------|------|
| **DNS validation** | ✅ **Automatic** | Recommended! |
| **Email validation** | ❌ Manual | Must click email link |

**Memory Hook:** "**D**NS = **D**one automatically"

---

## Integration with AWS Services

```
                  ┌─────────────────┐
                  │       ACM       │
                  │  (Certificate)  │
                  └────────┬────────┘
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               ▼               ▼
    ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
    │ CloudFront  │ │    ALB      │ │ API Gateway │
    │   (CDN)     │ │ (Load Bal)  │ │   (APIs)    │
    └─────────────┘ └─────────────┘ └─────────────┘
           │               │               │
           ▼               ▼               ▼
        HTTPS           HTTPS           HTTPS
       enabled!        enabled!        enabled!
```

### Supported Services

| Service | Use Case |
|---------|----------|
| **CloudFront** | Global HTTPS for websites/CDN |
| **ALB** | HTTPS load balancing for EC2 |
| **API Gateway** | HTTPS custom domains for APIs |
| **Elastic Beanstalk** | HTTPS for web apps |

**NOT Supported:** EC2 directly (must use ALB in front)

---

## Pricing

| Certificate Type | Cost |
|------------------|------|
| **Public certificates** | **FREE** (issuance + auto-renewal) |
| **Private CA** | ~$400/month per CA |
| **Private certificates** | ~$0.75 per certificate |

**Exam Tip:** ACM public certs are FREE - use them instead of buying from third parties!

---

## 📝 Exam Practice Questions

### Question 1
**A company wants to enable HTTPS for their website hosted behind an Application Load Balancer. Which service provides free SSL/TLS certificates?**

A) AWS KMS  
B) AWS Secrets Manager  
C) AWS Certificate Manager  
D) AWS CloudHSM  

<details><summary>Answer</summary>
**C) AWS Certificate Manager** - ACM provides free public SSL/TLS certificates that integrate with ALB.
</details>

---

### Question 2
**Which validation method allows ACM certificates to automatically renew?**

A) Email validation  
B) DNS validation  
C) Manual validation  
D) IAM validation  

<details><summary>Answer</summary>
**B) DNS validation** - DNS-validated certificates automatically renew as long as the DNS record exists.
</details>

---

### Question 3
**A company needs to secure internal applications within their VPC with HTTPS. Which ACM feature should they use?**

A) Public certificates  
B) ACM Private CA  
C) Imported certificates  
D) CloudFront certificates  

<details><summary>Answer</summary>
**B) ACM Private CA** - Private CA is used for internal/private applications that don't face the public internet.
</details>

---

### Question 4
**Which statement about AWS Certificate Manager is CORRECT?**

A) ACM certificates can be downloaded and used on any server  
B) Public ACM certificates are free for use with supported AWS services  
C) ACM only supports email validation  
D) ACM certificates must be manually renewed every year  

<details><summary>Answer</summary>
**B) Public ACM certificates are free for use with supported AWS services** - Public certificates are free and auto-renew.
</details>

---

### Question 5
**Which AWS service is NOT directly integrated with ACM?**

A) CloudFront  
B) Application Load Balancer  
C) EC2 instances  
D) API Gateway  

<details><summary>Answer</summary>
**C) EC2 instances** - ACM cannot deploy directly to EC2. You need an ALB in front to terminate SSL.
</details>

---

## Memory Summary

| Feature | Details |
|---------|---------|
| **Purpose** | Free SSL/TLS certificates |
| **Cost** | Public = FREE, Private = Paid |
| **Renewal** | DNS validation = Auto-renew |
| **Integrates with** | CloudFront, ALB, API Gateway |
| **Cannot deploy to** | EC2 directly |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Free SSL certificate" | **ACM** |
| "HTTPS for CloudFront/ALB" | **ACM** |
| "Auto-renew certificates" | **ACM + DNS validation** |
| "Internal HTTPS in VPC" | **ACM Private CA** |
| "SSL for EC2 directly" | ❌ Not ACM (use ALB + ACM) |

---

## ACM vs Other Services

| Service | Purpose |
|---------|---------|
| **ACM** | SSL/TLS certificates (HTTPS) |
| **KMS** | Encryption keys (data at rest) |
| **Secrets Manager** | Store passwords/API keys |
| **CloudHSM** | Dedicated hardware for keys |
