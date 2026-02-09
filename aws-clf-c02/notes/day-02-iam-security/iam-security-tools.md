# IAM Security Tools

> AWS provides 3 key tools to monitor and audit IAM

```
📋 CREDENTIALS REPORT   → "Who has what credentials?"
🔍 ACCESS ANALYZER      → "Is anything exposed?"
📊 ACCESS ADVISOR       → "What services aren't used?"
```

---

## 📋 IAM Credentials Report

> **Account-level** report listing ALL users and their credential status

### What It Shows

- Password age and last used
- MFA enabled or not
- Access keys status (active/inactive)
- Access key last used and rotation date
- Password policy compliance

### How to Generate

| Method | Steps |
|--------|-------|
| Console | IAM → Credential Report → Download |
| CLI | `aws iam generate-credential-report` |

**Note:** Updates every **4 hours**

### Use Cases

| Scenario | Look For |
|----------|----------|
| Security audit | Users without MFA |
| Compliance | Keys not rotated 90+ days |
| Clean up | Users who never logged in |

---

## 🔍 IAM Access Analyzer

> Find resources **shared externally** (unintended public access)

### What It Scans

- 🪣 S3 buckets accessible from internet
- 🔑 KMS keys shared with other accounts
- 🎭 IAM roles assumable externally
- 📨 SQS queues with public access
- λ Lambda with external permissions

### How It Works

1. Define "Zone of Trust" (your account/org)
2. Analyzer continuously scans policies
3. Resource accessible from OUTSIDE zone → FINDING!

### Use Cases

| Scenario | Helps With |
|----------|------------|
| Security review | Find public S3 buckets |
| Compliance | Detect cross-account sharing |
| Remediation | Fix recommendations |

---

## 📊 IAM Access Advisor

> Shows **when services were last accessed** by user/role

### What It Shows

| Service | Last Accessed |
|---------|---------------|
| S3 | 2 days ago |
| EC2 | 5 days ago |
| DynamoDB | Never |
| RDS | Never |

### How It Helps Least Privilege

```
User has: FullAWSAccess (too broad!)
         ↓
Advisor shows: Only uses S3, EC2
         ↓
Action: Remove unused permissions
         ↓
Result: Reduced attack surface ✅
```

### Use Cases

| Scenario | Helps With |
|----------|------------|
| Right-sizing | Remove unused permissions |
| Audit | Verify actual usage |
| Least privilege | Identify broad policies |

---

## Comparison Table

| Tool | Level | Purpose |
|------|-------|---------|
| **Credentials Report** | Account | Audit user credentials |
| **Access Analyzer** | Account/Org | Find external access |
| **Access Advisor** | User/Role | Track service usage |

---

## Exam Scenarios

| Question | Answer |
|----------|--------|
| Find users without MFA? | **Credentials Report** |
| Find public S3 buckets? | **Access Analyzer** |
| Reduce permissions safely? | **Access Advisor** |
| Find old access keys? | **Credentials Report** |

---

## Summary

| Tool | Memory Hook |
|------|-------------|
| **Credentials Report** | Account-wide user audit |
| **Access Analyzer** | What's exposed? |
| **Access Advisor** | What's being used? |
