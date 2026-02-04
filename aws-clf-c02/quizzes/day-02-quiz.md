# Day 2 Quiz: IAM & Security Foundations

**Domain 2: Security & Compliance (30% of exam)**  
**Time:** 20-25 minutes  
**Passing Score:** 80% (16/20 correct)

---

## Instructions

1. Answer each question without looking at the resource
2. For Shared Responsibility questions, identify the **service type first**
3. Mark questions you're unsure about for review
4. Check answers at the end

---

## Section 1: IAM Basics (6 Questions)

### Q1. Which IAM component should be used when an EC2 instance needs to access an S3 bucket?

A) IAM User  
B) IAM Group  
C) IAM Role  
D) IAM Policy

<details><summary>Answer</summary>

**C) IAM Role**

**Why:** Roles provide temporary credentials for services (like EC2) to access other AWS services. Never embed access keys in instances—use roles instead.

**Key Pattern:** "EC2 needs to access..." → IAM Role
</details>

---

### Q2. A company has 50 developers who all need the same permissions. What is the MOST efficient way to manage their access?

A) Attach policies to each user individually  
B) Create an IAM Role for developers  
C) Create an IAM Group and add all developers  
D) Create one shared IAM User for all developers

<details><summary>Answer</summary>

**C) Create an IAM Group and add all developers**

**Why:** Groups allow you to attach policies once and have all members inherit those permissions. This is efficient and follows AWS best practices.

**Wrong Options:**
- A: Inefficient (50 attachments vs 1)
- B: Roles are for services/temp access, not daily user access
- D: Never share credentials!
</details>

---

### Q3. What does the Principle of Least Privilege mean?

A) Give administrators full access to everything  
B) Grant minimum permissions needed to perform a task  
C) Deny all access by default and require approval  
D) Only allow access from specific IP addresses

<details><summary>Answer</summary>

**B) Grant minimum permissions needed to perform a task**

**Why:** Least privilege reduces security risk. If credentials are compromised, damage is limited to what those credentials can access.

**Exam Tip:** Any question about "best practices" for permissions → Least Privilege
</details>

---

### Q4. Which IAM policy type is created and managed by AWS?

A) Customer Managed Policy  
B) AWS Managed Policy  
C) Inline Policy  
D) Resource-based Policy

<details><summary>Answer</summary>

**B) AWS Managed Policy**

**Why:** AWS creates and maintains these policies (like AdministratorAccess, ReadOnlyAccess). They're updated automatically when new services launch.

**Key Difference:**
- AWS Managed = AWS creates/updates
- Customer Managed = You create/update
</details>

---

### Q5. What are the two components of an Access Key?

A) Username and Password  
B) Access Key ID and Secret Access Key  
C) User ID and Role ARN  
D) Account ID and Region

<details><summary>Answer</summary>

**B) Access Key ID and Secret Access Key**

**Why:** Access Keys enable programmatic (CLI/SDK) access. The Access Key ID is like a username (can be shared), but the Secret Access Key must be kept private.

**Security Rule:** Never commit Secret Access Keys to code or version control!
</details>

---

### Q6. Which statement about IAM Groups is TRUE?

A) Groups can contain other groups (nested)  
B) Groups can contain only users  
C) A user can belong to only one group  
D) Groups can be assigned IAM Roles

<details><summary>Answer</summary>

**B) Groups can contain only users**

**Why:** IAM Groups cannot be nested (no groups within groups). They only contain users. However, a user can belong to multiple groups.

**Exam Trap:** "Nested groups" is a common wrong answer.
</details>

---

## Section 2: Root User (4 Questions)

### Q7. Which of the following can ONLY be performed by the root user?

A) Creating IAM users  
B) Launching EC2 instances  
C) Closing the AWS account  
D) Creating S3 buckets

<details><summary>Answer</summary>

**C) Closing the AWS account**

**Why:** Only root can perform certain critical actions: close account, change account settings, change support plan, create CloudFront key pairs.

**Mnemonic (CCCS):** Close, Change settings, CloudFront keys, Support plan
</details>

---

### Q8. What is the BEST practice for securing the root user?

A) Share credentials with administrators  
B) Create access keys for automation  
C) Enable MFA and use only when absolutely necessary  
D) Use root for all daily administrative tasks

<details><summary>Answer</summary>

**C) Enable MFA and use only when absolutely necessary**

**Why:** Root has unrestricted access. Best practices:
- Enable MFA immediately
- Create IAM admin user for daily tasks
- Lock away root credentials
- Never create access keys for root
</details>

---

### Q9. A new employee needs to perform administrative tasks in AWS. What should they use?

A) Root user credentials  
B) An IAM user with AdministratorAccess policy  
C) Shared team credentials  
D) AWS account email and password

<details><summary>Answer</summary>

**B) An IAM user with AdministratorAccess policy**

**Why:** Create individual IAM users for daily work. The AdministratorAccess policy provides full access without using root.

**Never:** Share root credentials or use root for daily tasks.
</details>

---

### Q10. Which action can an IAM administrator perform WITHOUT root access?

A) Close the AWS account  
B) Change the account email address  
C) Create new IAM users and groups  
D) Change the AWS Support plan

<details><summary>Answer</summary>

**C) Create new IAM users and groups**

**Why:** IAM user management is NOT a root-only task. An IAM admin can create/manage users, groups, roles, and policies.

**Root-Only List:** Account closure, account settings, support plan, CloudFront keys
</details>

---

## Section 3: Shared Responsibility Model (7 Questions)

### Q11. According to the Shared Responsibility Model, who is responsible for security OF the cloud?

A) Customer  
B) AWS  
C) Both AWS and Customer  
D) Third-party security vendors

<details><summary>Answer</summary>

**B) AWS**

**Why:** AWS handles security OF the cloud = infrastructure (physical, hardware, network, hypervisor). Customer handles security IN the cloud = data, applications, access.

**Memory Aid:**
- OF = AWS (infrastructure)
- IN = Customer (your stuff)
</details>

---

### Q12. A company runs an application on Amazon EC2. Who is responsible for patching the operating system?

A) AWS  
B) Customer  
C) Both AWS and Customer  
D) No one, it's automatic

<details><summary>Answer</summary>

**B) Customer**

**Why:** EC2 is IaaS—customer manages the guest OS, including patching and security updates. AWS only manages the underlying hardware and hypervisor.

**IaaS Rule:** If you control the OS, you patch the OS.
</details>

---

### Q13. A company uses Amazon RDS for their database. Who is responsible for patching the database engine?

A) Customer  
B) AWS  
C) Both during maintenance windows  
D) Database administrator

<details><summary>Answer</summary>

**B) AWS**

**Why:** RDS is a managed service (PaaS). AWS handles the database engine patching. Customer only manages data, access, and configurations.

**PaaS Rule:** AWS manages more; you focus on data and application.
</details>

---

### Q14. Which of the following is ALWAYS a customer responsibility?

A) Physical security of data centers  
B) Hypervisor security  
C) IAM user management  
D) Hardware maintenance

<details><summary>Answer</summary>

**C) IAM user management**

**Why:** Regardless of service type, customers ALWAYS manage:
- IAM (users, roles, policies)
- Data classification and encryption decisions
- Application-level access controls

**Customer Always:** IAM, Data, Applications
</details>

---

### Q15. Who is responsible for the security of data stored in Amazon S3?

A) AWS only  
B) Customer only  
C) AWS manages infrastructure; Customer manages data access and encryption  
D) Third-party encryption provider

<details><summary>Answer</summary>

**C) AWS manages infrastructure; Customer manages data access and encryption**

**Why:** S3 is abstracted storage. AWS handles durability (11 9's) and availability. Customer decides:
- Who can access (bucket policies, IAM)
- Encryption settings (SSE, KMS, client-side)
</details>

---

### Q16. How does customer responsibility CHANGE from EC2 to Lambda?

A) Customer has MORE responsibility with Lambda  
B) Customer has LESS responsibility with Lambda  
C) Responsibility is the same for both  
D) AWS has no responsibility for Lambda

<details><summary>Answer</summary>

**B) Customer has LESS responsibility with Lambda**

**Why:** Lambda is serverless (FaaS). AWS manages:
- Servers, runtime, scaling, patching

Customer only manages:
- Code, data, IAM permissions

**Progression:** EC2 (most customer) → RDS → Lambda (least customer)
</details>

---

### Q17. A security auditor asks who is responsible for encrypting data at rest. What is the correct answer?

A) AWS  
B) Customer  
C) AWS provides tools; Customer decides to use them  
D) Data is always encrypted automatically

<details><summary>Answer</summary>

**C) AWS provides tools; Customer decides to use them**

**Why:** AWS offers encryption options (KMS, SSE, CloudHSM), but the customer must:
- Enable encryption
- Manage keys (for customer-managed keys)
- Decide what to encrypt

**Shared Control:** AWS provides capability; Customer implements.
</details>

---

## Section 4: MFA and Security Tools (3 Questions)

### Q18. Which MFA device types are supported by AWS? (Select TWO)

A) Virtual MFA device (authenticator app)  
B) Biometric fingerprint scanner  
C) U2F Security Key  
D) Voice recognition  
E) Face ID

<details><summary>Answer</summary>

**A) Virtual MFA device and C) U2F Security Key**

**Why:** AWS supports three MFA types:
1. Virtual MFA (apps like Google Authenticator)
2. U2F Security Key (like YubiKey)
3. Hardware Key Fob (Gemalto)

**Not Supported:** Biometrics (face, fingerprint, voice)
</details>

---

### Q19. Which IAM security tool provides an account-level report of all users and their credential status?

A) IAM Access Advisor  
B) IAM Credentials Report  
C) AWS Trusted Advisor  
D) AWS Config

<details><summary>Answer</summary>

**B) IAM Credentials Report**

**Why:** Credentials Report is an account-level audit showing:
- All IAM users
- Password status
- Access key status
- MFA status

**Access Advisor** = Per-user permission analysis (what services, when used)
</details>

---

### Q20. A security team wants to identify unused IAM permissions. Which tool should they use?

A) IAM Credentials Report  
B) IAM Access Advisor  
C) AWS CloudTrail  
D) Amazon Inspector

<details><summary>Answer</summary>

**B) IAM Access Advisor**

**Why:** Access Advisor shows which services a user/role has permissions for AND when they last accessed those services. Unused permissions can be revoked (least privilege).

**Use Case:** "Last accessed 180 days ago" → Consider removing that permission
</details>

---

## Score Tracker

| Section | Questions | Your Score |
|---------|-----------|------------|
| IAM Basics | Q1-Q6 | ___ / 6 |
| Root User | Q7-Q10 | ___ / 4 |
| Shared Responsibility | Q11-Q17 | ___ / 7 |
| MFA & Tools | Q18-Q20 | ___ / 3 |
| **Total** | **20** | **___ / 20** |

---

## Score Interpretation

| Score | Verdict | Action |
|-------|---------|--------|
| 18-20 | ✅ Ready for Day 3 | Great job! Move on |
| 16-17 | 🟡 Almost there | Review missed topics |
| 12-15 | ⚠️ Needs work | Re-read resource, retake quiz |
| <12 | ❌ Not ready | Study resource thoroughly first |

---

## Weak Area Review Guide

| If you missed... | Review this section |
|------------------|---------------------|
| Q1-Q6 | Part 2: IAM Components |
| Q7-Q10 | Part 4: Root User |
| Q11-Q17 | Part 5: Shared Responsibility Model |
| Q18-Q20 | Part 3 & Part 6: MFA & Security Tools |
