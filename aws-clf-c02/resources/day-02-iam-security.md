# Day 2: IAM & Security Foundations

**Domain 2: Security & Compliance (30% of exam)**  
**Study Time:** 6-8 hours  

### 🎯 Learning Goals

By the end of Day 2, you will be able to:

1. **Explain** the 4 IAM components (Users, Groups, Roles, Policies) and when to use each
2. **Choose** between IAM User and IAM Role for different scenarios
3. **Apply** the Principle of Least Privilege to permission design
4. **List** the tasks only Root User can perform (CCCS mnemonic)
5. **Distinguish** AWS vs Customer responsibilities in the Shared Responsibility Model
6. **Determine** who is responsible for patching EC2, RDS, and Lambda
7. **Differentiate** between IAM (AWS access) and Cognito (app user access)

---

## 📋 Services You'll Meet Today

> These services are referenced. Full explanations come in the listed days!

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **Security Groups** | Instance-level firewall | Day 3 |
| **NACLs** | Subnet-level firewall | Day 3 |
| **VPC** | Virtual network | Day 3 |
| **EC2** | Virtual servers | Day 4 |
| **RDS** | Managed databases | Day 5 |
| **Lambda** | Serverless functions | Day 5 |

📖 **Quick Reference:** [AWS Glossary](../notes/glossary.md)

---

## 📖 How to Use This Resource

1. **Understand** concepts using the explanations and real-world scenarios
2. **Focus on WHY** - Security questions test your ability to apply concepts
3. **Pay attention to** the Shared Responsibility tables - heavily tested!
4. **Test yourself** with the self-check questions at the end

> [!IMPORTANT]
> **Day 2 is CRITICAL!** Security is 30% of the exam. Master IAM and Shared Responsibility Model thoroughly.

---

## 🔐 Part 1: AWS Identity and Access Management (IAM)

### What Is IAM?

> **IAM** is the AWS service that controls **who** (authentication) can do **what** (authorization) in your AWS account.

IAM is:
- **Global** - not region-specific
- **Free** - no additional charges
- **Foundational** - must understand before using any AWS service

### 💡 Why IAM Matters

Every AWS interaction—console, CLI, SDK, or API—goes through IAM. Even when you create an EC2 instance, IAM verifies:
1. Are you who you claim to be? (Authentication)
2. Do you have permission to do this? (Authorization)

### 📌 Quick Summary: What Is IAM

- **IAM** = Identity and Access Management (who can do what)
- Global service, free to use
- Every AWS interaction goes through IAM

---

## 🔥 Part 2: IAM Components

### The 4 Core Components

| Component | What It Is | Key Point |
|-----------|-----------|-----------|
| **Users** | Individual identity | One person = one user |
| **Groups** | Collection of users | Apply policies to many users at once |
| **Roles** | Temporary credentials | For services and cross-account access |
| **Policies** | JSON permission documents | Define what's allowed/denied |

### 💡 How They Work Together

```
         ┌─────────────────────────────────────────────────────────┐
         │                     AWS ACCOUNT                         │
         │                                                          │
         │   ┌─────────────┐     ┌─────────────┐                   │
         │   │   POLICY    │     │   POLICY    │                   │
         │   │ (JSON doc)  │     │ (EC2 Admin) │                   │
         │   └──────┬──────┘     └──────┬──────┘                   │
         │          │                   │                          │
         │          ▼                   ▼                          │
         │   ┌─────────────┐     ┌─────────────┐                   │
         │   │   GROUP     │     │    ROLE     │                   │
         │   │ (Developers)│     │ (EC2 Role)  │                   │
         │   └──────┬──────┘     └──────┬──────┘                   │
         │          │                   │                          │
         │          ▼                   ▼                          │
         │   ┌───┬───┬───┐      ┌─────────────┐                   │
         │   │ 👤│ 👤│ 👤│      │   EC2       │                   │
         │   │User│User│User    │  Instance   │                   │
         │   └───┴───┴───┘      └─────────────┘                   │
         │                                                          │
         └──────────────────────────────────────────────────────────┘
```

---

### IAM Users

**What:** An identity representing a person or service needing AWS access.

**Key Characteristics:**
- Has username + credentials (password or access keys)
- Can belong to multiple groups
- Can have policies attached directly (not recommended)
- One person = one IAM user (don't share!)

**Best Practice:** Create individual users; never share credentials.

---

### IAM Groups

**What:** A collection of IAM users.

**Key Characteristics:**
- **Groups contain users only** - no nested groups
- Apply policies to groups, not individual users
- Users inherit group permissions automatically

**Why Groups Matter:**
```
WITHOUT Groups:              WITH Groups:
                            
Policy → User1              Policy → [Developers Group]
Policy → User2                         ├── User1
Policy → User3                         ├── User2
                                       └── User3

(3 attachments)             (1 attachment, same result)
```

**Exam Tip:** "How to give the same permissions to multiple users?" → Use Groups.

---

### IAM Roles

**What:** Temporary credentials for **services** or **cross-account access**.

**Key Differences from Users:**

| Aspect | IAM User | IAM Role |
|--------|----------|----------|
| For whom? | Humans | Services or temporary access |
| Credentials | Permanent (password/keys) | Temporary (auto-rotated) |
| Duration | Long-term | Minutes to hours |

**Common Role Use Cases:**
1. **EC2 Instance Role** - Let EC2 call other AWS services
2. **Lambda Execution Role** - Let Lambda call DynamoDB
3. **Cross-Account Role** - Let users from Account A access Account B

**Exam Pattern:**
> "An EC2 instance needs to access S3..."
> → Answer: Attach an **IAM Role** to the EC2 instance

---

### IAM Policies

**What:** JSON documents that define permissions.

**Policy Structure:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

| Element | Meaning |
|---------|---------|
| **Effect** | Allow or Deny |
| **Action** | What actions (e.g., s3:GetObject) |
| **Resource** | Which resources (ARN) |
| **Condition** | Optional: when this applies |

**Policy Types:**

| Type | What It Is | Example |
|------|-----------|---------|
| **AWS Managed** | Pre-built by AWS | AdministratorAccess |
| **Customer Managed** | Created by you | MyCustomS3Policy |
| **Inline** | Embedded in user/group/role | Not reusable (avoid) |

### 💡 Principle of Least Privilege

> Grant **minimum permissions** needed to perform a task.

**Why:**
- Reduces blast radius if credentials are compromised
- Easier to audit and troubleshoot
- AWS best practice

**Exam Pattern:**
> "Following best practices, how should permissions be assigned?"
> → Answer: **Least privilege** - only what's needed

### 📌 Quick Summary: IAM Components

- **4 Components:** Users (people), Groups (collections), Roles (temp for services), Policies (permissions)
- **Users → Groups:** Efficient permission management
- **Roles:** For services needing AWS access (EC2, Lambda)
- **Least Privilege:** Grant minimum permissions needed

---

## 🔑 Part 3: MFA and Access Keys

### Multi-Factor Authentication (MFA)

**What:** Second layer of protection beyond password.

**MFA = Something you know + Something you have**
- Something you know: Password
- Something you have: MFA device

**MFA Device Types:**

| Type | Description | Example |
|------|-------------|---------|
| **Virtual MFA** | App on phone | Google Authenticator, Authy |
| **U2F Security Key** | Physical USB key | YubiKey |
| **Hardware Key Fob** | Physical token | Gemalto |

**Best Practice:** Enable MFA for all users, **especially root user**.

---

### Access Keys

**What:** Credentials for CLI and SDK (programmatic access).

**Components:**
- **Access Key ID** - like a username (public)
- **Secret Access Key** - like a password (NEVER share!)

**Key Rules:**
- Don't share access keys
- Don't embed in code
- Rotate regularly
- Delete if not needed

**Exam Pattern:**
> "A developer needs to access AWS from their application..."
> → Use **Access Keys** (for CLI/SDK access)

### 📌 Quick Summary: MFA & Access Keys

- **MFA Types:** Virtual (app), U2F Key (USB), Hardware Key Fob
- **Access Keys:** For CLI/SDK programmatic access
- **Never share** access keys or embed in code
- Enable MFA for ALL users, especially root

---

## 👑 Part 4: Root User

### What Is Root User?

The **root user** is the account created when you first set up your AWS account. It has **complete, unrestricted access** to everything.

### Root User Best Practices

> [!CAUTION]
> **NEVER use root user for daily tasks!**

| Do ✅ | Don't ❌ |
|-------|---------|
| Enable MFA immediately | Share root credentials |
| Create IAM admin user | Use for daily tasks |
| Lock away root credentials | Create access keys for root |
| Use only when required | Give root access to employees |

### 🔥 Root User ONLY Tasks

Some tasks can **ONLY** be performed by root. Memorize these:

| Root-Only Action | Why? |
|------------------|------|
| **Change account settings** (name, email, password) | Account ownership |
| **Close AWS account** | Irreversible action |
| **Restore IAM user permissions** | When locked out |
| **Change AWS Support plan** | Billing-related |
| **Register as seller in Marketplace** | Legal agreement |
| **Create CloudFront key pairs** | Legacy feature |
| **Enable MFA on S3 bucket delete** | High-risk action |
| **View certain tax invoices** | Legal requirement |

**Mnemonic: "CCCS"**
- **C**hange account settings
- **C**lose account
- **C**loudFront key pairs
- **S**upport plan changes

### 📌 Quick Summary: Root User

- Root has **complete, unrestricted access**
- **Never** use for daily tasks
- **CCCS:** Close, Change settings, CloudFront keys, Support plan
- Enable MFA immediately, lock away credentials

---

## 🤝 Part 5: Shared Responsibility Model

### The Core Concept

> **AWS:** Security **OF** the Cloud  
> **Customer:** Security **IN** the Cloud

Think of it like renting an apartment:
- **Landlord (AWS):** Building structure, locks, fire safety
- **Tenant (You):** Furniture, belongings, what you put inside

### 💡 Why This Matters

This is one of the **most tested topics** on CLF-C02. You must know:
1. What AWS handles
2. What you handle
3. How it shifts by service type

---

### 🔥 AWS Responsibilities (Security OF the Cloud)

AWS protects the **underlying infrastructure**:

| Category | What AWS Manages |
|----------|------------------|
| **Physical** | Data centers, guards, cameras, fences |
| **Hardware** | Servers, storage devices, networking |
| **Software** | Hypervisor, host OS |
| **Network** | Global infrastructure, edge locations |
| **Managed Services** | Patching RDS, Lambda runtime, etc. |

**Memory Aid:** AWS handles everything **you can't touch**.

---

### 🔥 Customer Responsibilities (Security IN the Cloud)

You protect **what you put in the cloud**:

| Category | What YOU Manage |
|----------|-----------------|
| **Data** | Encryption, classification, backups |
| **Applications** | Your code, configurations |
| **Access** | IAM users, roles, policies |
| **OS (EC2)** | Patching, security updates |
| **Network Config** | Security groups, NACLs |
| **Firewall** | Application-level security |

**Memory Aid:** You handle everything **inside your resources**.

---

### 🔥 How Responsibility Shifts by Service Type

This is **critical for the exam**!

```
        MORE Customer Control ◄────────────────► MORE AWS Control
        
             IaaS              PaaS              SaaS
              │                  │                  │
              ▼                  ▼                  ▼
           ┌─────┐           ┌─────┐           ┌─────┐
           │ EC2 │           │ RDS │           │ S3  │
           │     │           │     │           │(API)│
           └─────┘           └─────┘           └─────┘
              │                  │                  │
    Customer: │         Customer: │        Customer: │
    - OS      │         - Data    │        - Data    │
    - Apps    │         - Access  │        - Access  │
    - Data    │         - Config  │                  │
    - Network │                   │                  │
    - Patching│                   │                  │
```

### Service-Specific Breakdown

| Service Type | Customer Manages | AWS Manages |
|--------------|------------------|-------------|
| **EC2 (IaaS)** | OS, patching, apps, data, security groups | Hardware, hypervisor, network |
| **RDS (PaaS)** | Data, access, database config | OS, patching, backups, HA |
| **Lambda (FaaS)** | Code, data, IAM | Everything else |
| **S3 (Abstracted)** | Data, access, encryption settings | Infrastructure, durability |

### 💡 Exam Pattern Examples

| Question Pattern | Answer |
|------------------|--------|
| "Who is responsible for patching EC2 OS?" | **Customer** |
| "Who is responsible for patching RDS database engine?" | **AWS** |
| "Who is responsible for data encryption?" | **Customer** (but AWS provides tools) |
| "Who is responsible for physical security?" | **AWS** |
| "Who is responsible for IAM user management?" | **Customer** |

### 📌 Quick Summary: Shared Responsibility Model

- **AWS:** Security **OF** the cloud (infrastructure, physical, hardware)
- **Customer:** Security **IN** the cloud (data, apps, access, config)
- **EC2:** Customer patches OS; **RDS:** AWS patches engine
- More managed = less customer responsibility

---

## 🛡️ Part 6: Security Tools

### IAM Security Tools

| Tool | What It Does | Use Case |
|------|-------------|----------|
| **IAM Credentials Report** | Lists all users and credential status | Account-level audit |
| **IAM Access Advisor** | Shows service permissions and last used | Identify unused permissions |

**Exam Tip:**
- **Credentials Report** = Account-wide user audit
- **Access Advisor** = User-level permission review

### 📌 Quick Summary: Security Tools

- **Credentials Report:** Account-wide audit of all users
- **Access Advisor:** Per-user permission usage analysis
- Use Access Advisor to find and remove unused permissions

---

## 🏢 Part 7: AWS Organizations & IAM Identity Center

### AWS Organizations

**What:** Centrally manage multiple AWS accounts.

**Key Features:**
- **Consolidated Billing** - One bill for all accounts
- **Service Control Policies (SCPs)** - Restrict what accounts can do
- **Organizational Units (OUs)** - Group accounts

```
               Root Account
                    │
        ┌───────────┴───────────┐
        │                       │
    ┌───────┐               ┌───────┐
    │  OU   │               │  OU   │
    │ (Dev) │               │(Prod) │
    └───┬───┘               └───┬───┘
        │                       │
    ┌───┴───┐               ┌───┴───┐
    │Acct 1 │               │Acct 3 │
    │Acct 2 │               │Acct 4 │
    └───────┘               └───────┘
```

### IAM Identity Center (formerly AWS SSO)

**What:** Single sign-on for multiple AWS accounts and applications.

**Key Points:**
- One login for all accounts
- Integrates with Active Directory
- Centralized access management

### 📌 Quick Summary: Organizations & Identity Center

- **AWS Organizations:** Manage multiple accounts, consolidated billing, SCPs
- **IAM Identity Center:** Single sign-on for all accounts
- SCPs restrict what member accounts can do

---

## 🔐 Part 8: Amazon Cognito

### What Is Cognito?

**Amazon Cognito:** User authentication for web and mobile applications.

> **Key Difference:** IAM is for AWS resources access. Cognito is for **application users** (your customers).

### Two Components

| Component | Purpose | Use Case |
|-----------|---------|----------|
| **User Pools** | User directory + authentication | Sign-up, sign-in, MFA for your app |
| **Identity Pools** | Temporary AWS credentials | Give app users access to S3, DynamoDB |

### User Pools

**What:** A user directory for your application.

**Features:**
- Sign-up and sign-in
- Social login (Google, Facebook, Apple)
- MFA support
- Password policies
- Email/SMS verification

### Identity Pools (Federated Identities)

**What:** Exchange tokens for temporary AWS credentials.

**Use Case:** Allow mobile app users to upload to S3 directly.

```
User signs in → Gets Token → Exchange for AWS Credentials → Access S3
```

### Cognito vs IAM

| Feature | IAM | Cognito |
|---------|-----|---------|
| **For** | AWS resources | App users |
| **Users** | Employees, services | Customers (millions) |
| **Scale** | Hundreds | Millions |
| **Social Login** | No | Yes |

**Exam Pattern:**
> "Allow mobile app users to sign in with Google and access S3..."
> → Answer: **Amazon Cognito**

### 📌 Quick Summary: Cognito

- **Cognito:** Authentication for web/mobile apps (not IAM!)
- **User Pools:** User sign-up, sign-in, MFA
- **Identity Pools:** Temp AWS credentials for app users
- Use for: Social login, scaling to millions of users

---

## 🧪 Self-Check Questions

### IAM Basics

1. **What are the 4 core IAM components?**
   <details><summary>Answer</summary>
   Users, Groups, Roles, Policies
   </details>

2. **When should you use an IAM Role instead of IAM User?**
   <details><summary>Answer</summary>
   When a service (EC2, Lambda) needs to access other AWS services, or for cross-account access. Roles provide temporary credentials.
   </details>

3. **What is the Principle of Least Privilege?**
   <details><summary>Answer</summary>
   Grant minimum permissions needed to perform a task—no more, no less.
   </details>

### Root User

4. **Name 3 things ONLY root user can do.**
   <details><summary>Answer</summary>
   Close account, change account settings, change AWS Support plan, create CloudFront key pairs
   </details>

5. **Should you use root user daily?**
   <details><summary>Answer</summary>
   NO! Create IAM admin user for daily tasks. Lock away root credentials.
   </details>

### Shared Responsibility

6. **Who is responsible for patching EC2 instances?**
   <details><summary>Answer</summary>
   Customer - you manage the OS on EC2
   </details>

7. **Who is responsible for patching RDS?**
   <details><summary>Answer</summary>
   AWS - RDS is managed service, AWS handles engine patching
   </details>

8. **Who is responsible for physical data center security?**
   <details><summary>Answer</summary>
   AWS - Security OF the cloud
   </details>

9. **What's the difference between "Security OF" and "Security IN" the cloud?**
   <details><summary>Answer</summary>
   OF = AWS responsibility (infrastructure). IN = Customer responsibility (data, apps, access).
   </details>

### MFA & Access

10. **What are the 3 types of MFA devices?**
    <details><summary>Answer</summary>
    Virtual MFA (app), U2F Security Key (USB), Hardware Key Fob
    </details>

### Cognito

11. **When do you use Cognito instead of IAM?**
    <details><summary>Answer</summary>
    For application users (customers) who need to sign in to your web/mobile app. IAM is for AWS resource access.
    </details>

12. **What are the two components of Cognito?**
    <details><summary>Answer</summary>
    User Pools (authentication/sign-in) and Identity Pools (temporary AWS credentials)
    </details>

---

## 📝 Flashcard Quick Reference

| Front | Back |
|-------|------|
| 4 IAM Components | Users, Groups, Roles, Policies |
| IAM Role vs User | Role = temp credentials for services; User = permanent for humans |
| Least Privilege | Grant minimum permissions needed |
| MFA Types | Virtual MFA, U2F Security Key, Hardware Key Fob |
| Root-Only Tasks (CCCS) | Change account, Close account, CloudFront keys, Support plan |
| AWS Responsibility | Security OF the cloud (infrastructure) |
| Customer Responsibility | Security IN the cloud (data, apps, access) |
| EC2 Patching | Customer responsibility |
| RDS Patching | AWS responsibility |
| Credentials Report | Account-level user audit |
| Access Advisor | User-level permission review (shows last accessed) |
| **Access Analyzer** | Finds resources shared externally (public S3, cross-account) |
| **Policy Evaluation** | Explicit Deny always wins over Allow |
| **Access Keys vs Password** | Access Keys = CLI/API; Password = Console login |
| **SCPs** | Restrict what member accounts can do (guardrails, not grants) |
| **Permission Sets** | Reusable permission bundles in IAM Identity Center |
| **Cognito User Pools** | User directory, sign-up/sign-in for apps |
| **Cognito Identity Pools** | Temporary AWS credentials for app users |
| **Cognito vs IAM** | Cognito = app users (millions), IAM = AWS access |

---

## 🔧 Hands-On Setup: Day 2 Practice

### Practice 1: Create an IAM User

**Objective:** Understand IAM user creation and policy attachment

**Steps:**
1. Go to [IAM Console](https://console.aws.amazon.com/iam)
2. Click **Users** → **Create user**
3. Enter username: `test-user-day2`
4. Select **Provide user access to AWS Management Console**
5. Choose **I want to create an IAM user** (for practice)
6. Click **Next**, then **Attach policies directly**
7. Search and select `AmazonS3ReadOnlyAccess`
8. Complete user creation
9. **Observe:** User has READ-ONLY access to S3

**Cleanup:** Delete the user after practice (Users → Select → Delete)

### Practice 2: Explore IAM Policies

**Objective:** Understand IAM policy structure

**Steps:**
1. In IAM Console, click **Policies**
2. Search for `AmazonEC2FullAccess`
3. Click on the policy → **JSON** tab
4. Observe the structure:
   - **Effect:** Allow
   - **Action:** ec2:*
   - **Resource:** *
5. Compare with `AmazonS3ReadOnlyAccess` - note the difference

**Expected Result:** You understand how policies grant permissions.

### Practice 3: View Credentials Report

**Objective:** Understand IAM security auditing

**Steps:**
1. In IAM Console, click **Credential report** (left sidebar)
2. Click **Download credential report**
3. Open the CSV and review:
   - User list
   - Password and access key status
   - MFA enabled status

> [!CAUTION]
> **Free Tier Alert:** These steps stay within Free Tier. Delete test user after practice.

---

## 💡 Tips & Tricks

### Exam Tips

| Tip | Details |
|-----|---------|
| **"EC2 needs to access S3"** | Answer is always IAM Role |
| **"Same permissions for many users"** | Answer is IAM Groups |
| **"Who patches EC2 OS?"** | Customer (you manage OS on EC2) |
| **"Who patches RDS?"** | AWS (managed service) |
| **Root-only tasks** | CCCS: Close, Change, CloudFront, Support |

### Time-Saving Tricks

| Trick | Why |
|-------|-----|
| Learn CCCS mnemonic | Quick recall for root-only tasks |
| Remember OF vs IN | OF = AWS (infrastructure), IN = You (data) |
| Service = Role | Whenever a service needs access, think Role |

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| Using root for daily tasks | Create IAM admin user instead |
| Sharing access keys | Never share; create individual users |
| Giving excess permissions | Follow least privilege principle |
| Forgetting MFA on root | Enable MFA IMMEDIATELY on root |
| Confusing User vs Role | User = human, Role = service/temp |

---

## ✅ Day 2 Completion Checklist

Before moving to Day 3, make sure you can:

- [ ] **Explain** the 4 IAM components and when to use each
- [ ] **Choose** between User and Role for a given scenario
- [ ] **Explain** Least Privilege and why it matters
- [ ] **List** 4 things only root can do (CCCS)
- [ ] **Explain** why root should NOT be used daily
- [ ] **Distinguish** AWS vs Customer responsibilities
- [ ] **Apply** Shared Responsibility to EC2, RDS, Lambda scenarios
- [ ] **Identify** the 3 MFA types
- [ ] **Differentiate** Cognito User Pools vs Identity Pools
- [ ] **Know when** to use Cognito vs IAM

---

## 📝 Quiz Guidance

**After studying this resource, take these quizzes:**

| Quiz | Source | Focus |
|------|--------|-------|
| **Quiz 2** | Stephane Maarek Course | IAM Users, Groups, Roles, Policies |
| **Quiz 14** | Stephane Maarek Course | Security & Compliance |

**Target Score:** 80%+ before proceeding to Day 3

> [!TIP]
> Shared Responsibility questions often use **"who is responsible for..."** phrasing. Look for service type (EC2 vs RDS) to determine the answer.

---

**Previous:** [← Day 1 - Cloud Concepts](day-01-cloud-concepts.md)  
**Next:** [Day 3 - Security Services & VPC →](day-03-security-vpc.md)
