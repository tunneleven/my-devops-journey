# Day 1: Cloud Concepts Foundation

**Domain 1: Cloud Concepts (24% of exam)**  
**Study Time:** 6-8 hours  

### 🎯 Learning Goals

By the end of Day 1, you will be able to:

1. **Explain** the 6 advantages of cloud computing and their business impact
2. **Distinguish** between Public, Private, and Hybrid cloud deployment models
3. **Choose** the appropriate service model (IaaS, PaaS, SaaS) for given scenarios
4. **Apply** the 6 Well-Architected Framework pillars to evaluate architectures
5. **Map** the 6 AWS CAF perspectives to stakeholder groups
6. **Select** the right migration strategy (7 Rs) based on requirements

---

## 📋 Services You'll Meet Today

> These services appear in examples. Full explanations come later!

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **EC2** | Virtual servers | Day 4 |
| **RDS** | Managed databases | Day 5 |
| **Lambda** | Serverless functions | Day 5 |
| **S3** | Object storage | Day 4 |
| **CloudFront** | Content delivery network | Day 4 |
| **CloudFormation** | Infrastructure as Code | Day 6 |
| **CloudWatch** | Monitoring & alarms | Day 6 |

📖 **Quick Reference:** [AWS Glossary](../notes/glossary.md)

---

## 📖 How to Use This Resource

1. **Read** each section thoroughly (don't skim!)
2. **Understand** concepts using the explanations and analogies
3. **Use mnemonics** as memory aids (not replacements for understanding)
4. **Test yourself** with the self-check questions at the end
5. **Create flashcards** for items marked with 🔥

> [!TIP]
> **Focus on understanding WHY**, not just WHAT. The exam tests your ability to apply concepts to scenarios.

## 🌩️ Part 1: What is Cloud Computing?

### Definition
> **Cloud computing** is the on-demand delivery of IT resources over the internet with pay-as-you-go pricing.

Instead of buying physical servers, you "rent" computing power from AWS and pay only for what you use—like electricity.

### 🔥 The 6 Advantages of Cloud Computing

**Mnemonic: "TIGERS"** 🐯
- **T**rade CapEx for OpEx
- **I**ncrease speed and agility
- **G**o global in minutes
- **E**conomies of scale
- **R**educe guessing capacity
- **S**top spending on data centers

| Advantage | What It Means | Real-World Example |
|-----------|---------------|-------------------|
| **Trade CapEx for OpEx** | No upfront costs, pay monthly | Instead of buying a $10K server, pay $100/month |
| **Economies of scale** | AWS buys millions of servers, passes savings to you | Your per-hour cost is cheaper than running your own |
| **Stop guessing capacity** | Scale up/down automatically | Black Friday traffic? Auto-scale handles it |
| **Increase speed and agility** | Deploy in minutes, not months | New server in 2 minutes vs. 2 months procurement |
| **Stop spending on data centers** | No cooling, security guards, real estate | Focus on code, not cables |
| **Go global in minutes** | Deploy worldwide with a few clicks | Launch in Tokyo, Sydney, and London same day |

### 💡 Why These 6 Advantages Matter

These aren't just marketing points—they're the **core value propositions** that drive cloud adoption decisions:

- **Business case:** When a CTO asks "Why should we move to cloud?", these are the answers
- **Exam context:** Questions often describe a scenario and ask which advantage applies
- **Real decisions:** Companies trade CapEx for OpEx to improve cash flow, not just to use cloud

> [!IMPORTANT]
> **Understand the business impact**, not just the technical definition. Ask yourself: "How would this help a real company?"

### ☁️ 5 Characteristics of Cloud Computing (NIST Definition)

**Mnemonic: "On-Broad-Pool-Elastic-Measured"** (think: Swimming pool with elastic band being measured)

| Characteristic | Meaning | Example |
|----------------|---------|---------|
| **On-demand self-service** | Get resources without human interaction | Launch EC2 via console at 3 AM |
| **Broad network access** | Access from anywhere via internet | Work from laptop, phone, tablet |
| **Resource pooling** | Share resources among multiple customers | Your server neighbors are unknown to you |
| **Rapid elasticity** | Scale up/down instantly | Add 100 servers for sale, remove after |
| **Measured service** | Pay only for what you use | Metered like electricity bill |

### 📌 Quick Summary: Cloud Computing Basics

- **Cloud computing** = On-demand IT resources over internet, pay-as-you-go
- **6 Advantages (TIGERS):** Trade CapEx, Increase speed, Go global, Economies, Reduce guessing, Stop spending
- **5 Characteristics:** On-demand, Broad access, Pooling, Elasticity, Measured
- Key mindset: Think about **business value**, not just technology

---

## 🏗️ Part 2: Cloud Deployment Models

**Mnemonic: "PHP"** (like the programming language)
- **P**rivate
- **H**ybrid
- **P**ublic

### The 3 Deployment Models

| Model | Where Resources Live | Who Controls It | Best For |
|-------|---------------------|-----------------|----------|
| **Public Cloud** | AWS data centers | AWS | Startups, web apps, variable workloads |
| **Private Cloud** | Your own data center | You | Banks, government, strict compliance |
| **Hybrid Cloud** | Both public + private | Shared | Legacy apps + cloud expansion |

### Visual Memory Aid

```
┌─────────────────────────────────────────────────────┐
│                    CLOUD MODELS                      │
├─────────────────────────────────────────────────────┤
│                                                      │
│  🏢 PRIVATE          ☁️ PUBLIC           🔀 HYBRID   │
│  ─────────          ────────           ─────────    │
│  Your building      AWS building       Both!        │
│  Your guards        AWS guards                      │
│  Your rules         AWS rules                       │
│                                                      │
│  Examples:          Examples:          Examples:    │
│  - VMware           - AWS              - Outposts   │
│  - OpenStack        - Azure            - On-prem +  │
│                     - GCP                AWS        │
└─────────────────────────────────────────────────────┘
```

### 📌 Quick Summary: Deployment Models

- **Public Cloud:** AWS manages everything, you rent resources (most common)
- **Private Cloud:** You own/control everything, on-premises
- **Hybrid Cloud:** Mix of both, good for regulated industries
- Exam tip: "Regulatory requirements" often points to Hybrid or Private

---

## 📦 Part 3: Cloud Service Models (IaaS, PaaS, SaaS)

**Mnemonic: "Pizza as a Service"** 🍕

Think of ordering pizza:
- **IaaS** = You buy ingredients, make dough, bake it yourself
- **PaaS** = You get pre-made dough, add toppings, bake it
- **SaaS** = Pizza delivered ready-to-eat

### The 3 Service Models

| Model | What You Manage | What AWS Manages | AWS Examples |
|-------|-----------------|------------------|--------------|
| **IaaS** (Infrastructure) | OS, Apps, Data | Hardware, Network, Virtualization | EC2, EBS |
| **PaaS** (Platform) | Apps, Data only | Everything else | Elastic Beanstalk, RDS |
| **SaaS** (Software) | Just use it! | Everything | (Gmail, Salesforce - not AWS) |

### 💡 When to Choose Each Model

| Scenario | Best Choice | Why |
|----------|-------------|-----|
| Need full control over OS and security | **IaaS** | You manage everything from OS up |
| Want to focus only on app code | **PaaS** | AWS handles infrastructure |
| Need a ready-to-use application | **SaaS** | Just use it, no development needed |
| Strict compliance requirements | **IaaS** | Maximum control for auditing |
| Rapid prototyping | **PaaS** | Deploy fast, iterate quickly |

### Visual: Responsibility Stack

```
         YOU MANAGE ↑         AWS MANAGES ↑
        ─────────────────────────────────────
        
IaaS:   [App][Data][OS][---][---][---][---]
                        ↑ AWS handles below
                        
PaaS:   [App][Data][---][---][---][---][---]
                   ↑ AWS handles even more

SaaS:   [---][---][---][---][---][---][---]
        ↑ AWS handles EVERYTHING
```

### 🔥 Exam Tip: Know These Examples!

| Model | AWS Service | Why It Fits |
|-------|-------------|-------------|
| **IaaS** | EC2 | You manage the OS and apps |
| **IaaS** | EBS | Raw block storage you attach |
| **PaaS** | Elastic Beanstalk | Upload code, AWS handles rest |
| **PaaS** | RDS | Managed database, no OS access |
| **PaaS** | Lambda | Just upload code, no servers |

### 📌 Quick Summary: Service Models

- **IaaS (EC2):** You manage OS, apps, data — most control
- **PaaS (RDS, Beanstalk):** You manage apps/data only — less work
- **SaaS:** Ready-to-use — no management
- Remember: More control = More responsibility

---

## 🏛️ Part 4: AWS Well-Architected Framework (6 Pillars)

### What Is It?
A set of **best practices** to help you build secure, high-performing, resilient, and efficient infrastructure.

**Mnemonic (pick one that works for you):**
- **"OSRPCS"** = **O**perational, **S**ecurity, **R**eliability, **P**erformance, **C**ost, **S**ustainability
- Or the story: **"Old Security Robots Perform Cost-effective Sustainably"**

### 💡 How the 6 Pillars Connect

The pillars aren't isolated—they **trade off against each other**:

```
                    ┌─────────────────┐
                    │   SECURITY 🔒   │
                    └────────┬────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │                   │                   │
         ▼                   ▼                   ▼
  ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
  │ RELIABILITY  │◄─►│ PERFORMANCE  │◄─►│    COST      │
  │     🛡️        │   │      ⚡       │   │     💰       │
  └──────────────┘   └──────────────┘   └──────────────┘
         │                   │                   │
         └───────────────────┼───────────────────┘
                             │
                    ┌────────▼────────┐
                    │ SUSTAINABILITY 🌱│
                    └─────────────────┘
                             │
         ┌───────────────────┴───────────────────┐
                    OPERATIONAL EXCELLENCE 🎯
            (enables all pillars through automation)
```

**Trade-off Examples:**
- More **reliability** (Multi-AZ) = higher **cost**
- Maximum **performance** = may impact **sustainability**
- Stronger **security** (encryption) = slightly lower **performance**

---

### Pillar 1: Operational Excellence 🎯

**Focus:** Run and monitor systems to deliver business value

**Key Concepts:**
- Perform operations as **code** (Infrastructure as Code)
- Make **frequent, small, reversible** changes
- Anticipate failure and **learn from operational failures**
- Refine operations procedures frequently

**AWS Services:**
| Service | How It Helps |
|---------|--------------|
| CloudFormation | Infrastructure as code |
| CloudWatch | Monitor and observe |
| AWS Config | Track configuration changes |
| CloudTrail | Log API calls |

**Exam Question Pattern:**
> "A company wants to automate infrastructure provisioning..."
> → Answer: CloudFormation (Operational Excellence)

---

### Pillar 2: Security 🔒

**Focus:** Protect information, systems, and assets

**Key Concepts:**
- Implement a **strong identity foundation** (IAM)
- Enable **traceability** (who did what)
- Apply security at **all layers**
- **Automate** security best practices
- Protect data **in transit** and **at rest**

**AWS Services:**
| Service | What It Does |
|---------|--------------|
| IAM | Identity and access management |
| KMS | Key management for encryption |
| CloudTrail | API logging (who did what) |
| GuardDuty | Threat detection |
| WAF | Web application firewall |

**Memory Tip:** Security = **CIA Triad**
- **C**onfidentiality (only authorized access)
- **I**ntegrity (data not modified)
- **A**vailability (data accessible when needed)

---

### Pillar 3: Reliability 🛡️

**Focus:** Recover from failures, meet demand

**Key Concepts:**
- **Automatically recover** from failure
- **Test recovery** procedures
- **Scale horizontally** to increase availability
- **Stop guessing capacity** (auto-scale)
- Manage change in **automation**

**AWS Services:**
| Service | How It Helps |
|---------|--------------|
| Auto Scaling | Adjust capacity automatically |
| CloudWatch | Monitor for failures |
| Multi-AZ | Redundancy across data centers |
| Route 53 | DNS failover |
| S3 | 99.999999999% durability |

**Key Metric:** 
- **RTO** (Recovery Time Objective): How fast to recover?
- **RPO** (Recovery Point Objective): How much data can you lose?

---

### Pillar 4: Performance Efficiency ⚡

**Focus:** Use resources efficiently, right-size everything

**Key Concepts:**
- **Democratize advanced technologies** (use managed services)
- Go **global in minutes**
- Use **serverless** architectures
- **Experiment** more often
- Consider **mechanical sympathy** (understand how services work)

**AWS Services:**
| Service | Why It Helps |
|---------|--------------|
| Lambda | Serverless, pay per invocation |
| CloudFront | Global edge caching |
| Auto Scaling | Right-size automatically |
| RDS Read Replicas | Distribute read load |

**Exam Tip:** If question mentions "latency" or "performance", think:
- CloudFront (CDN)
- ElastiCache (caching)
- Read Replicas (database reads)

---

### Pillar 5: Cost Optimization 💰

**Focus:** Avoid unnecessary costs, understand spending

**Key Concepts:**
- Implement **Cloud Financial Management**
- Adopt a **consumption model** (pay for what you use)
- Measure **overall efficiency**
- Stop spending money on **undifferentiated heavy lifting**
- Analyze and **attribute expenditure**

**AWS Services:**
| Service | How It Helps |
|---------|--------------|
| Cost Explorer | Visualize spending |
| AWS Budgets | Set spending alerts |
| Trusted Advisor | Cost optimization tips |
| Reserved Instances | Commit for discounts |
| Spot Instances | Use spare capacity cheap |

**Memory Aid:** "Right-size, Reserve, Spot, Shut down"
1. **Right-size** - Don't use t3.xlarge when t3.micro works
2. **Reserve** - Commit 1-3 years for discount
3. **Spot** - Use for fault-tolerant workloads
4. **Shut down** - Turn off dev/test at night

### 🔥 Rightsizing Explained

**What is it?** Matching instance size to actual workload needs.

**Why it matters:**
- Over-provisioned instances = wasted money
- Under-provisioned instances = poor performance
- AWS provides tools to recommend the right size

**AWS Rightsizing Tools:**
| Tool | What It Does |
|------|--------------|
| **AWS Compute Optimizer** | Analyzes usage, recommends optimal instance types |
| **Trusted Advisor** | Flags underutilized instances |
| **Cost Explorer** | Shows spending patterns to identify waste |

**Exam Scenario:**
> "A company's EC2 instances run at 10% CPU utilization..."
> → Answer: Use **Compute Optimizer** or **Trusted Advisor** to rightsize

---

### Pillar 6: Sustainability 🌱

**Focus:** Minimize environmental impact

**Key Concepts:**
- Understand your **impact**
- Establish **sustainability goals**
- **Maximize utilization**
- Anticipate and adopt more **efficient** offerings
- Use **managed services** (AWS optimizes hardware)

**AWS Services:**
| Service | How It Helps |
|---------|--------------|
| EC2 Auto Scaling | Only run what you need |
| Graviton | More efficient processors |
| S3 Intelligent-Tiering | Move to efficient storage |
| AWS Compute Optimizer | Right-sizing recommendations |

**Exam Tip:** Newest pillar (added 2021). Questions often ask about:
- Reducing carbon footprint
- Maximizing resource utilization
- Using efficient instance types

---

### Quick Reference: 6 Pillars Summary

| Pillar | One-Word Focus | Key Question |
|--------|---------------|--------------|
| Operational Excellence | **Automate** | "Can we do this as code?" |
| Security | **Protect** | "Who can access this?" |
| Reliability | **Recover** | "What if this fails?" |
| Performance Efficiency | **Speed** | "Is this the right size?" |
| Cost Optimization | **Save** | "Are we wasting money?" |
| Sustainability | **Green** | "Can we be more efficient?" |

### 📌 Quick Summary: Well-Architected Framework

- **6 Pillars (OSRPCS):** Operational Excellence, Security, Reliability, Performance, Cost, Sustainability
- Pillars have **trade-offs** (e.g., more security = higher cost)
- **Rightsizing** = matching instance size to actual needs
- Key tools: Well-Architected Tool, Compute Optimizer, Trusted Advisor

---

## 🗺️ Part 5: AWS Cloud Adoption Framework (CAF)

### What Is It?
A **guidance framework** to help organizations develop efficient cloud adoption plans. It organizes the cloud journey into **6 perspectives**.

### 🔥 The 6 Perspectives

**Mnemonic: "BPGPSO"**
- **B**usiness
- **P**eople
- **G**overnance
- **P**latform
- **S**ecurity
- **O**perations

**Memory Story:** "**B**ig **P**enguins **G**o **P**arty, **S**o **O**utstanding!"

### 💡 Why 6 Perspectives? (BPG vs PSO)

The CAF divides perspectives into **two groups** based on who owns them:

| Group | Perspectives | Owned By | Focus |
|-------|--------------|----------|-------|
| **BPG** (Business) | Business, People, Governance | Business stakeholders | Strategy, culture, compliance |
| **PSO** (Technical) | Platform, Security, Operations | Technical stakeholders | Architecture, security, running |

**Why this matters:**
- **Cloud adoption is not just technical** - it requires organizational change
- **Different stakeholders need different views** - CFO cares about cost, CTO cares about architecture
- **Exam will ask matching questions** - "Who is responsible for culture change?" → People perspective

---

### Perspective 1: Business 💼

**Focus:** Align cloud investments with business outcomes

**Key Stakeholders:**
- CEO (Chief Executive Officer)
- CFO (Chief Financial Officer)
- CIO (Chief Information Officer)
- COO (Chief Operations Officer)

**Key Capabilities:**
- Strategy Management
- Portfolio Management
- Innovation Management
- Product Management
- Strategic Partnership
- Data Monetization
- Business Insight

**Exam Question Example:**
> "Who should be involved in ensuring cloud investments align with business goals?"
> → Business perspective: CEO, CFO, CIO

---

### Perspective 2: People 👥

**Focus:** Bridge between technology and business, evolve culture

**Key Stakeholders:**
- CIO
- COO
- Cloud Director
- HR Leaders

**Key Capabilities:**
- Culture Evolution
- Transformational Leadership
- Cloud Fluency
- Workforce Transformation
- Change Acceleration
- Organization Design

**Memory Tip:** People = **H**uman side (HR, Culture, Skills)

---

### Perspective 3: Governance 📋

**Focus:** Orchestrate initiatives, minimize risk, maximize benefits

**Key Stakeholders:**
- CTO (Chief Technology Officer)
- CFO
- CDO (Chief Data Officer)
- CRO (Chief Risk Officer)

**Key Capabilities:**
- Program & Project Management
- Benefits Management
- Risk Management
- Cloud Financial Management
- Application Portfolio Management
- Data Governance
- Data Curation

**Memory Tip:** Governance = **R**ules and **R**isks (CRO, CFO, Compliance)

---

### Perspective 4: Platform 🏗️

**Focus:** Build enterprise-grade, scalable cloud platform

**Key Stakeholders:**
- CTO
- Technology Leaders
- Solution Architects
- Engineers

**Key Capabilities:**
- Platform Architecture
- Data Architecture
- Platform Engineering
- Data Engineering
- Provisioning & Orchestration
- Modern App Development
- CI/CD (Continuous Integration/Delivery)

**Memory Tip:** Platform = **T**echnical build (Architects, Engineers)

---

### Perspective 5: Security 🔐

**Focus:** Achieve confidentiality, integrity, availability

**Key Stakeholders:**
- CISO (Chief Information Security Officer)
- CCO (Chief Compliance Officer)
- Internal Audit Leaders
- Security Architects

**Key Capabilities:**
- Security Governance
- Security Assurance
- Identity & Access Management
- Threat Detection
- Vulnerability Management
- Infrastructure Protection
- Data Protection
- Application Security
- Incident Response

**Memory Tip:** Security = **C**ISO, **C**ompliance (CCO, CISO)

---

### Perspective 6: Operations 🔧

**Focus:** Deliver cloud services that meet business needs

**Key Stakeholders:**
- Infrastructure Leaders
- SREs (Site Reliability Engineers)
- IT Service Managers

**Key Capabilities:**
- Observability
- Event Management
- Incident & Problem Management
- Change & Release Management
- Performance & Capacity Management
- Configuration Management
- Patch Management
- Availability & Continuity
- Application Management

**Memory Tip:** Operations = **S**RE, **I**T Service (day-to-day running)

---

### Quick Reference: 6 Perspectives Summary

| Perspective | Focus | Key Stakeholders | Memory |
|-------------|-------|------------------|--------|
| **Business** | ROI, strategy | CEO, CFO, CIO | 💰 Money decisions |
| **People** | Culture, skills | HR, Cloud Director | 👥 Human resources |
| **Governance** | Risk, compliance | CFO, CDO, CRO | 📋 Rules & risks |
| **Platform** | Architecture | CTO, Architects | 🏗️ Building stuff |
| **Security** | Protection | CISO, CCO | 🔐 Keeping safe |
| **Operations** | Running systems | SRE, IT Managers | 🔧 Keeping running |

### 📌 Quick Summary: AWS CAF

- **6 Perspectives (BPGPSO):** Business, People, Governance, Platform, Security, Operations
- **BPG** = Business-focused; **PSO** = Technical-focused
- CAF helps plan and execute cloud transformation
- Each perspective has specific stakeholders and capabilities

---

## 🚀 Part 6: Cloud Migration (The 7 Rs)

### What Are They?
Seven strategies for migrating applications to the cloud.

**Mnemonic: "3 Re-'s, then RRRF"**
- **Re**host, **Re**platform, **Re**factor
- **R**epurchase, **R**etire, **R**etain, **R**elocate

Or remember: **"Really Really Rehosting Requires Retirement, Refactoring, Relocating"**

### The 7 Rs Explained

| Strategy | Also Called | What It Means | Example |
|----------|-------------|---------------|---------|
| **Rehost** | "Lift and Shift" | Move as-is to cloud | VM → EC2 with no changes |
| **Replatform** | "Lift, Tinker, Shift" | Minor optimizations | MySQL on-prem → RDS |
| **Repurchase** | "Drop and Shop" | Switch to SaaS | Custom CRM → Salesforce |
| **Refactor** | "Re-architect" | Rebuild for cloud-native | Monolith → Microservices |
| **Retire** | - | Decommission | Old unused apps → Delete |
| **Retain** | "Revisit" | Keep as-is for now | Mainframe → Stay on-prem |
| **Relocate** | "Hypervisor-level lift" | Move VMware to cloud | VMware → VMware Cloud on AWS |

### Visual: Effort vs. Benefit

```
        LOW EFFORT ←────────────────────→ HIGH EFFORT
        
        Rehost → Replatform → Refactor
          │          │           │
          ▼          ▼           ▼
        Quick      Medium     Maximum
        win       benefit     benefit
        
        Retire: Save money by deleting
        Retain: Defer decision
        Repurchase: Replace entirely
        Relocate: VMware-specific
```

### 🔥 Exam Tips for 7 Rs

| If Question Says... | Answer Is... |
|---------------------|--------------|
| "Fastest migration" | Rehost |
| "Minimal changes" | Rehost |
| "Some optimization" | Replatform |
| "Cloud-native benefits" | Refactor |
| "Already a SaaS option" | Repurchase |
| "Not needed anymore" | Retire |
| "Can't migrate yet" | Retain |
| "VMware workloads" | Relocate |

### 📌 Quick Summary: 7 Rs of Migration

- **Fastest:** Rehost (lift and shift)
- **Optimized:** Replatform (some tweaks) or Refactor (rebuild)
- **Replace:** Repurchase (switch to SaaS)
- **Stop:** Retire (delete) or Retain (defer)
- **VMware:** Relocate (hypervisor-level)

---

## 🧪 Self-Check Questions

Test yourself! Cover the answers and try to recall.

### Cloud Computing Basics

1. **Name the 6 advantages of cloud computing (TIGERS)**
   <details><summary>Answer</summary>
   Trade CapEx for OpEx, Increase speed, Go global, Economies of scale, Reduce guessing, Stop spending on data centers
   </details>

2. **What are the 3 deployment models? (PHP)**
   <details><summary>Answer</summary>
   Private, Hybrid, Public
   </details>

3. **What are IaaS, PaaS, SaaS? Give one AWS example for each.**
   <details><summary>Answer</summary>
   IaaS=EC2, PaaS=Elastic Beanstalk, SaaS=(Gmail - not AWS)
   </details>

### Well-Architected Framework

4. **Name all 6 pillars (OSRPCS)**
   <details><summary>Answer</summary>
   Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization, Sustainability
   </details>

5. **Which pillar focuses on recovering from failures?**
   <details><summary>Answer</summary>
   Reliability
   </details>

6. **Which pillar was added most recently?**
   <details><summary>Answer</summary>
   Sustainability (2021)
   </details>

### AWS CAF

7. **Name all 6 CAF perspectives (BPGPSO)**
   <details><summary>Answer</summary>
   Business, People, Governance, Platform, Security, Operations
   </details>

8. **Who are the key stakeholders for the Security perspective?**
   <details><summary>Answer</summary>
   CISO, CCO (Chief Compliance Officer), Security Architects
   </details>

9. **Which perspective focuses on culture and skills?**
   <details><summary>Answer</summary>
   People perspective
   </details>

### Migration

10. **Name the 7 Rs of migration**
    <details><summary>Answer</summary>
    Rehost, Replatform, Repurchase, Refactor, Retire, Retain, Relocate
    </details>

11. **What is "Lift and Shift"?**
    <details><summary>Answer</summary>
    Rehost - moving to cloud with no changes
    </details>

---

## 📝 Flashcard Quick Reference

Copy these for your flashcard app:

| Front | Back |
|-------|------|
| 6 Advantages of Cloud (TIGERS) | Trade CapEx, Increase speed, Go global, Economies, Reduce guessing, Stop spending |
| 5 Cloud Characteristics | On-demand, Broad access, Resource pooling, Rapid elasticity, Measured service |
| 3 Deployment Models | Public, Private, Hybrid |
| 3 Service Models | IaaS, PaaS, SaaS |
| IaaS Example | EC2, EBS |
| PaaS Example | Elastic Beanstalk, RDS, Lambda |
| 6 Well-Architected Pillars (OSRPCS) | Operational Excellence, Security, Reliability, Performance, Cost, Sustainability |
| 6 CAF Perspectives (BPGPSO) | Business, People, Governance, Platform, Security, Operations |
| 7 Rs of Migration | Rehost, Replatform, Repurchase, Refactor, Retire, Retain, Relocate |
| Lift and Shift | Rehost |
| Security perspective stakeholders | CISO, CCO |
| People perspective focus | Culture, skills, HR |

---

## 🔧 Hands-On Setup: Day 1 Practice

### Practice 1: Explore the AWS Console

**Objective:** Familiarize yourself with the AWS Management Console

**Steps:**
1. Go to [AWS Console](https://console.aws.amazon.com)
2. Sign in with your AWS account
3. Find and click on these services:
   - **EC2** (Compute) → Note: This is IaaS
   - **RDS** (Database) → Note: This is PaaS
   - **Lambda** (Compute) → Note: This is serverless/PaaS
4. Click on **Region** dropdown (top-right) → See available regions
5. Search "Well-Architected" in search bar → Open the Well-Architected Tool

**Expected Result:** You can navigate the console and understand service categories.

### Practice 2: Review Well-Architected Tool

**Objective:** Understand how AWS helps you assess architectures

**Steps:**
1. In AWS Console, search "Well-Architected Tool"
2. Click "Define workload" to see the 6 pillars
3. Browse the questions for each pillar (don't submit)
4. Notice how each question relates to the pillar's focus

**Expected Result:** You understand how the 6 pillars translate to real architectural decisions.

> [!CAUTION]
> **Free Tier Alert:** These steps stay within Free Tier. Don't launch any resources yet.

---

## 💡 Tips & Tricks

### Exam Tips

| Tip | Details |
|-----|---------|
| **TIGERS** | When asked about cloud advantages, use this mnemonic |
| **PHP** | For deployment models (Private, Hybrid, Public) |
| **"Regulatory"** | Often points to Private or Hybrid cloud |
| **"Fastest migration"** | Almost always means Rehost |
| **Pillar questions** | Match the scenario to the pillar's focus |

### Time-Saving Tricks

| Trick | Why |
|-------|-----|
| Learn mnemonics first | Faster recall during exam |
| Use AWS Console for 10 mins | Seeing services helps memory |
| Focus on "why" not "what" | Exam tests application, not definitions |

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| Confusing IaaS vs PaaS | IaaS = you manage OS; PaaS = you manage app only |
| Forgetting Sustainability pillar | It's the newest (2021), expect 1-2 questions |
| Mixing up CAF Perspectives | BPG = business; PSO = technical |
| Thinking Refactor = fastest | Rehost is fastest; Refactor gives most benefits |

---

## ✅ Day 1 Completion Checklist

Before moving to Day 2, make sure you can:

- [ ] **Explain** (not just recite) 6 advantages of cloud
- [ ] Explain Public vs Private vs Hybrid with use cases
- [ ] Choose between IaaS, PaaS, SaaS for a given scenario
- [ ] Name all 6 Well-Architected pillars and explain trade-offs
- [ ] Name all 6 CAF perspectives and match to stakeholders
- [ ] Explain all 7 Rs of migration and when to use each
- [ ] Explain what rightsizing is and why it matters
- [ ] Created 12+ flashcards from this resource

---

## 📝 Quiz Guidance

**After studying this resource, take these quizzes:**

| Quiz | Source | Focus |
|------|--------|-------|
| **Quiz 1** | Stephane Maarek Course | Cloud Concepts basics |
| **Quiz 20** | Stephane Maarek Course | Well-Architected & CAF |

**Target Score:** 80%+ before proceeding to Day 2

> [!TIP]
> If you score below 70%, review the section where you made mistakes before retaking.

---

**Next:** [Day 2 - IAM & Security Deep Dive →](day-02-iam-security.md)
