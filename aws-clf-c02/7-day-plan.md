# 🚀 AWS CLF-C02 Study Plan

**🎯 Exam Date:** February 12, 2026  
**📅 Study Period:** February 3-11 (9 days available)  
**⏱️ Exam:** 65 questions, 90 minutes, 700/1000 passing score  
**🎲 Strategy:** Theory-focused, domain-weighted, quiz-heavy  
**🏆 Target Score:** 85%+ on practice tests before exam

---

## ⚡ Prerequisites (Who Is This Plan For?)

> [!CAUTION]
> This 9-day intensive plan requires **6-8 hours/day** of dedicated study time.

**This plan is designed for:**
- ✅ IT professionals with basic cloud or infrastructure exposure
- ✅ Developers familiar with AWS console
- ✅ Those who can commit 6-8 hours daily for 9 consecutive days

**Not recommended (consider 14-day plan instead):**
- ⚠️ Complete beginners to cloud computing
- ⚠️ Those with < 4 hours/day available
- ⚠️ Those unfamiliar with basic networking concepts (IP, DNS, firewalls)

---

## 🎯 Best Practices (Research-Backed)

> [!IMPORTANT]
> **Key Success Factors from 1000+ Reddit Users & Experts:**
> - Score **85%+ consistently** on practice tests before taking real exam
> - Use **Tutorials Dojo** practice exams (closest to real exam)
> - Master **AWS CAF 6 Perspectives** (frequently tested!)
> - Focus on **understanding concepts**, not memorizing
> - Take **AWS Skill Builder** official practice questions

---

## 📊 Domain Weight Strategy

| Domain | Weight | Questions | Study Time | Priority |
|--------|--------|-----------|------------|----------|
| **D3: Technology & Services** | 34% | ~22 | 2.5 days | 🔴 HIGH |
| **D2: Security & Compliance** | 30% | ~20 | 2 days | 🔴 HIGH |
| **D1: Cloud Concepts** | 24% | ~16 | 1 day | 🟡 MEDIUM |
| **D4: Billing & Support** | 12% | ~8 | 0.5 day | 🟢 LOWER |
| **Practice & Review** | - | - | 3 days (Days 7-9) | 🔴 CRITICAL |

---

## ⚠️ Common Mistakes to Avoid

1. ❌ **Relying only on video** - Do hands-on labs if time permits
2. ❌ **Using exam dumps** - AWS changes questions; understanding > memorization
3. ❌ **Ignoring CAF & Well-Architected** - These appear frequently!
4. ❌ **Skipping practice tests** - They reveal your weak areas
5. ❌ **Not reading questions carefully** - Watch for "MOST", "LEAST", "NOT"
6. ❌ **Underestimating pricing/billing** - Easy points if you study

---

## 🔄 Daily Review Routine (Spaced Repetition)

> [!TIP]
> **Spaced repetition boosts retention by 50%+.** Follow this routine daily.

**Each Morning (15 min):**
- [ ] Review flashcards from 2 days ago
- [ ] Self-test on 5 random services (what does it do?)
- [ ] Recite CAF perspectives and Well-Architected pillars

**Each Evening (15 min):**
- [ ] Create 5 new flashcards from today's study
- [ ] Write 1-sentence summaries of 3 key concepts
- [ ] Quiz yourself on today's "Must-Know" items

---

## 📅 Day-by-Day Schedule

### Day 1: Cloud Concepts Foundation (Domain 1: 24%)
**Goal:** Master cloud fundamentals + AWS Well-Architected Framework + CAF

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (2hr)** | Cloud Computing Basics | Section 3 (7-13) | 6 advantages, IaaS/PaaS/SaaS, deployment models |
| **PM (3hr)** | Well-Architected & CAF | Section 21 (258-272) | 6 pillars, 6 CAF perspectives |
| **Eve (2hr)** | Quiz + Review | Quiz 1, Quiz 20 | Migration 7Rs, rightsizing |

**Must-Know for Day 1:**
- [ ] **6 Advantages of Cloud Computing:**
  1. Trade CapEx for OpEx
  2. Benefit from economies of scale
  3. Stop guessing capacity
  4. Increase speed and agility
  5. Stop spending money on data centers
  6. Go global in minutes
- [ ] **5 Characteristics of Cloud:** On-demand, broad network access, resource pooling, rapid elasticity, measured service
- [ ] **3 Deployment Models:** Public, Private, Hybrid
- [ ] **3 Service Models with Examples:**
  - IaaS: EC2, EBS
  - PaaS: Elastic Beanstalk, RDS
  - SaaS: Gmail, Dropbox, Salesforce
- [ ] **6 Pillars of Well-Architected Framework:**
  1. Operational Excellence
  2. Security
  3. Reliability
  4. Performance Efficiency
  5. Cost Optimization
  6. Sustainability
- [ ] **AWS CAF 6 Perspectives (CRITICAL - FREQUENTLY TESTED):**
  | Perspective | Focus | Key Stakeholders |
  |-------------|-------|------------------|
  | **Business** | Digital transformation, ROI | CEO, CFO, CIO |
  | **People** | Culture, skills, leadership | CIO, HR, Cloud Director |
  | **Governance** | Risk, compliance, benefits | CFO, CDO, CRO |
  | **Platform** | Architecture, modernization | CTO, Architects |
  | **Security** | Confidentiality, integrity | CISO, CCO |
  | **Operations** | Service delivery, SRE | SRE, IT managers |
- [ ] **Migration 7Rs:** Rehost, Replatform, Repurchase, Refactor, Retire, Retain, Relocate

**Slides Focus:** Pages 1-50 (Cloud Computing basics)

---

### Day 2: IAM & Security Deep Dive (Domain 2: 30% - Part 1)
**Goal:** Master IAM, Shared Responsibility, Access Management

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (3hr)** | IAM Core | Section 4 (14-33) | Users, Groups, Roles, Policies, MFA |
| **PM (2hr)** | Shared Responsibility | Section 16 (182-201) | Who secures what |
| **Eve (2hr)** | Quiz + Review | Quiz 2, Quiz 14 | Root user, least privilege |

**Must-Know for Day 2:**
- [ ] **Shared Responsibility Model (CRITICAL):**
  | AWS Responsibility | Customer Responsibility |
  |-------------------|------------------------|
  | Physical security | IAM users/roles |
  | Hardware/network | Security groups |
  | Hypervisor | OS patching (EC2) |
  | Managed services | Application security |
  | Global infrastructure | Client-side encryption |
  
- [ ] **Shifts by Service Type:**
  - EC2: Customer manages more (OS, patching)
  - RDS: AWS manages more (patching, backups)
  - Lambda: AWS manages almost everything

- [ ] **IAM Components:**
  - Users: individual identity
  - Groups: collection of users
  - Roles: temporary credentials for services
  - Policies: JSON documents defining permissions

- [ ] **Root User Tasks (ONLY root can do):**
  - Change account settings
  - Close AWS account
  - Change/restore root password
  - Create CloudFront key pairs
  - Change AWS Support plan

- [ ] **MFA Types:** Virtual MFA, U2F key, Hardware Key Fob
- [ ] **Access Keys:** For CLI/SDK programmatic access
- [ ] **IAM Identity Center:** Single sign-on for Organizations
- [ ] **Principle of Least Privilege:** Give minimum permissions needed

**Slides Focus:** IAM Section, Security & Compliance Section

---

### Day 3: Security Services + VPC (Domain 2: 30% - Part 2)
**Goal:** Master security services and VPC networking basics

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (3hr)** | Security Services | Section 16 (183-201) | WAF, Shield, KMS, GuardDuty |
| **PM (2hr)** | VPC & Networking | Section 15 (170-181) | VPC, Subnets, Gateways |
| **Eve (2hr)** | Quiz + Review | Quiz 13, Quiz 14 | NACLs vs SG |

**Must-Know for Day 3:**

**Security Services Cheat Sheet:**
| Service | What It Does | Key Point |
|---------|-------------|-----------|
| **WAF** | Web app firewall | L7, SQL injection, XSS |
| **Shield** | DDoS protection | Standard=free, Advanced=paid |
| **GuardDuty** | Threat detection | ML-based, analyzes logs |
| **Inspector** | Vulnerability scan | EC2/containers |
| **Macie** | Data discovery | S3 PII detection |
| **KMS** | Key management | AWS-managed keys |
| **CloudHSM** | Hardware keys | Customer-managed |
| **Secrets Manager** | Secret storage | Auto-rotate passwords |
| **Config** | Compliance audit | Track resource changes |
| **CloudTrail** | API logging | Who did what |
| **Security Hub** | Central view | Aggregate findings |
| **Artifact** | Compliance docs | Get AWS certifications |

**VPC Components:**
- [ ] **VPC:** Virtual network in AWS
- [ ] **Subnets:** Public (has IGW route) vs Private
- [ ] **Internet Gateway (IGW):** Connect VPC to internet
- [ ] **NAT Gateway:** Allow private subnet outbound internet
- [ ] **Transit Gateway:** Connect multiple VPCs and on-premises networks (hub-and-spoke)
- [ ] **Security Groups vs NACLs:**
  | Feature | Security Groups | NACLs |
  |---------|-----------------|-------|
  | Level | Instance | Subnet |
  | State | Stateful | Stateless |
  | Rules | Allow only | Allow & Deny |
  | Default | Deny all in | Allow all |
  
- [ ] **VPC Endpoints:** Private access to AWS services (no internet)
- [ ] **VPN:** Encrypted tunnel over internet
- [ ] **Direct Connect:** Dedicated private connection

**Additional Security Services (FREQUENTLY TESTED):**
- [ ] **Cognito:** User authentication, identity pools, user pools, social sign-in
- [ ] **Detective:** Investigate security findings using graph analysis

**Slides Focus:** Security & Compliance Section, VPC Section

---

### Day 4: Compute & Storage (Domain 3: 34% - Part 1)
**Goal:** Master EC2, EBS, S3, and storage services

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (2hr)** | EC2 Fundamentals | Section 5 (34-49) | Instance types, pricing |
| **PM (3hr)** | Storage Services | Section 6 (50-63), Section 8 (72-92) | S3, EBS, EFS |
| **Eve (2hr)** | Quiz + Review | Quiz 3, Quiz 4, Quiz 6 | Storage selection |

**Must-Know for Day 4:**

**EC2 Instance Families:**
| Family | Type | Use Case |
|--------|------|----------|
| T, M | General | Web servers, small DBs |
| C | Compute | Scientific, gaming |
| R, X | Memory | In-memory DBs, caching |
| I, D, H | Storage | Data warehousing |
| P, G | Accelerated | ML, graphics |

**EC2 Pricing (CRITICAL - EXAM LOVES THIS):**
| Option | Commitment | Discount | Use Case |
|--------|------------|----------|----------|
| On-Demand | None | 0% | Unpredictable workloads |
| Reserved | 1-3 years | Up to 72% | Steady-state |
| Savings Plans | 1-3 years | Up to 72% | Flexible |
| Spot | None | Up to 90% | Fault-tolerant, flexible |
| Dedicated Host | None/Reserved | Varies | Compliance, licensing |

**Storage Comparison:**
| Storage | Type | Scope | Use Case |
|---------|------|-------|----------|
| **EBS** | Block | AZ | Boot volumes, databases |
| **Instance Store** | Block | Instance | Temp buffers, cache |
| **EFS** | File | Region | Linux shared storage |
| **FSx Windows** | File | Region | Windows shares |
| **FSx Lustre** | File | Region | HPC, ML |
| **S3** | Object | Region | Backups, data lake |

**S3 Storage Classes (EXAM FAVORITE):**
| Class | Access | Durability | Min Storage |
|-------|--------|------------|-------------|
| Standard | Frequent | 99.999999999% | None |
| Intelligent-Tiering | Unknown | 99.999999999% | None |
| Standard-IA | Infrequent | 99.999999999% | 30 days |
| One Zone-IA | Infrequent | 99.999999999% | 30 days |
| Glacier Instant | Rare | 99.999999999% | 90 days |
| Glacier Flexible | Archive | 99.999999999% | 90 days |
| Glacier Deep Archive | Long-term | 99.999999999% | 180 days |

**S3 Features:**
- [ ] Versioning: protect from accidental delete
- [ ] Replication: CRR (cross-region), SRR (same-region)
- [ ] Lifecycle policies: auto-transition classes
- [ ] Encryption: SSE-S3, SSE-KMS, SSE-C

**Slides Focus:** EC2 Section, EC2 Instance Storage Section, Amazon S3 Section

---

### Day 5: Databases, Serverless, Global Infra (Domain 3: 34% - Part 2)
**Goal:** Master databases, Lambda, containers, global services

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (2hr)** | Databases | Section 9 (93-111) | RDS, Aurora, DynamoDB |
| **PM (2hr)** | Serverless & Containers | Section 10 (112-122) | Lambda, ECS, Fargate |
| **PM2 (2hr)** | Global Infrastructure | Section 12 (137-148) | Route 53, CloudFront |
| **Eve (1hr)** | Quiz + Review | Quiz 7, Quiz 8, Quiz 10 | Service selection |

**Must-Know for Day 5:**

**Database Selection Guide:**
| Need | Service | Key Point |
|------|---------|-----------|
| Relational, managed | **RDS** | MySQL, PostgreSQL, MariaDB, Oracle, SQL Server |
| Relational, high perf | **Aurora** | 5x MySQL, 3x PostgreSQL, auto-scaling |
| NoSQL key-value | **DynamoDB** | Serverless, single-digit ms |
| In-memory | **ElastiCache** | Redis, Memcached |
| Data warehouse | **Redshift** | OLAP, columnar, petabyte-scale |
| Document | **DocumentDB** | MongoDB compatible |
| Graph | **Neptune** | Social networks, fraud detection |
| Time-series | **Timestream** | IoT, DevOps metrics |
| Ledger | **QLDB** | Immutable, cryptographic |

**Migration Tools:**
- **DMS:** Database Migration Service
- **SCT:** Schema Conversion Tool

**Serverless & Containers:**
| Service | What | Key Point |
|---------|------|-----------|
| **Lambda** | Serverless compute | 15 min max, pay per invocation |
| **ECS** | Container orchestration | Docker on EC2 |
| **Fargate** | Serverless containers | No EC2 to manage |
| **EKS** | Managed Kubernetes | Enterprise container orchestration |
| **ECR** | Container registry | Store Docker images |
| **Lightsail** | Simple VPS | Fixed pricing, easy setup |
| **Batch** | Batch jobs | Large-scale batch computing |

**Global Infrastructure:**
| Component | Definition | Count |
|-----------|------------|-------|
| Regions | Geographic areas | 33+ |
| Availability Zones | Isolated data centers | 3+ per region |
| Edge Locations | CloudFront cache | 450+ |
| Local Zones | Low latency extensions | 30+ |

**Global Services:**
| Service | Purpose |
|---------|---------|
| **Route 53** | DNS, domain registration |
| **CloudFront** | CDN, edge caching |
| **Global Accelerator** | Optimized network routing |
| **S3 Transfer Acceleration** | Fast S3 uploads |

**Slides Focus:** Databases Section, Other Compute Section, Global Infrastructure Section

---

### Day 6: Integration, Monitoring, Billing (Domain 3 + 4)
**Goal:** Complete Domain 3, master Billing & Support (Domain 4: 12%)

**Study Hours:** 6-8 hours

| Time | Topic | Course Sections | Key Concepts |
|------|-------|-----------------|--------------|
| **AM (2hr)** | Integration & Monitoring | Section 13-14 (149-169) | SQS, SNS, CloudWatch |
| **PM (2hr)** | Deployment Services | Section 11 (123-136) | CloudFormation, Beanstalk |
| **PM2 (2hr)** | Billing & Support | Section 18 (213-232) | Pricing, Support plans |
| **Eve (1hr)** | Quiz + Review | Quiz 9, 11, 12, 16, 17 | Cost optimization |

**Must-Know for Day 6:**

**Integration Services:**
| Service | Pattern | Key Point |
|---------|---------|-----------|
| **SQS** | Queue | Decouple, async, FIFO/Standard |
| **SNS** | Pub/Sub | Push notifications, fan-out |
| **EventBridge** | Event bus | Serverless events |
| **Kinesis** | Streaming | Real-time data |
| **MQ** | Message broker | ActiveMQ, RabbitMQ |
| **Step Functions** | Orchestration | Visual workflows |
| **API Gateway** | REST/WebSocket APIs | Serverless endpoints, throttling, auth |

**Monitoring Services:**
| Service | Purpose |
|---------|---------|
| **CloudWatch** | Metrics, Alarms, Logs, Dashboards |
| **CloudTrail** | API audit logging |
| **X-Ray** | Distributed tracing |
| **Health Dashboard** | AWS service status |
| **Trusted Advisor** | Best practice recommendations |

**Deployment Services:**
| Service | Type |
|---------|------|
| **CloudFormation** | IaC (JSON/YAML) |
| **CDK** | IaC with programming languages |
| **Elastic Beanstalk** | PaaS for web apps |
| **CodePipeline** | CI/CD orchestration |
| **CodeBuild** | Build service |
| **CodeDeploy** | Deployment automation |
| **CodeCommit** | Git repos (deprecated) |

**Billing & Pricing (DOMAIN 4 - Easy Points):**

**Pricing Models:**
| Model | Description |
|-------|-------------|
| Pay-as-you-go | Pay for what you use |
| Save when you reserve | Commit for discounts |
| Pay less using more | Volume discounts |

**Cost Management Tools:**
| Tool | Purpose |
|------|---------|
| **Pricing Calculator** | Estimate costs |
| **Budgets** | Set spending alerts |
| **Cost Explorer** | Analyze past spending |
| **Cost & Usage Report** | Detailed billing data |
| **Cost Anomaly Detection** | ML-based alerts |

**Support Plans (EXAM LOVES THIS):**
| Plan | Price | Response | Features |
|------|-------|----------|----------|
| **Basic** | Free | None | Documentation, forums |
| **Developer** | $29/mo | 12-24hr | 1 primary contact, email |
| **Business** | $100/mo+ | 1hr urgent | Unlimited contacts, phone, Trusted Advisor |
| **Enterprise On-Ramp** | $5,500/mo | 30min critical | Pool of TAMs |
| **Enterprise** | $15,000/mo | 15min critical | Dedicated TAM |

**Organizations:**
- Consolidated billing
- Volume discounts across accounts
- SCPs (Service Control Policies)

**Slides Focus:** Cloud Integration Section, Monitoring Section, Support Section

---

### Day 7: Practice Test #1 (Feb 9 - Sunday)
**Goal:** First full practice exam + identify weak areas

**Study Hours:** 6-8 hours

| Time | Activity | Resource |
|------|----------|----------|
| **9-11 AM** | Practice Test #1 | Course Practice Test (Section 22) |
| **11-12** | Review ALL Wrong Answers | Note weak topics |
| **1-3 PM** | Study Weak Areas | Slides + course sections |
| **3-5 PM** | ML Services Overview | Section 17 |
| **Eve** | Flashcard Review | Today's weak topics |

**ML Services Quick Reference (Know what each does):**
| Service | Purpose |
|---------|---------|
| **Rekognition** | Image/video analysis |
| **Transcribe** | Speech-to-text |
| **Polly** | Text-to-speech |
| **Translate** | Language translation |
| **Lex** | Chatbots (Alexa) |
| **Comprehend** | NLP, sentiment |
| **SageMaker** | Build/train ML |
| **Kendra** | Intelligent search |
| **Personalize** | Recommendations |
| **Textract** | OCR, document extraction |
| **Amazon Q** | Generative AI assistant for business (NEW) |

**Other Important Services:**
| Service | Purpose |
|---------|---------|
| **Trusted Advisor** | 5 categories of recommendations |
| **Organizations** | Multi-account management |
| **Control Tower** | Landing zone setup |
| **Well-Architected Tool** | Workload review |
| **Compute Optimizer** | Right-sizing recommendations |
| **AWS Outposts** | Run AWS services on-premises (hybrid cloud) |
| **WorkSpaces** | Virtual desktop infrastructure (VDI) |
| **Connect** | Cloud contact center service |
| **Storage Gateway** | Hybrid storage with on-prem caching |

---

### Day 8: Practice Test #2 + Weak Areas (Feb 10 - Monday)
**Goal:** Second practice exam, target 85%+

**Study Hours:** 6-8 hours

| Time | Activity | Resource |
|------|----------|----------|
| **9-11 AM** | Practice Test #2 | Tutorials Dojo or AWS Skill Builder |
| **11-12** | Review Wrong Answers | Compare with Day 7 weak areas |
| **1-3 PM** | Focus on Persistent Weak Areas | Deep dive on topics missed twice |
| **3-4 PM** | Quick Reference Tables Review | All cheat sheets in this plan |
| **Eve** | Flashcard Review | All remaining cards |

**Weak Area Action Plan:**

| If Weak In... | Review These |
|---------------|--------------|
| D1: Cloud Concepts | CAF 6 perspectives, Well-Architected 6 pillars, 6 cloud advantages |
| D2: Security | Shared Responsibility Model, IAM, Security Groups vs NACLs |
| D3: Technology | EC2 pricing, S3 storage classes, Database selection guide |
| D4: Billing | Support plans table, Cost management tools |

> [!TIP]
> If scoring < 80%, focus on your **3 weakest domains** before moving on.

---

### Day 9: Final Review (Feb 11 - Tuesday)
**Goal:** Light review, confidence building, rest

**Study Hours:** 3-4 hours (light day intentionally)

| Time | Activity | Resource |
|------|----------|----------|
| **Morning** | CAF Perspectives Review | 15 min refresher |
| **Morning** | Shared Responsibility Model | Quick review |
| **Afternoon** | Cheat Sheets Only | No new material! |
| **Evening** | Prepare for Exam Day | ID, appointment confirmation |
| **Night** | Early sleep (7+ hours) | Rest is critical! |

> [!WARNING]
> **Do NOT cram new material today!** Trust your preparation.

---

## 🎯 Quick Reference Tables

### Storage Comparison
| Type | Service | Use Case |
|------|---------|----------|
| Block | EBS | Boot volume, databases |
| Block | Instance Store | Temp cache, buffer |
| File | EFS | Linux shared storage |
| File | FSx | Windows/HPC |
| Object | S3 | Media, backups, data lake |

### Database Comparison
| Need | Service |
|------|---------|
| Relational, managed | RDS |
| Relational, high perf | Aurora |
| NoSQL key-value | DynamoDB |
| In-memory cache | ElastiCache |
| Data warehouse | Redshift |
| Graph | Neptune |
| Time-series | Timestream |

### Security Service Comparison
| Service | Purpose |
|---------|---------|
| WAF | Web app firewall (L7) |
| Shield | DDoS protection |
| GuardDuty | Threat detection |
| Inspector | Vulnerability scan |
| Macie | S3 data discovery |
| Config | Compliance tracking |
| CloudTrail | API logging |

### Support Plans Quick Check
| Plan | Best Feature | Response |
|------|--------------|----------|
| Basic | Free, docs | None |
| Developer | Email support | 12-24hr |
| Business | Phone, Trusted Advisor | 1hr |
| Enterprise | TAM, reviews | 15min |

---

## ✅ Exam Day Preparation

### Night Before (Day 6 Evening)
- [ ] **Light review only** - Don't cram new material
- [ ] **Review cheat sheets** - Quick reference tables only
- [ ] **Prepare ID** - Government-issued photo ID ready
- [ ] **Check appointment** - Confirm time, location, or Pearson VUE link
- [ ] **Get 7+ hours sleep** - Rest is crucial for recall

### Morning Of
- [ ] **Light breakfast** - Avoid heavy food, stay hydrated
- [ ] **Review CAF perspectives** - 5 min refresher
- [ ] **Review Shared Responsibility Model** - Quick glance
- [ ] **Arrive 15-30 min early** - For check-in procedures
- [ ] **Use restroom before** - 90 min is a long exam

### During Exam Strategy
| Step | Strategy |
|------|----------|
| 1 | **Read question TWICE** before looking at answers |
| 2 | **Identify keywords:** "MOST", "LEAST", "NOT", "FIRST" |
| 3 | **Eliminate 2 obviously wrong** answers |
| 4 | **Flag difficult questions** - Don't spend > 2 min |
| 5 | **Answer ALL questions** - No penalty for guessing |
| 6 | **Trust first instinct** - Don't overthink |
| 7 | **Review flagged** - Use remaining time wisely |

### Time Management
- **Total:** 90 minutes for 65 questions
- **Per question:** ~80 seconds average
- **Flag threshold:** If > 2 min, flag and move on
- **Reserve:** Keep 10-15 min for review

---

## 📚 Recommended Resources

### Free Resources
- [x] AWS Skill Builder - Cloud Practitioner Essentials (7 hours)
- [x] AWS Official Practice Questions
- [ ] AWS Documentation
- [ ] Stephane Maarek Course

### Paid Resources (Highly Recommended)
- [ ] **Tutorials Dojo Practice Exams** - Closest to real exam
- [ ] Stephane Maarek Udemy Course

### Scoring Target
| Practice Test Score | Ready? |
|--------------------|--------|
| <70% | ❌ Keep studying |
| 70-79% | ⚠️ Borderline |
| 80-84% | 🟡 Probably ready |
| 85%+ | ✅ Take the exam! |

---

## 📊 Progress Tracker

| Day | Date | Focus | Quizzes | Target | Status |
|-----|------|-------|---------|--------|--------|
| 1 | **Feb 3 (Mon)** | Cloud Concepts, CAF, Well-Architected | Q1, Q20 | Understand fundamentals | ⬜ |
| 2 | **Feb 4 (Tue)** | IAM, Shared Responsibility | Q2, Q14 | Master security model | ⬜ |
| 3 | **Feb 5 (Wed)** | Security Services, VPC | Q13, Q14 | Know every service | ⬜ |
| 4 | **Feb 6 (Thu)** | EC2, Storage, S3 | Q3, Q4, Q6 | Pricing & storage classes | ⬜ |
| 5 | **Feb 7 (Fri)** | Databases, Serverless, Global | Q7, Q8, Q10 | Service selection | ⬜ |
| 6 | **Feb 8 (Sat)** | Integration, Monitoring, Billing | Q9, Q11, Q12, Q16, Q17 | Support plans | ⬜ |
| 7 | **Feb 9 (Sun)** | Practice Test #1 + Review | Practice Test | Score 80%+ | ⬜ |
| 8 | **Feb 10 (Mon)** | Practice Test #2 + Weak Areas | Tutorials Dojo | Score 85%+ | ⬜ |
| 9 | **Feb 11 (Tue)** | Final Review + Light Practice | Cheat sheets only | Confidence check | ⬜ |
| 🎯 | **Feb 12 (Wed)** | **EXAM DAY** | - | Pass with 700+ | 🎯 |

**Legend:** ⬜ Not started | 🟡 In progress | ✅ Complete

---

## 🏆 You've Got This!

> **Remember:** The CLF-C02 is designed to validate foundational knowledge. Focus on understanding WHAT each service does and WHEN to use it, not HOW to configure it. Trust your preparation!
