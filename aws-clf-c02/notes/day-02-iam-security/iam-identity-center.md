# AWS IAM Identity Center (formerly AWS SSO)

> IAM Identity Center = **One login to access ALL your AWS accounts**

## The Problem It Solves

**Old Way (Traditional IAM):**
- 20 accounts = create users in each account
- 50 employees × 20 accounts = 1,000 IAM users! 😱
- Employee leaves = delete 20 users
- Password resets everywhere

**With IAM Identity Center:**
- One login portal
- One user directory
- Assign to multiple accounts easily

---

## 3 Main Capabilities

| # | Capability | Description |
|---|------------|-------------|
| 1️⃣ | **Single Sign-On (SSO)** | Login once, access all accounts |
| 2️⃣ | **Identity Integration** | Connect to Active Directory/Okta |
| 3️⃣ | **Permission Sets** | Reusable permission bundles |

---

## Core Concepts

### SSO Portal

```
╔══════════════════════════════════════════════════════╗
║           AWS Access Portal                          ║
║           portal.aws.amazon.com/yourcompany          ║
╠══════════════════════════════════════════════════════╣
║   Welcome, John! You have access to:                ║
║                                                      ║
║   📁 Production Account (111111111111)              ║
║      └── 🔑 ViewOnlyAccess                          ║
║                                                      ║
║   📁 Development Account (222222222222)             ║
║      ├── 🔑 PowerUserAccess                         ║
║      └── 🔑 AdminAccess                             ║
╚══════════════════════════════════════════════════════╝
```

Click account → Get **temporary credentials** → Work!

---

### Identity Sources

| Source | Description | Best For |
|--------|-------------|----------|
| **Built-in Directory** | Create users in Identity Center | Small teams |
| **Active Directory** | Connect to corporate AD | Enterprises |
| **External IdP** | Okta, Azure AD, Google Workspace | Cloud-first companies |

---

### Permission Sets

> Permission Set = **Reusable package of permissions**

Think of it like a job role badge:

```
Permission Set: "Developer"
┌────────────────────────────────────────┐
│  Permissions included:                 │
│  ✅ EC2: Full Access                   │
│  ✅ S3: Full Access                    │
│  ✅ Lambda: Full Access                │
│  ❌ IAM: No Access                     │
│  ❌ Billing: No Access                 │
└────────────────────────────────────────┘

Assigned to:
├── John (in Dev Account)
├── Jane (in Dev Account)
├── John (in Staging Account)
└── Bob (in Staging Account)
```

**Create once, use everywhere!**

---

## Complete Flow

```
SETUP (Admin does once):
Step 1: Enable IAM Identity Center in Management Account
Step 2: Connect Identity Source (Okta/AD)
Step 3: Create Permission Sets
Step 4: Assign users → accounts → permission sets

DAILY USE (Employees):
Step 1: Go to portal.aws.amazon.com/yourcompany
Step 2: Login with company credentials
Step 3: See account list
Step 4: Click account + permission set
Step 5: Get temporary credentials (1-12 hours)
Step 6: Work!
```

---

## For Developers Using CLI/Terraform

**No need to generate access keys every time!**

### AWS CLI v2 SSO Integration

```bash
# One-time setup in ~/.aws/config
[profile dev-account]
sso_start_url = https://yourcompany.awsapps.com/start
sso_region = ap-southeast-1
sso_account_id = 123456789012
sso_role_name = DeveloperAccess

# Daily: run once per session
aws sso login --profile dev-account

# Browser opens → Login → Done!
terraform plan   # ✅ Works!
aws s3 ls        # ✅ Works!
```

---

## IAM Identity Center vs Traditional IAM

| Aspect | IAM Identity Center | Traditional IAM |
|--------|---------------------|-----------------|
| **Scope** | Multiple accounts | Single account |
| **Login** | One portal, SSO | Per account |
| **Credentials** | Temporary (1-12 hours) | Long-term access keys |
| **User Source** | Corporate IdP | Created in each account |
| **Offboarding** | Disable in IdP → instant revoke | Delete from each account |
| **Management** | Centralized Permission Sets | IAM policies per account |

---

## AWS Account vs IAM User

| Aspect | AWS Account | IAM User |
|--------|-------------|----------|
| **What is it?** | Container for resources | Identity to access account |
| **Unique ID** | 12-digit Account ID | Username |
| **Owns resources?** | ✅ Yes | ❌ No, just accesses |
| **Pays bills?** | ✅ Yes | ❌ No |
| **How many per company?** | Often 5-100+ | 0-50 per account |

```
Account = WHERE resources live (the container)
User    = WHO can access resources (the identity)
```

---

## Exam Questions

**Q1**: Main benefit of IAM Identity Center over IAM users in each account?
> **Centralized access management** - create users once, assign to multiple accounts. SSO and temporary credentials.

**Q2**: Can IAM Identity Center work with on-prem Active Directory?
> **YES!** Via AD Connector or AWS Managed Microsoft AD.

**Q3**: What are Permission Sets?
> **Reusable collections of permissions** assigned to users/groups for specific accounts.

**Q4**: Do users get long-term access keys?
> **NO!** Temporary credentials (1-12 hours). More secure.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **IAM Identity Center** | One login, all accounts |
| **Identity Source** | Where users come from |
| **Permission Sets** | Reusable permission packages |
| **SSO Portal** | Web page users login to |
| **Temporary Credentials** | No long-term keys = secure |
