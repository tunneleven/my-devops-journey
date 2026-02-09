# AWS IAM (Identity and Access Management)

> **IAM** = The security system that controls WHO can do WHAT in your AWS account

**Key Facts:**
- IAM is **global** (not regional)
- IAM is **free** to use
- Follows **least privilege principle**

---

## Core Components

```
┌─────────────────────────────────────────────────────────────┐
│   👤 USERS          👥 GROUPS         🎭 ROLES              │
│   Individual        Collections       Temporary             │
│   identities        of users          identities            │
├─────────────────────────────────────────────────────────────┤
│   📜 POLICIES - JSON documents defining permissions         │
└─────────────────────────────────────────────────────────────┘
```

---

## 👤 IAM Users

- A person or application needing AWS access
- Has credentials: Console Password and/or Access Keys
- **ZERO permissions by default!**

---

## 👥 IAM Groups

- Collection of users for easier management
- Attach policy to group → all members inherit
- Users can belong to **multiple groups** (up to 10)
- Groups **cannot be nested**

---

## 🎭 IAM Roles

- Temporary identity that can be "assumed"
- Has Trust Policy (WHO can assume) + Permissions Policy (WHAT can do)
- Used for: EC2 accessing S3, Cross-account access, Lambda functions

**Key difference:**
- Users = long-term credentials
- Roles = temporary credentials (more secure!)

---

## 📜 IAM Policies

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::my-bucket/*"
  }]
}
```

| Element | Description |
|---------|-------------|
| **Effect** | Allow or Deny |
| **Action** | What API actions |
| **Resource** | Which resources |
| **Condition** | When it applies (optional) |

---

## Policy Types

| Type | Attached To | Example |
|------|------------|---------|
| **Identity-Based** | Users, Groups, Roles | "John can read S3" |
| **Resource-Based** | Resources (S3, SQS) | "This bucket allows John" |

| Type | Description |
|------|-------------|
| **AWS Managed** | Pre-built by AWS |
| **Customer Managed** | You create, reusable |
| **Inline** | Embedded in single identity |

---

## Root User vs IAM User

| Aspect | Root User | IAM User |
|--------|-----------|----------|
| **Power** | UNLIMITED | Limited by policies |
| **Credentials** | Email + Password | Username + Password |
| **Daily use** | ❌ Never | ✅ Yes |
| **Can be restricted** | ❌ No | ✅ Yes |

**Root-Only Tasks:**
- Change account settings (email, name)
- Close AWS account
- Change support plan
- Restore IAM permissions

**First thing after creating account:**
1. Enable MFA on root
2. Create IAM admin user
3. Delete root access keys
4. Stop using root daily

---

## Authentication Methods

| Method | For | Format |
|--------|-----|--------|
| **Console Password** | Web console login | Password string |
| **Access Keys** | CLI, SDK, API | Key ID + Secret Key |

**Access Key Rules:**
- ⚠️ NEVER share or commit to git
- ✅ Rotate regularly
- ✅ Prefer IAM roles for apps

---

## MFA (Multi-Factor Authentication)

> Something you KNOW (password) + Something you HAVE (device)

| Type | Description |
|------|-------------|
| Virtual MFA | Google Authenticator, Authy |
| Hardware MFA | YubiKey |
| SMS MFA | Text message (least secure) |

**When to use:**
- ✅ ALWAYS on Root user
- ✅ All users with console access
- ✅ Users with admin privileges

---

## Permission Evaluation

```
1. Is there EXPLICIT DENY? → YES → DENIED!
                           → NO  ↓
2. Is there EXPLICIT ALLOW? → YES → ALLOWED!
                            → NO  → DENIED! (implicit)
```

**Key Rule: Explicit DENY always wins!**

---

## Best Practices

| ✅ DO | ❌ DON'T |
|-------|----------|
| Enable MFA on root | Use root daily |
| Create individual users | Share credentials |
| Use groups for permissions | Use inline policies |
| Apply least privilege | Give full admin |
| Use roles for applications | Embed keys in code |
| Rotate credentials | Ignore warnings |

---

## Exam Scenarios

| Scenario | Solution |
|----------|----------|
| EC2 needs S3 access | Attach IAM Role (not access keys) |
| Cross-account access | Role with trust policy |
| New company setup | Create IAM admin, use groups |
| Secure root account | MFA, delete access keys |
| User has group Allow + direct Deny | DENIED (deny wins) |

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **IAM** | Who can do what |
| **User** | Individual identity |
| **Group** | Collection of users |
| **Role** | Temporary identity for services |
| **Policy** | JSON permissions |
| **Root** | Unlimited, never use daily |
| **MFA** | Second factor security |
| **Access Keys** | For CLI/API only |
