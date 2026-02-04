# Day 1 Quiz: Cloud Concepts Foundation

**Domain 1: Cloud Concepts (24% of exam)**  
**Time:** 20-25 minutes  
**Passing Score:** 80% (16/20 correct)

---

## Instructions

1. Answer each question without looking at the resource
2. For scenario questions, think about **WHY** before choosing
3. Mark questions you're unsure about for review
4. Check answers at the end

---

## Section 1: Cloud Computing Basics (5 Questions)

### Q1. What is the PRIMARY benefit of trading capital expense (CapEx) for operational expense (OpEx)?

A) Lower total cost of ownership  
B) No upfront investment, pay only for what you use  
C) Better hardware performance  
D) Faster network speeds

<details><summary>Answer</summary>

**B) No upfront investment, pay only for what you use**

**Why:** Trading CapEx for OpEx means you don't need to invest millions upfront in hardware. Instead, you pay monthly based on usage—like renting vs. buying a house.

**Trap:** Option A is tempting but not always true—cloud can be more expensive over time.
</details>

---

### Q2. A startup needs to launch a product quickly but doesn't know how many users will sign up. Which cloud advantage addresses this concern?

A) Go global in minutes  
B) Benefit from economies of scale  
C) Stop guessing capacity  
D) Trade CapEx for OpEx

<details><summary>Answer</summary>

**C) Stop guessing capacity**

**Why:** The startup doesn't know future demand. With cloud, they can start small and scale automatically based on actual usage—no over-provisioning or under-provisioning.

**Exam Pattern:** When questions mention "unpredictable demand" or "unknown traffic," think: Stop guessing capacity → Auto Scaling.
</details>

---

### Q3. Which characteristic of cloud computing means resources are shared among multiple customers without them knowing?

A) On-demand self-service  
B) Broad network access  
C) Resource pooling  
D) Rapid elasticity

<details><summary>Answer</summary>

**C) Resource pooling**

**Why:** Cloud providers pool resources (CPU, memory, storage) across many customers. You don't know who your "neighbors" are—this is called multi-tenancy.

**Key Concept:** Resource pooling enables cost efficiency through shared infrastructure.
</details>

---

### Q4. A company wants to run AWS infrastructure in their own data center due to regulatory requirements. Which deployment model should they use?

A) Public Cloud  
B) Private Cloud  
C) Hybrid Cloud  
D) Multi-Cloud

<details><summary>Answer</summary>

**C) Hybrid Cloud**

**Why:** They want AWS services BUT in their own data center. This is Hybrid—combining on-premises infrastructure with AWS services (e.g., AWS Outposts).

**Exam Tip:** "Regulatory requirements" + "on-premises" often points to Hybrid or Private.
</details>

---

### Q5. Which service model gives you the MOST control over the infrastructure?

A) SaaS  
B) PaaS  
C) IaaS  
D) FaaS

<details><summary>Answer</summary>

**C) IaaS (Infrastructure as a Service)**

**Why:** With IaaS (like EC2), you manage the OS, applications, and data. AWS only manages the underlying hardware and virtualization.

**Remember:** More control = More responsibility. IaaS gives maximum control but you handle patching, security, etc.
</details>

---

## Section 2: Well-Architected Framework (7 Questions)

### Q6. A company wants to automate their infrastructure provisioning using templates. Which Well-Architected pillar does this align with?

A) Security  
B) Reliability  
C) Operational Excellence  
D) Cost Optimization

<details><summary>Answer</summary>

**C) Operational Excellence**

**Why:** Operational Excellence focuses on "operations as code"—using IaC (Infrastructure as Code) like CloudFormation to automate provisioning.

**Key Principle:** If the question mentions "automation," "code," or "templates," think Operational Excellence.
</details>

---

### Q7. Which Well-Architected pillar focuses on the ability to RECOVER from failures?

A) Security  
B) Reliability  
C) Performance Efficiency  
D) Sustainability

<details><summary>Answer</summary>

**B) Reliability**

**Why:** Reliability = "What happens when things break?" It covers automatic recovery, testing recovery procedures, and scaling horizontally.

**Key Metrics:** RTO (how fast to recover) and RPO (how much data loss acceptable).
</details>

---

### Q8. A solutions architect is designing a system that must protect data both at rest and in transit. Which pillar is PRIMARILY concerned with this?

A) Operational Excellence  
B) Security  
C) Reliability  
D) Performance Efficiency

<details><summary>Answer</summary>

**B) Security**

**Why:** Security pillar covers data protection (encryption at rest and in transit), identity management (IAM), and traceability (CloudTrail).

**Security Focus Areas:** CIA Triad—Confidentiality, Integrity, Availability.
</details>

---

### Q9. Which pillar was added to the Well-Architected Framework most recently?

A) Cost Optimization  
B) Reliability  
C) Sustainability  
D) Performance Efficiency

<details><summary>Answer</summary>

**C) Sustainability**

**Why:** Sustainability was added in December 2021 as the 6th pillar. It focuses on minimizing environmental impact and maximizing resource utilization.

**Exam Tip:** Questions about "carbon footprint," "environmental impact," or "efficient resources" → Sustainability.
</details>

---

### Q10. A company wants to use the smallest instance type that meets their performance needs. Which TWO pillars does this decision address? (Select TWO)

A) Security  
B) Cost Optimization  
C) Reliability  
D) Performance Efficiency  
E) Sustainability

<details><summary>Answer</summary>

**B) Cost Optimization & E) Sustainability**

**Why:** 
- **Cost Optimization:** Right-sizing saves money by not over-provisioning
- **Sustainability:** Smaller instances use fewer resources, reducing environmental impact

**Trade-off Example:** This shows how pillars interconnect—one action can satisfy multiple pillars.
</details>

---

### Q11. An application experiences slow response times during peak hours. According to the Well-Architected Framework, which service would help?

A) AWS CloudTrail  
B) Amazon CloudFront  
C) AWS Trusted Advisor  
D) AWS Config

<details><summary>Answer</summary>

**B) Amazon CloudFront**

**Why:** CloudFront is a CDN (Content Delivery Network) that caches content at edge locations, reducing latency. This relates to the Performance Efficiency pillar.

**Performance Services:** CloudFront, ElastiCache, Auto Scaling, Read Replicas.
</details>

---

### Q12. Which AWS tool provides recommendations for underutilized EC2 instances?

A) AWS Budgets  
B) AWS Cost Explorer  
C) AWS Compute Optimizer  
D) AWS Pricing Calculator

<details><summary>Answer</summary>

**C) AWS Compute Optimizer**

**Why:** Compute Optimizer analyzes utilization metrics and recommends optimal instance types (rightsizing). It uses machine learning to identify underutilized resources.

**Rightsizing Tools:** Compute Optimizer, Trusted Advisor, Cost Explorer.
</details>

---

## Section 3: Cloud Adoption Framework (5 Questions)

### Q13. Which AWS CAF perspective is responsible for ensuring cloud investments align with business goals?

A) People  
B) Governance  
C) Business  
D) Platform

<details><summary>Answer</summary>

**C) Business**

**Why:** The Business perspective focuses on ROI, strategy, and ensuring cloud investments deliver business value. Key stakeholders: CEO, CFO, CIO.

**BPG Group:** Business + People + Governance = Business-focused perspectives.
</details>

---

### Q14. A company is planning a cloud migration and needs to address organizational culture change. Which CAF perspective should they focus on?

A) Business  
B) People  
C) Governance  
D) Operations

<details><summary>Answer</summary>

**B) People**

**Why:** The People perspective handles culture evolution, workforce transformation, and cloud fluency training. Key stakeholders: HR, Cloud Director, CIO.

**Key Word Triggers:** "Culture," "training," "skills," "workforce" → People perspective.
</details>

---

### Q15. Which CAF perspective is responsible for defining security policies and compliance requirements?

A) Business  
B) Governance  
C) Security  
D) Platform

<details><summary>Answer</summary>

**C) Security**

**Why:** The Security perspective focuses on confidentiality, integrity, and availability. It defines security controls, incident response, and compliance. Key stakeholders: CISO, CCO.

**Watch Out:** Governance handles RISK management, but Security handles SECURITY policies.
</details>

---

### Q16. The CAF perspectives can be divided into two groups. Which are the TECHNICAL-focused perspectives?

A) Business, People, Governance  
B) Platform, Security, Operations  
C) Business, Governance, Security  
D) People, Platform, Operations

<details><summary>Answer</summary>

**B) Platform, Security, Operations (PSO)**

**Why:** 
- **BPG** (Business, People, Governance) = Business-focused
- **PSO** (Platform, Security, Operations) = Technical-focused

**Memory Tip:** PSO is "technical" because it's owned by architects, engineers, and IT teams.
</details>

---

### Q17. Which CAF perspective includes capabilities like CI/CD and modern application development?

A) Governance  
B) Platform  
C) Operations  
D) Security

<details><summary>Answer</summary>

**B) Platform**

**Why:** The Platform perspective focuses on building the technical cloud environment—architecture, provisioning, CI/CD pipelines, and modern app development.

**Platform Capabilities:** Platform Architecture, Data Engineering, CI/CD, Provisioning.
</details>

---

## Section 4: Migration Strategies (3 Questions)

### Q18. A company wants to migrate their web application to the cloud as quickly as possible with minimal changes. Which migration strategy should they use?

A) Refactor  
B) Replatform  
C) Rehost  
D) Repurchase

<details><summary>Answer</summary>

**C) Rehost (Lift and Shift)**

**Why:** Rehost moves applications as-is with no code changes—fastest migration but fewest cloud-native benefits.

**Exam Pattern:** "Fastest," "minimal changes," "as-is" → Rehost.
</details>

---

### Q19. A company is replacing their custom CRM system with Salesforce. Which migration strategy is this?

A) Rehost  
B) Replatform  
C) Refactor  
D) Repurchase

<details><summary>Answer</summary>

**D) Repurchase (Drop and Shop)**

**Why:** They're dropping their custom solution and purchasing a SaaS product (Salesforce). This is Repurchase—replacing with a commercial off-the-shelf solution.

**Repurchase Examples:** Custom CRM → Salesforce, Custom email → Microsoft 365.
</details>

---

### Q20. A company is migrating from MySQL on-premises to Amazon RDS without redesigning the application. Which strategy is this?

A) Rehost  
B) Replatform  
C) Refactor  
D) Relocate

<details><summary>Answer</summary>

**B) Replatform (Lift, Tinker, and Shift)**

**Why:** They're making a minor optimization (moving to managed database RDS) without fully refactoring the application. This is Replatform.

**Replatform vs Rehost:** If there's a "minor optimization" but no major code change, it's Replatform.
</details>

---

## Score Tracker

| Section | Questions | Your Score |
|---------|-----------|------------|
| Cloud Basics | Q1-Q5 | ___ / 5 |
| Well-Architected | Q6-Q12 | ___ / 7 |
| CAF | Q13-Q17 | ___ / 5 |
| Migration | Q18-Q20 | ___ / 3 |
| **Total** | **20** | **___ / 20** |

---

## Score Interpretation

| Score | Verdict | Action |
|-------|---------|--------|
| 18-20 | ✅ Ready for Day 2 | Great job! Move on |
| 16-17 | 🟡 Almost there | Review missed topics |
| 12-15 | ⚠️ Needs work | Re-read resource, retake quiz |
| <12 | ❌ Not ready | Study resource thoroughly first |

---

## Weak Area Review Guide

| If you missed... | Review this section |
|------------------|---------------------|
| Q1-Q5 | Part 1-3: Cloud Basics, Deployment, Service Models |
| Q6-Q12 | Part 4: Well-Architected Framework |
| Q13-Q17 | Part 5: AWS CAF |
| Q18-Q20 | Part 6: 7 Rs of Migration |
