# Day 3 Quiz: Security Services & VPC

**Domain 2: Security & Compliance (30% of exam)**  
**Time:** 25-30 minutes  
**Passing Score:** 80% (16/20 correct)

---

## Instructions

1. Answer each question without looking at the resource
2. For scenario questions, think about **WHY** before choosing
3. Mark questions you're unsure about for review
4. Check answers at the end

---

## Section 1: Network Protection - WAF & Shield (4 Questions)

### Q1. A company needs to protect their web application from SQL injection attacks. Which AWS service should they use?

A) AWS Shield  
B) AWS WAF  
C) Amazon Inspector  
D) Amazon GuardDuty

<details><summary>Answer</summary>

**B) AWS WAF**

**Why:** WAF (Web Application Firewall) operates at Layer 7 and protects against web exploits like SQL injection, XSS, and malicious bots.

**Exam Pattern:** "SQL injection" or "XSS" → WAF. "DDoS" → Shield.
</details>

---

### Q2. Which of the following AWS Shield features are available at NO additional cost? (Choose TWO)

A) DDoS Response Team (DRT) access  
B) Automatic L3/L4 DDoS protection  
C) Protection for CloudFront distributions  
D) Cost protection for scaling during attacks  
E) Real-time attack visibility metrics

<details><summary>Answer</summary>

**B) Automatic L3/L4 DDoS protection & C) Protection for CloudFront distributions**

**Why:** Shield Standard is FREE and automatically enabled. It provides Layer 3/4 protection and covers CloudFront, Route 53, and load balancers.

**Shield Advanced (~$3,000/month):** DRT, cost protection, L7 protection, real-time metrics.
</details>

---

### Q3. A company has deployed a web application on Amazon EC2 behind an Application Load Balancer (ALB). They want to block malicious IPs that exceed 100 requests per second. Which service should they use?

A) AWS Shield Standard  
B) AWS Shield Advanced  
C) AWS WAF  
D) Amazon CloudFront

<details><summary>Answer</summary>

**C) AWS WAF**

**Why:** WAF provides rate-based rules that can block IPs exceeding a request threshold. This is rate limiting at Layer 7.

**Key Concept:** WAF works with ALB, CloudFront, and API Gateway for rate limiting.
</details>

---

### Q4. Which services does AWS WAF integrate with? (Choose TWO)

A) Amazon EC2  
B) Amazon CloudFront  
C) Amazon RDS  
D) Application Load Balancer  
E) Network Load Balancer

<details><summary>Answer</summary>

**B) Amazon CloudFront & D) Application Load Balancer**

**Why:** WAF works with Layer 7 services: CloudFront, ALB, API Gateway, and AppSync. It does NOT work directly with EC2, RDS, or NLB.

**Remember:** WAF = Layer 7 = HTTP/HTTPS only.
</details>

---

## Section 2: Threat Detection Services (4 Questions)

### Q5. A company wants to detect unusual API activity and potential threats in their AWS account. Which service should they enable?

A) Amazon Inspector  
B) Amazon Macie  
C) Amazon GuardDuty  
D) AWS CloudTrail

<details><summary>Answer</summary>

**C) Amazon GuardDuty**

**Why:** GuardDuty uses ML and threat intelligence to detect threats by analyzing CloudTrail logs, VPC Flow Logs, and DNS logs.

**Key Words:** "Unusual API activity," "threat detection," "compromised instances" → GuardDuty.
</details>

---

### Q6. What is the AWS service that performs automated network assessments of Amazon EC2 instances to check for vulnerabilities?

A) Amazon Kinesis  
B) Security groups  
C) Amazon Inspector  
D) AWS Network Access Control Lists

<details><summary>Answer</summary>

**C) Amazon Inspector**

**Why:** Inspector scans EC2 instances, container images, and Lambda functions for software vulnerabilities (CVEs) and network exposure.

**Key Words:** "Vulnerability scanning," "CVE," "software vulnerabilities" → Inspector.
</details>

---

### Q7. A financial company needs to automatically detect and classify sensitive data like credit card numbers stored in Amazon S3. Which service should they use?

A) Amazon GuardDuty  
B) Amazon Inspector  
C) Amazon Macie  
D) AWS Config

<details><summary>Answer</summary>

**C) Amazon Macie**

**Why:** Macie uses ML to discover and classify sensitive data (PII, financial data, PHI) in S3 buckets.

**Key Words:** "PII," "sensitive data," "credit cards," "S3 classification" → Macie.
</details>

---

### Q8. Which statement correctly describes the difference between GuardDuty, Inspector, and Macie?

A) GuardDuty scans S3, Inspector detects threats, Macie finds vulnerabilities  
B) GuardDuty detects threats, Inspector finds vulnerabilities, Macie discovers sensitive data  
C) All three services perform the same function in different regions  
D) GuardDuty and Inspector are the same service with different names

<details><summary>Answer</summary>

**B) GuardDuty detects threats, Inspector finds vulnerabilities, Macie discovers sensitive data**

**Why:**
- **GuardDuty:** Threat detection using ML (account/VPC level)
- **Inspector:** Vulnerability scanning (EC2/containers/Lambda)
- **Macie:** Sensitive data discovery (S3)

**Memory Tip:** **G**uard (threats), **I**nspect (vulns), **M**acie (data).
</details>

---

## Section 3: Encryption & Key Management (3 Questions)

### Q9. A company needs dedicated hardware security modules for encryption to meet FIPS 140-2 Level 3 compliance. Which service should they use?

A) AWS KMS  
B) AWS CloudHSM  
C) AWS Secrets Manager  
D) AWS Certificate Manager

<details><summary>Answer</summary>

**B) AWS CloudHSM**

**Why:** CloudHSM provides dedicated, single-tenant hardware security modules with FIPS 140-2 Level 3 certification. KMS is multi-tenant and doesn't meet this compliance level.

**Key Words:** "FIPS 140-2 Level 3," "dedicated HSM," "single-tenant" → CloudHSM.
</details>

---

### Q10. A company wants to automatically rotate database passwords with no application code changes. Which service should they use?

A) AWS KMS  
B) AWS CloudHSM  
C) AWS Secrets Manager  
D) AWS Systems Manager Parameter Store

<details><summary>Answer</summary>

**C) AWS Secrets Manager**

**Why:** Secrets Manager stores, retrieves, and automatically rotates secrets like database passwords. It integrates with RDS for seamless rotation.

**Key Words:** "Rotate passwords," "store secrets," "API keys" → Secrets Manager.
</details>

---

### Q11. What are the key differences between AWS KMS and CloudHSM? (Choose TWO)

A) KMS is single-tenant, CloudHSM is multi-tenant  
B) KMS uses shared hardware, CloudHSM uses dedicated hardware  
C) CloudHSM provides FIPS 140-2 Level 3 compliance  
D) KMS costs more than CloudHSM  
E) KMS can only be used with S3

<details><summary>Answer</summary>

**B) KMS uses shared hardware, CloudHSM uses dedicated hardware & C) CloudHSM provides FIPS 140-2 Level 3 compliance**

**Why:**
- **KMS:** Multi-tenant, shared infrastructure, integrated with 100+ services
- **CloudHSM:** Single-tenant, dedicated HSM, FIPS 140-2 Level 3

**Cost Note:** CloudHSM (~$1.50/hr) is much more expensive than KMS.
</details>

---

## Section 4: Compliance & Auditing (3 Questions)

### Q12. A security team needs to investigate who deleted an EC2 instance last week. Which service should they use?

A) AWS Config  
B) Amazon CloudWatch  
C) AWS CloudTrail  
D) AWS X-Ray

<details><summary>Answer</summary>

**C) AWS CloudTrail**

**Why:** CloudTrail records all API calls in your AWS account—who did what, when, and from where. Perfect for security investigations.

**Key Words:** "Who deleted," "API activity," "audit trail" → CloudTrail.
</details>

---

### Q13. A company needs to ensure all S3 buckets have encryption enabled and automatically remediate non-compliant buckets. Which service should they use?

A) AWS CloudTrail  
B) AWS Config  
C) Amazon Inspector  
D) AWS Trusted Advisor

<details><summary>Answer</summary>

**B) AWS Config**

**Why:** Config tracks resource configurations and evaluates them against compliance rules. It can trigger automatic remediation actions.

**Key Words:** "Is resource compliant," "configuration state," "auto-remediate" → Config.
</details>

---

### Q14. A company needs to download AWS SOC 2 and PCI compliance reports for their auditors. Where should they go?

A) AWS Trusted Advisor  
B) AWS Config  
C) AWS Artifact  
D) AWS Security Hub

<details><summary>Answer</summary>

**C) AWS Artifact**

**Why:** Artifact is the portal for downloading AWS compliance reports (SOC, PCI, ISO) and agreements like BAA.

**Remember:** Artifact = AWS compliance documents.
</details>

---

## Section 5: VPC & Network Security (6 Questions)

### Q15. Which component allows resources in a private subnet to access the internet for software updates?

A) Internet Gateway  
B) NAT Gateway  
C) VPC Endpoint  
D) Transit Gateway

<details><summary>Answer</summary>

**B) NAT Gateway**

**Why:** NAT Gateway sits in a public subnet and allows private subnet resources to make outbound internet connections while remaining unreachable from the internet.

**Key Concept:** Private subnet → NAT Gateway → Internet Gateway → Internet.
</details>

---

### Q16. What defines a public subnet in a VPC?

A) A subnet with public IP addresses assigned  
B) A subnet with a route to an Internet Gateway  
C) A subnet in multiple Availability Zones  
D) A subnet with a NAT Gateway

<details><summary>Answer</summary>

**B) A subnet with a route to an Internet Gateway**

**Why:** A public subnet has a route table entry pointing 0.0.0.0/0 to an Internet Gateway (IGW). The presence of public IPs doesn't make it public—the route does.

**Exam Tip:** Public subnet = route to IGW.
</details>

---

### Q17. Which of the following is used to control network traffic in AWS? (Choose TWO)

A) Network Access Control Lists (NACLs)  
B) Key Pairs  
C) Access Keys  
D) IAM Policies  
E) Security Groups

<details><summary>Answer</summary>

**A) Network Access Control Lists (NACLs) & E) Security Groups**

**Why:**
- **Security Groups:** Instance-level, stateful firewall
- **NACLs:** Subnet-level, stateless firewall

**Distractors:** Key Pairs = SSH access, Access Keys = API auth, IAM Policies = permissions.
</details>

---

### Q18. A security administrator needs to block a specific malicious IP address from accessing any instances in a subnet. Which should they use?

A) Security Group  
B) Network ACL  
C) AWS WAF  
D) Route Table

<details><summary>Answer</summary>

**B) Network ACL**

**Why:** NACLs can have explicit DENY rules. Security Groups can only ALLOW—they cannot explicitly deny traffic.

**Critical Rule:** Need to DENY traffic? → NACL. Security Groups = allow only.
</details>

---

### Q19. What is the connectivity option that uses IPSec to establish encrypted connectivity between an on-premises network and the AWS Cloud?

A) Internet Gateway  
B) AWS Direct Connect  
C) AWS Site-to-Site VPN  
D) VPC Peering

<details><summary>Answer</summary>

**C) AWS Site-to-Site VPN**

**Why:** Site-to-Site VPN creates an encrypted IPSec tunnel over the public internet between your on-premises network and AWS VPC.

**VPN vs Direct Connect:** VPN = encrypted, over internet, quick setup. Direct Connect = dedicated line, not encrypted by default.
</details>

---

### Q20. A company has hundreds of VPCs in multiple AWS Regions worldwide. What service does AWS offer to simplify the connection management among the VPCs?

A) VPC Peering  
B) AWS Transit Gateway  
C) Amazon Connect  
D) Security Groups

<details><summary>Answer</summary>

**B) AWS Transit Gateway**

**Why:** Transit Gateway acts as a central hub to connect multiple VPCs and on-premises networks. VPC Peering works but doesn't scale (no transitive peering).

**Key Words:** "Multiple VPCs," "hub-and-spoke," "simplify connections" → Transit Gateway.
</details>

---

## Score Tracker

| Section | Questions | Your Score |
|---------|-----------|------------|
| WAF & Shield | Q1-Q4 | ___ / 4 |
| Threat Detection | Q5-Q8 | ___ / 4 |
| Encryption | Q9-Q11 | ___ / 3 |
| Compliance | Q12-Q14 | ___ / 3 |
| VPC & Network | Q15-Q20 | ___ / 6 |
| **Total** | **20** | **___ / 20** |

---

## Score Interpretation

| Score | Verdict | Action |
|-------|---------|--------|
| 18-20 | ✅ Ready for Day 4 | Great job! Move on |
| 16-17 | 🟡 Almost there | Review missed topics |
| 12-15 | ⚠️ Needs work | Re-read resource, retake quiz |
| <12 | ❌ Not ready | Study resource thoroughly first |

---

## Weak Area Review Guide

| If you missed... | Review this section |
|------------------|---------------------|
| Q1-Q4 | Part 1: Network Protection (WAF & Shield) |
| Q5-Q8 | Part 2: Threat Detection Services |
| Q9-Q11 | Part 3: Encryption & Key Management |
| Q12-Q14 | Part 4: Compliance & Auditing |
| Q15-Q20 | Part 5-7: VPC Fundamentals & Security |

---

## Quick Reference: Service Selection

| Scenario | Service |
|----------|---------|
| SQL injection protection | **WAF** |
| DDoS protection | **Shield** |
| Threat detection | **GuardDuty** |
| Vulnerability scanning | **Inspector** |
| PII in S3 | **Macie** |
| FIPS 140-2 Level 3 | **CloudHSM** |
| Who deleted X? | **CloudTrail** |
| Is X compliant? | **Config** |
| Block specific IP | **NACL** |
| Connect VPCs | **Transit Gateway** |
