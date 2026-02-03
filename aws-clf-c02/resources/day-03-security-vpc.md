# Day 3: Security Services & VPC

**Domain 2: Security & Compliance (30% of exam)**  
**Study Time:** 6-8 hours  

### 🎯 Learning Goals

By the end of Day 3, you will be able to:

1. **Choose** the right protection service: WAF (exploits) vs Shield (DDoS)
2. **Select** the correct detection service: GuardDuty (threats) vs Inspector (vulns) vs Macie (PII)
3. **Distinguish** KMS (managed keys) vs CloudHSM (dedicated hardware)
4. **Differentiate** CloudTrail (API logs) vs Config (resource compliance)
5. **Draw** a VPC architecture with public/private subnets, IGW, and NAT Gateway
6. **Compare** Security Groups vs NACLs on 5+ key differences
7. **Explain** VPC connectivity options: Endpoints, VPN, Direct Connect, Transit Gateway

---

## 📖 How to Use This Resource

1. **Understand** how each security service solves a specific problem
2. **Focus on** service selection—exam tests "which service for this scenario?"
3. **Compare** similar services (WAF vs Shield, SG vs NACL)
4. **Test yourself** with the self-check questions at the end

> [!IMPORTANT]
> **Day 3 completes Domain 2!** Combined with Day 2, you'll have covered all Security & Compliance topics (30% of exam).

---

## 🛡️ Part 1: Network Protection (WAF & Shield)

### AWS WAF (Web Application Firewall)

**What:** Protects web applications from common web exploits.

**Layer:** Application Layer (Layer 7 - HTTP/HTTPS)

**Protects Against:**
- SQL injection
- Cross-site scripting (XSS)
- HTTP floods
- Malicious bots

**Works With:**
- CloudFront
- Application Load Balancer (ALB)
- API Gateway
- AppSync

**Key Concepts:**
| Term | Meaning |
|------|---------|
| **Web ACL** | Set of rules applied to CloudFront/ALB |
| **Rules** | Match conditions + actions (allow/block/count) |
| **Managed Rules** | Pre-built rule sets (OWASP, AWS) |
| **Rate Limiting** | Block IPs exceeding request threshold |

**Exam Pattern:**
> "Protect web app from SQL injection..."
> → Answer: **AWS WAF**

---

### AWS Shield

**What:** DDoS protection service.

**Two Tiers:**

| Feature | Shield Standard | Shield Advanced |
|---------|-----------------|-----------------|
| **Cost** | Free | ~$3,000/month |
| **Included** | Automatically on | Opt-in |
| **Protection** | L3/L4 DDoS | L3/L4/L7 DDoS |
| **Response** | Automatic | DDoS Response Team |
| **Visibility** | Basic | Real-time metrics |
| **Cost Protection** | No | Yes (scaling costs) |

**Layer:** Network (L3), Transport (L4), Application (L7 with Advanced)

**Exam Pattern:**
> "Protect against DDoS attacks..."
> → Answer: **AWS Shield** (Standard = free, Advanced = paid)

---

### 💡 WAF vs Shield: When to Use

| Scenario | Service |
|----------|---------|
| Block SQL injection attacks | **WAF** |
| Block DDoS attacks | **Shield** |
| Rate-limit API requests | **WAF** |
| Protection for CloudFront | **Shield Standard** (automatic) |
| Need DDoS Response Team | **Shield Advanced** |

> [!TIP]
> **They work together!** Shield Advanced leverages WAF rules for Layer 7 DDoS protection.

### 📌 Quick Summary: Network Protection

- **WAF:** Layer 7 firewall, blocks SQL injection/XSS, works with CloudFront/ALB
- **Shield Standard:** Free, automatic DDoS protection (L3/L4)
- **Shield Advanced:** Paid, adds L7, DRT, cost protection
- Remember: WAF = web exploits, Shield = DDoS

---

## 🔍 Part 2: Threat Detection Services

### Amazon GuardDuty

**What:** Intelligent threat detection using ML and threat intelligence.

**Monitors:**
- AWS CloudTrail logs
- VPC Flow Logs
- DNS logs
- S3 data events
- EKS audit logs

**Detects:**
- Compromised EC2 instances
- Reconnaissance attacks
- Crypto mining
- Data exfiltration
- Unusual API calls

**Key Points:**
- **One-click enable** - no agents to install
- **Continuous monitoring** - 24/7
- **ML-based** - learns normal behavior

**Exam Pattern:**
> "Detect unusual API activity in AWS account..."
> → Answer: **GuardDuty**

---

### Amazon Inspector

**What:** Automated vulnerability assessment service.

**Scans:**
- EC2 instances
- Container images (ECR)
- Lambda functions

**Checks For:**
- Software vulnerabilities (CVEs)
- Network exposure
- Deviation from best practices

**Key Points:**
- Requires **SSM Agent** on EC2
- **Continuous scanning** when enabled
- Generates **findings** with severity

**Exam Pattern:**
> "Scan EC2 for software vulnerabilities..."
> → Answer: **Amazon Inspector**

---

### Amazon Macie

**What:** Data discovery and protection service using ML.

**Focus:** Amazon S3 data

**Detects:**
- Personally Identifiable Information (PII)
- Financial data (credit cards)
- Health information (PHI)
- Public/unencrypted buckets

**Key Points:**
- **S3-focused** (not EC2)
- Uses **ML to classify data**
- Helps with **compliance** (GDPR, HIPAA)

**Exam Pattern:**
> "Find PII data stored in S3..."
> → Answer: **Amazon Macie**

---

### 💡 GuardDuty vs Inspector vs Macie

| Service | What It Does | Target | Key Word |
|---------|-------------|--------|----------|
| **GuardDuty** | Threat detection | Account/VPC | "Threats", "API activity" |
| **Inspector** | Vulnerability scanning | EC2/Containers/Lambda | "Vulnerabilities", "CVEs" |
| **Macie** | Sensitive data discovery | S3 | "PII", "sensitive data" |

### 📌 Quick Summary: Threat Detection

- **GuardDuty:** ML-based threat detection, monitors logs, one-click enable
- **Inspector:** Vulnerability scanner for EC2/containers/Lambda
- **Macie:** PII/sensitive data discovery in S3
- Memory: **G**uard (threats), **I**nspect (vulns), **M**acie (data)

---

## 🔐 Part 3: Encryption & Key Management

### AWS KMS (Key Management Service)

**What:** Managed service for creating and managing encryption keys.

**Key Types:**
| Type | Who Manages | Cost |
|------|-------------|------|
| **AWS Managed** | AWS creates and manages | Free |
| **Customer Managed** | You create and manage | $1/month per key |
| **AWS Owned** | AWS uses internally | Free (hidden) |

**Key Features:**
- Automatic **key rotation** (yearly)
- **Multi-region keys** support
- Integrated with **100+ AWS services**
- **Audit** via CloudTrail

**Exam Pattern:**
> "Encrypt data using AWS-managed keys..."
> → Answer: **AWS KMS**

---

### AWS CloudHSM

**What:** Dedicated hardware security module (HSM) for encryption.

**Key Differences from KMS:**

| Feature | KMS | CloudHSM |
|---------|-----|----------|
| **Hardware** | Shared (multi-tenant) | Dedicated (single-tenant) |
| **Key Control** | AWS + You | You only |
| **Compliance** | Varies | FIPS 140-2 Level 3 |
| **Cost** | Per key/API call | Per hour (~$1.50/hr) |
| **Use Case** | Most encryption | Strict compliance |

**Exam Pattern:**
> "Need FIPS 140-2 Level 3 compliance..."
> → Answer: **CloudHSM**

---

### AWS Secrets Manager

**What:** Store, rotate, and retrieve secrets (passwords, API keys).

**Key Features:**
- **Automatic rotation** (configurable)
- **Integration** with RDS, Redshift
- **Encrypts** secrets using KMS

**Exam Pattern:**
> "Automatically rotate database passwords..."
> → Answer: **Secrets Manager**

---

### AWS Certificate Manager (ACM)

**What:** Provision and manage SSL/TLS certificates.

**Key Points:**
- **Free** public certificates
- **Auto-renewal**
- Works with CloudFront, ALB, API Gateway

### 📌 Quick Summary: Encryption Services

- **KMS:** Managed keys, multi-tenant, integrated everywhere
- **CloudHSM:** Dedicated HSM, single-tenant, FIPS 140-2 Level 3
- **Secrets Manager:** Store and rotate secrets/passwords
- **ACM:** Free SSL/TLS certificates, auto-renewal

---

## 📋 Part 4: Compliance & Auditing

### AWS CloudTrail

**What:** Records **API calls** made in your AWS account.

**Answers:** "Who did what, when, and from where?"

**Logs Include:**
- Who made the call (IAM identity)
- When it happened (timestamp)
- What was called (API name)
- Response (success/failure)

**Key Points:**
- **Enabled by default** (90 days)
- Store in S3 for **long-term retention**
- **Management events** vs **Data events**

**Exam Pattern:**
> "Track who deleted an EC2 instance..."
> → Answer: **CloudTrail**

---

### AWS Config

**What:** Tracks **resource configurations** and changes over time.

**Answers:** "What is the current state of my resources?"

**Key Features:**
- **Configuration history** of resources
- **Compliance rules** (managed and custom)
- **Remediation actions** (auto-fix)

**Use Cases:**
- Is encryption enabled on all S3 buckets?
- Are all security groups open to 0.0.0.0/0?
- Track configuration drift

**Exam Pattern:**
> "Ensure all S3 buckets are encrypted..."
> → Answer: **AWS Config** (compliance rule)

---

### 💡 CloudTrail vs Config

| Aspect | CloudTrail | Config |
|--------|------------|--------|
| **Tracks** | API calls (actions) | Resource configurations (state) |
| **Answers** | "Who did what?" | "What is the current state?" |
| **Focus** | Activity/audit | Compliance/configuration |
| **Example** | Who deleted the bucket? | Is the bucket encrypted? |

---

### AWS Artifact

**What:** Portal for **AWS compliance reports** and agreements.

**Provides:**
- SOC reports
- PCI reports
- ISO certifications
- Business Associate Agreement (BAA)

**Exam Pattern:**
> "Download AWS SOC 2 compliance report..."
> → Answer: **AWS Artifact**

---

### Security Hub

**What:** Central security dashboard aggregating findings from multiple services.

**Aggregates From:**
- GuardDuty
- Inspector
- Macie
- Firewall Manager
- IAM Access Analyzer
- Third-party tools

**Key Features:**
- **Centralized view** across accounts
- **Compliance checks** (CIS, PCI DSS)
- **Automated remediation** support

**Exam Pattern:**
> "Central dashboard for all security findings..."
> → Answer: **Security Hub**

### 📌 Quick Summary: Compliance & Auditing

- **CloudTrail:** API logs (who did what)
- **Config:** Resource state and compliance
- **Artifact:** Download AWS compliance reports
- **Security Hub:** Centralized security dashboard

---

## 🌐 Part 5: VPC Fundamentals

### What Is VPC?

**VPC (Virtual Private Cloud):** Your own isolated network within AWS.

**Key Characteristics:**
- **Region-scoped** (spans all AZs in a region)
- **IP range defined** by CIDR block
- **Default VPC** created automatically per region

---

### VPC Components

```
                         ┌─────────────────────────────────────────┐
                         │              AWS REGION                  │
                         │                                          │
   Internet              │  ┌─────────────────────────────────┐   │
      │                  │  │             VPC                   │   │
      ▼                  │  │                                    │   │
  ┌───────┐             │  │  ┌──────────┐    ┌──────────┐    │   │
  │  IGW  │─────────────│─▶│  │ PUBLIC   │    │ PRIVATE  │    │   │
  └───────┘             │  │  │ SUBNET   │    │ SUBNET   │    │   │
                        │  │  │          │    │          │    │   │
                        │  │  │  ┌──┐    │    │  ┌──┐    │    │   │
                        │  │  │  │EC2│   │    │  │RDS│   │    │   │
                        │  │  │  └──┘    │    │  └──┘    │    │   │
                        │  │  └────┬─────┘    └─────┬────┘    │   │
                        │  │       │                │         │   │
                        │  │       │    ┌──────┐    │         │   │
                        │  │       └───▶│ NAT  │◀───┘         │   │
                        │  │            └──────┘              │   │
                        │  └─────────────────────────────────┘   │
                        └─────────────────────────────────────────┘
```

| Component | What It Does |
|-----------|-------------|
| **VPC** | Virtual network container |
| **Subnet** | Partition of VPC in one AZ |
| **Internet Gateway (IGW)** | Connects VPC to internet |
| **NAT Gateway** | Allows private subnet outbound internet |
| **Route Table** | Controls traffic routing |

---

### Public vs Private Subnets

| Aspect | Public Subnet | Private Subnet |
|--------|---------------|----------------|
| **Route to IGW** | Yes | No |
| **Direct internet access** | Yes | No |
| **Typical resources** | Web servers, bastion | Databases, app servers |
| **Outbound internet** | Via IGW | Via NAT Gateway |

**Exam Tip:** Public subnet = has route to Internet Gateway

---

### NAT Gateway vs NAT Instance

| Feature | NAT Gateway | NAT Instance |
|---------|-------------|--------------|
| **Managed by** | AWS | You |
| **Availability** | Highly available | Manual HA |
| **Bandwidth** | Up to 100 Gbps | Instance-limited |
| **Recommended** | ✅ Yes | Legacy |

### 📌 Quick Summary: VPC Basics

- **VPC:** Isolated network in AWS, region-scoped
- **Public Subnet:** Has route to IGW, internet-accessible
- **Private Subnet:** No IGW route, uses NAT for outbound
- **NAT Gateway:** AWS-managed, lets private resources reach internet

---

## 🔒 Part 6: Security Groups vs NACLs

### 🔥 Critical Comparison Table

| Feature | Security Groups | NACLs |
|---------|-----------------|-------|
| **Level** | Instance (ENI) | Subnet |
| **State** | **Stateful** | **Stateless** |
| **Rules** | Allow only | Allow AND Deny |
| **Default** | Deny all inbound | Allow all |
| **Rule Order** | All evaluated | Number order |
| **Association** | Instance can have multiple | Subnet has one |

### Understanding Stateful vs Stateless

**Stateful (Security Groups):**
- If inbound is allowed, outbound response is **automatically allowed**
- No need to create separate outbound rule

**Stateless (NACLs):**
- Must explicitly allow **both inbound AND outbound**
- Return traffic needs its own rule

### Example Scenario

```
Request:  Client → EC2 (port 443)
Response: EC2 → Client (ephemeral port)

Security Group: Only need INBOUND rule for 443
NACL: Need INBOUND rule for 443 AND OUTBOUND rule for ephemeral ports
```

### Exam Patterns

| Scenario | Answer |
|----------|--------|
| "Block specific IP from accessing instance" | **NACL** (can deny) |
| "Allow port 443 for web server" | **Security Group** |
| "Instance-level firewall" | **Security Group** |
| "Subnet-level firewall" | **NACL** |
| "Stateful firewall" | **Security Group** |

### 📌 Quick Summary: SG vs NACL

- **Security Groups:** Instance-level, stateful, allow-only
- **NACLs:** Subnet-level, stateless, allow AND deny
- Remember: **S**G = **S**tateful, NACL = **N**ot stateful

---

## 🔗 Part 7: VPC Connectivity

### VPC Endpoints

**What:** Private connections to AWS services **without using internet**.

**Types:**

| Type | For | Example |
|------|-----|---------|
| **Gateway Endpoint** | S3, DynamoDB | Free |
| **Interface Endpoint** | Other AWS services | Costs money |

**Exam Pattern:**
> "Access S3 without going through internet..."
> → Answer: **VPC Gateway Endpoint**

---

### VPC Peering

**What:** Connect two VPCs privately.

**Key Points:**
- **No transitive peering** (A-B-C ≠ A→C)
- Can be cross-region
- CIDR blocks cannot overlap

---

### AWS PrivateLink

**What:** Expose service to other VPCs privately.

**Use Case:** Vendor providing service to customers

---

### Connectivity to On-Premises

| Option | Connection | Speed | Cost |
|--------|------------|-------|------|
| **Site-to-Site VPN** | Over internet | Variable | Low |
| **Direct Connect** | Dedicated line | Consistent | High |
| **Direct Connect + VPN** | Both | Secure + fast | Highest |

**Exam Patterns:**
| Scenario | Answer |
|----------|--------|
| "Quick, encrypted connection to on-prem" | **Site-to-Site VPN** |
| "Consistent, high bandwidth to on-prem" | **Direct Connect** |
| "Connect multiple VPCs to on-prem" | **Transit Gateway** |

---

### Transit Gateway

**What:** Central hub to connect VPCs and on-premises networks.

**Benefits:**
- **Hub-and-spoke** model
- Simplifies complex networks
- Works with VPN and Direct Connect

### 📌 Quick Summary: VPC Connectivity

- **VPC Endpoints:** Private access to AWS services (no internet)
- **VPC Peering:** Connect two VPCs (no transitive)
- **Site-to-Site VPN:** Encrypted tunnel over internet
- **Direct Connect:** Dedicated private connection
- **Transit Gateway:** Hub for multiple VPCs

---

## 🧪 Self-Check Questions

### Security Services

1. **Which service protects against SQL injection?**
   <details><summary>Answer</summary>
   AWS WAF (Web Application Firewall) - Layer 7 protection
   </details>

2. **Which service provides free DDoS protection?**
   <details><summary>Answer</summary>
   AWS Shield Standard - automatically enabled
   </details>

3. **Which service detects threats using ML?**
   <details><summary>Answer</summary>
   Amazon GuardDuty - analyzes logs, detects anomalies
   </details>

4. **Which service scans EC2 for vulnerabilities?**
   <details><summary>Answer</summary>
   Amazon Inspector - CVE scanning
   </details>

5. **Which service finds PII in S3?**
   <details><summary>Answer</summary>
   Amazon Macie - uses ML to classify data
   </details>

6. **Which service needs FIPS 140-2 Level 3?**
   <details><summary>Answer</summary>
   CloudHSM - dedicated hardware security module
   </details>

### VPC

7. **What defines a public subnet?**
   <details><summary>Answer</summary>
   Has a route to an Internet Gateway (IGW)
   </details>

8. **Which is stateful: Security Group or NACL?**
   <details><summary>Answer</summary>
   Security Group is stateful; NACL is stateless
   </details>

9. **How do private subnets access internet?**
   <details><summary>Answer</summary>
   Through a NAT Gateway in a public subnet
   </details>

10. **How to access S3 without internet?**
    <details><summary>Answer</summary>
    VPC Gateway Endpoint for S3
    </details>

---

## 🔧 Hands-On Setup: Day 3 Practice

### Practice 1: Explore Default VPC

**Objective:** Understand VPC components

**Steps:**
1. Go to [VPC Console](https://console.aws.amazon.com/vpc)
2. Click **Your VPCs** → Note the default VPC
3. Click **Subnets** → Count subnets (one per AZ)
4. Click **Internet Gateways** → See IGW attached
5. Click **Route Tables** → Check routes (0.0.0.0/0 → IGW)

**Expected Result:** Understand how default VPC is structured.

### Practice 2: Compare Security Group vs NACL

**Objective:** See the difference in configuration

**Steps:**
1. In VPC Console, click **Security Groups**
2. Select default SG → Note: Only **Allow** rules
3. Click **Network ACLs** → Select default NACL
4. Note: Has **Allow AND Deny** rules with numbers

**Expected Result:** See stateful (SG) vs stateless (NACL) difference.

### Practice 3: View Security Hub (Optional)

**Objective:** See centralized security dashboard

**Steps:**
1. Go to [Security Hub Console](https://console.aws.amazon.com/securityhub)
2. Enable if prompted (free tier: 30 days)
3. Browse findings from GuardDuty, Inspector

> [!CAUTION]
> **Free Tier Alert:** Security Hub has 30-day free trial. Disable after exploring to avoid charges.

---

## 💡 Tips & Tricks

### Exam Tips

| Tip | Details |
|-----|---------|
| **"SQL injection"** | Answer is WAF |
| **"DDoS protection"** | Answer is Shield |
| **"Threat detection"** | Answer is GuardDuty |
| **"Vulnerability scanning"** | Answer is Inspector |
| **"PII in S3"** | Answer is Macie |
| **"Who deleted..."** | Answer is CloudTrail |
| **"Is resource compliant..."** | Answer is Config |
| **"Block specific IP"** | Answer is NACL (only NACL can deny) |

### Time-Saving Tricks

| Trick | Why |
|-------|-----|
| SG = Stateful | Return traffic automatic |
| NACL = Needs both rules | Inbound AND outbound required |
| Shield Standard = Free | Always enabled automatically |
| Gateway Endpoint = Free | S3 and DynamoDB only |

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| Confusing WAF and Shield | WAF = exploits, Shield = DDoS |
| Using SG to deny traffic | SG can only allow; use NACL to deny |
| Forgetting NAT for private | Private subnets need NAT Gateway |
| CloudTrail vs Config | Trail = actions, Config = state |

---

## 📝 Flashcard Quick Reference

| Front | Back |
|-------|------|
| WAF | Web exploits (SQL injection, XSS) |
| Shield Standard | Free DDoS protection |
| Shield Advanced | Paid DDoS with DRT |
| GuardDuty | ML threat detection |
| Inspector | Vulnerability scanning |
| Macie | PII detection in S3 |
| KMS | Managed encryption keys |
| CloudHSM | Dedicated HSM hardware |
| CloudTrail | API call logging |
| Config | Resource compliance |
| Security Hub | Centralized findings |
| Security Group | Stateful, instance-level |
| NACL | Stateless, subnet-level |
| VPC Endpoint | Private access to AWS |
| NAT Gateway | Private subnet outbound |

---

## ✅ Day 3 Completion Checklist

Before moving to Day 4, make sure you can:

- [ ] **Distinguish** WAF vs Shield (use cases)
- [ ] **Choose** between GuardDuty, Inspector, Macie
- [ ] **Explain** KMS vs CloudHSM
- [ ] **Differentiate** CloudTrail vs Config
- [ ] **Draw** public vs private subnet architecture
- [ ] **Compare** Security Groups vs NACLs (5 differences)
- [ ] **Explain** VPC Endpoints, VPN, Direct Connect

---

## 📝 Quiz Guidance

**After studying this resource, take these quizzes:**

| Quiz | Source | Focus |
|------|--------|-------|
| **Quiz 13** | Stephane Maarek Course | VPC & Networking |
| **Quiz 14** | Stephane Maarek Course | Security & Compliance |

**Target Score:** 80%+ before proceeding to Day 4

> [!TIP]
> Security questions love "which service for X" patterns. Match the scenario to the service's primary purpose.

---

**Previous:** [← Day 2 - IAM & Security](day-02-iam-security.md)  
**Next:** [Day 4 - Compute & Storage →](day-04-compute-storage.md)
