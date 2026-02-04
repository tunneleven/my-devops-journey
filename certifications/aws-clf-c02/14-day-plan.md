# ☁️ AWS CLF-C02: The 14-Day Fundamentals Sprint

**Target:** AWS Certified Cloud Practitioner
**Deadline:** Feb 12, 2026
**Strategy:** "Mile Wide, Inch Deep" + Terraform for Exploration.

---

## 📅 The Schedule (Jan 26 - Feb 10)

### 🏗️ Sprint 1: Concepts, Billing & Security (Domains 1, 2, 4)
*The non-technical stuff that fails developers.*

**Day 1 (Mon): Cloud Concepts & Value**
*   **Step 0: Know the Enemy**
    *   **Task:** Read the [Official AWS CLF-C02 Exam Guide (HTML)](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02.html#cloud-practitioner-02-exam-content).
    *   *Focus:* Note the domain weightings.
*   **Study:** CAPEX vs OPEX, TCO, Shared Responsibility Model, AWS Cloud Adoption Framework (CAF).
*   **Terraform Lab:**
    *   Run `terraform plan` on a resource.
    *   *Observation:* Note how "Managed Services" (RDS) differ from "Unmanaged" (EC2).
    *   **Exam Alert:** Deep dive **AWS Artifact** (Compliance Reports) and **Shared Responsibility Model** (Security of Cloud vs within Cloud).

**Day 2 (Tue): Identity & Access (IAM)**
*   **Study:** Users vs Groups vs Roles. MFA. Root User protection.
*   **Terraform Lab:**
    *   Create an `aws_iam_user` and `aws_iam_group`.
    *   *Key:* Notice that an IAM User is *Global* (not bound to a Region).

**Day 3 (Wed): Billing & Pricing**
*   **Study:** Savings Plans vs Reserved Instances. Consolidated Billing. Cost Explorer vs Budgets.
*   **Lab:**
    *   Create an `aws_budgets_budget` resource (Yes, you can Terraform your budget!).
    *   *Key:* **CRITICAL:** `Budgets` = ALERTS (Stop spending). `Cost Explorer` = REPORTS (Analyze past spending).

**Day 4 (Thu): Governance & Support**
*   **Study:** Organizations, Service Control Policies (SCPs).
*   **Support Plans:** Basic vs Developer vs Business vs Enterprise. (Note: On-Ramp exists but Basic/Dev/Biz/Ent are the core exam 4).
*   **Terraform Lab:**
    *   Explore `aws_organizations_organization`.

---

### 💻 Sprint 2: Core Technology (Domain 3 - Part A)
*The Meat & Potatoes.*

**Day 5 (Fri): Compute**
*   **Study:** EC2 Instance Types (Remember "M.C.R.O.P." - Main, Compute, RAM, etc). Lambda, Fargate, Beanstalk.
*   **Terraform Lab:**
    *   Deploy an `aws_instance` (EC2) vs `aws_lambda_function`.
    *   *Contrast:* Check how many arguments EC2 needs vs Lambda.

**Weekend 1 (Jan 31 - Feb 1): Network & Storage**
*   **Saturday (Storage):**
    *   **Study:** S3 (Classes: Standard, IA, Glacier). EBS vs EFS vs Instance Store. Storage Gateway.
    *   **Lab:** Terraform an S3 bucket with Lifecycle Rules (move to Glacier).
*   **Sunday (Network):**
    *   **Study:** VPC, Subnets, IGW, NAT Gateway, Security Groups vs NACLs.
    *   **Lab:** The classic "VPC Module". Don't write from scratch, use the `terraform-aws-modules/vpc/aws` module to see what it creates.

---

### 🧠 Sprint 3: The "Long Tail" (Domain 3 - Part B)
*The "What is that?" services. You just need a 1-line definition for these.*

**Day 8 (Mon): Databases**
*   **Study:** RDS vs Aurora (Serverless). DynamoDB. Redshift (Warehousing). ElastiCache.
*   **Key:** Know when to use Redshift (OLAP) vs RDS (OLTP).

**Day 9 (Tue): Migration & Innovation**
*   **Study:** Snow Family (Snowball/Snowmobile). DMS (DB Migration).
*   **AI/ML:** SageMaker, **Bedrock (GenAI)**, Lex, Polly, Rekognition. (Just know what they do).

**Day 10 (Wed): Security & Compliance Tools**
*   **Study:** Inspector, GuardDuty, Macie (Data privacy), Shield/WAF.
*   **Key:** WAF = Layer 7. Shield = DDoS. Macie = PII in S3.

**Day 11 (Thu): Resilience & Management**
*   **Study:** CloudWatch vs CloudTrail (Logs vs Audits). Config. Trusted Advisor.
*   **Lab:**
    *   Look at `aws_cloudwatch_metric_alarm` in Terraform.
    *   **Exam Concept:** Understand **CloudFormation** (Templates, Stacks) even if you write Terraform. The exam asks about "Infrastructure as Code service on AWS".

---

### 🎓 Sprint 4: Final Polish

**Day 12 (Fri): The Well-Architected Framework**
*   **Study:** The 6 Pillars (OpEx, Security, Reliability, Perf, Cost, Sustainability).
*   **Activity:** Read the Whitepaper (Summary version).

**Weekend 2 (Feb 7 - Feb 8): Practice Exams**
*   **Saturday:** Full Practice Exam 1.
*   **Sunday:** Full Practice Exam 2. Focus on "Reading carefully" - CLF questions are tricky with vocabulary.

**Day 14 (Mon, Feb 9): Final Review**
*   **Task:** Review the "Support Plans" table again. (Guaranteed 3-4 questions).

---

## 📚 Resources
*   **The Source of Truth:** [AWS Certified Cloud Practitioner (CLF-C02) Exam Guide](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02.html#cloud-practitioner-02-exam-content)
    *   *Rule:* All content must align with the domains and task statements in this HTML guide.
    *   *Domains:*
        *   [Domain 1: Cloud Concepts (24%)](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain1.html)
        *   [Domain 2: Security and Compliance (30%)](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain2.html)
        *   [Domain 3: Cloud Technology and Services (34%)](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain3.html)
        *   [Domain 4: Billing, Pricing, and Support (12%)](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain4.html)
*   **Official:** [AWS Cloud Practitioner Essentials (Free)](https://aws.amazon.com/training/digital/aws-cloud-practitioner-essentials/)
*   **Practice:** Tutorials Dojo (CLF-C02)
*   **Cheat Sheet:** [Tutorials Dojo CLF-C02 Cheat Sheets](https://tutorialsdojo.com/aws-certified-cloud-practitioner/)

## 🎼 Orchestration Report (Verified by Antigravity)

### Agents Invoked
1.  **Project Planner:** Confirmed 14-day pacing is realistic (approx 1.5h/day).
2.  **DevOps Mentor:** Validated "Terraform for learning, CloudFormation for exam" strategy. Added specific CloudFormation concept checks.
3.  **Security Auditor:** Enhanced Domain 2 coverage (Artifact, Shared Responsibility, KMS differentiation).

### Key Findings
*   **Terraform:** Great for your career, but exam asks about CloudFormation. Added specific note to study CloudFormation *patterns*.
*   **Support Plans:** "Enterprise On-Ramp" is not strictly in the exam pool yet. Reverted to focusing on the core 4.
*   **Missing:** AWS Artifact was missing. Critical for "Compliance" questions. Added.

### Verification
*   Current plan covers all 4 Domains with correct weightings.
*   Updated to include GenAI (Bedrock) and Sustainability.

---

# 🚨 Critical Concepts (Cheat Sheet)
*Master these specific distinctions. They are the most common failure points.*

## 🛡️ Security: The "Confusion Matrix"

### 1. Threat Detection vs. Vulnerability Scanning
*   **GuardDuty** (Intelligent Threat Detection)
    *   **What it does:** Monitors **Logs** (CloudTrail, VPC Flow Logs, DNS Logs). Uses ML to find *anomalies*.
    *   **Keywords:** "Intelligent", "Malicious IP", "Crypto mining", "Account compromise".
*   **Inspector** (Vulnerability Management)
    *   **What it does:** Scans **EC2 Instances** and **ECR Images** for software vulnerabilities (CVEs).
    *   **Keywords:** "CVE", "Network Reachability", "Package vulnerability", "Assessment".

### 2. DDoS vs. Web Exploits
*   **AWS WAF** (Web Application Firewall)
    *   **Layer:** Layer 7 (Application).
    *   **Protects Against:** SQL Injection, Cross-Site Scripting (XSS), Bad Bots.
*   **AWS Shield** (DDoS Protection)
    *   **Layer:** Layer 3/4 (Network/Transport).
    *   **Protects Against:** Volumetric Attacks (UDP Floods).

### 3. Data Privacy
*   **Macie**
    *   **Function:** Discovers sensitive data (PII, Credit Cards) in **S3 Buckets**.

## 💰 Billing: Implementation vs. Analysis

### 1. Budgets vs. Cost Explorer
*   **AWS Budgets** = **ALERTS** & **ACTIONS** (Future/Present).
    *   *Use Case:* "Email me if I spend > $10."
*   **Cost Explorer** = **VISUALIZE** & **ANALYZE** (Past).
    *   *Use Case:* "Show me a graph of my EC2 spend last month."

## 🆘 Support Plans (The Core 4)

| Plan | Response Time (Critical System Down) | Key Feature |
| :--- | :--- | :--- |
| **Basic** | N/A | Customer Service & Docs only. No Tech Support. |
| **Developer** | < 12 hours (Business hours) | Email access to Cloud Support Associates. |
| **Business** | < 1 hour (24/7) | Chat/Phone/Email. Full Trusted Advisor checks. |
| **Enterprise** | < 15 minutes (24/7) | **TAM (Technical Account Manager)**. Review. |

## 📜 Compliance
*   **AWS Artifact:** The central resource for downloading compliance reports (ISO, PCI-DSS, SOC).
    *   *Use Case:* "An auditor needs proof that AWS is PCI compliant."
