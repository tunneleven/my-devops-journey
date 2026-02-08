# Day 6: Integration, Monitoring & Billing

**Domains:** 
- Domain 3: Technology (Part 3)
- Domain 4: Billing and Pricing (12% of exam)

**Study Time:** 6-8 hours

### 🎯 Learning Goals

By the end of Day 6, you will be able to:

1. **Differentiate** between SQS (queues) and SNS (pub/sub) use cases
2. **Explain** the difference between CloudWatch (metrics) and CloudTrail (audits)
3. **Identify** Infrastructure as Code tools (CloudFormation, CDK)
4. **Choose** the right support plan (Developer vs Business vs Enterprise)
5. **Use** cost management tools (Budgets, Cost Explorer) to optimize spend
6. **Compare** deployment strategies (Beanstalk vs CloudFormation)
7. **Describe** Trusted Advisor's 5 categories and access requirements
8. **Explain** Systems Manager and Config for operations and compliance

---

## 📋 Services You'll Meet Today

> Prerequisites from Days 2-5.

| Service | What It Does | Status |
|---------|--------------|--------|
| **IAM** | Identity & access | Day 2 ✅ Required |
| **EC2** | Virtual servers | Day 4 ✅ Required |
| **S3** | Object storage | Day 4 ✅ Required |
| **Lambda** | Serverless functions | Day 5 ✅ Required |
| **RDS** | Managed databases | Day 5 ✅ Required |

📖 **Quick Reference:** [AWS Glossary](../notes/glossary.md)

---

## 📖 How to Use This Resource

1. **Master the Support Plans table** - easy points if you memorize the features/response times.
2. **Distinguish Monitoring tools** - CloudWatch vs CloudTrail is a top exam confusion point.
3. **Understand Decoupling** - SQS vs SNS scenarios are frequent.

> [!IMPORTANT]
> **Domain 4 (Billing)** is the "easiest" domain to score high in if you memorize the Support Plans and Pricing Models. Don't skip it!

---

## 🔗 Part 1: Application Integration

### Decoupling Applications
**Why decouple?** So that if one component fails, the application keeps running.

| tightly-coupled | loosely-coupled |
|-----------------|-----------------|
| Direct dependencies | Independent components |
| One failure breaks all | Failure is isolated |
| Hard to scale | Easy to scale |

---

### Amazon SQS (Simple Queue Service)

**What:** Fully managed message queue.
**Analogy:** A buffer or waiting line.

| Feature | Details | Use Case |
|---------|---------|----------|
| **Standard Queue** | Unlimited throughput, best-effort ordering | Decoupling microservices |
| **FIFO Queue** | Exact ordering, exactly-once processing | Banking transactions |
| **Retention** | Messages stored 4 days (default) to 14 days | Retry failed processing |

**Exam Pattern:**
> "Decouple a web app from a backend database..."
> → Answer: **SQS**

---

### Amazon SNS (Simple Notification Service)

**What:** Pub/Sub (Publish/Subscribe) service.
**Analogy:** A megaphone or mailing list.

**Key Features:**
- **Push-based** (sends to subscribers immediately)
- **Subscribers:** Email, SMS, Lambda, SQS, Mobile Push
- **Fan-out:** Send one message to multiple recipients

**Exam Pattern:**
> "Send email notifications to administrators when CPU is high..."
> → Answer: **SNS**

---

### SQS vs SNS (CRITICAL!)

| Feature | SQS (Queue) | SNS (Topic) |
|---------|-------------|-------------|
| **Pattern** | Poll (Pull) | Push |
| **Consumer** | One (typically) | Many (Fan-out) |
| **Persistence** | Yes (retention period) | No (fire and forget) |
| **Use Case** | Batch processing, buffering | Alerts, notifications |

---

### Amazon Kinesis

**What:** Real-time data streaming.

**Key Services:**
- **Kinesis Data Streams:** Real-time stream (managed sharding)
- **Kinesis Firehose:** Load streams into S3/Redshift (near real-time)
- **Kinesis Data Analytics:** SQL queries on streaming data

**Exam Pattern:**
> "Ingest real-time clickstream data/logs..."
> → Answer: **Kinesis**

---

### Amazon EventBridge

**What:** Serverless event bus for application integration.

**Key Features:**
- Connect applications using events
- Schedule events (cron-like)
- React to AWS service changes
- Route events to targets (Lambda, SNS, SQS)

**Exam Pattern:**
> "Trigger Lambda function on a schedule..."
> → Answer: **EventBridge** (formerly CloudWatch Events)

---

### AWS Step Functions

**What:** Orchestrate serverless workflows visually.

**Key Features:**
- **Visual workflow designer** (state machine)
- Coordinate multiple Lambda functions
- Built-in error handling and retries
- Long-running workflows (up to 1 year)

**Use Cases:**
- Order processing pipelines
- Data processing workflows
- Microservice orchestration

**Exam Pattern:**
> "Coordinate multiple Lambda functions in a specific sequence..."
> → Answer: **Step Functions**

---

### Amazon API Gateway

**What:** Create, publish, and manage REST/WebSocket APIs.

**Key Features:**
- Serverless API management
- Throttling and rate limiting
- Authentication (Cognito, IAM, Lambda authorizers)
- Caching for improved performance

**Common Architecture:**
```
Client → API Gateway → Lambda → DynamoDB
```

**Exam Pattern:**
> "Create a serverless REST API..."
> → Answer: **API Gateway + Lambda**

---

### Amazon MQ

**What:** Managed message broker for Apache ActiveMQ and RabbitMQ.

**Use When:** Migrating existing apps using traditional messaging protocols (AMQP, MQTT).

**SQS/SNS vs MQ:**
- **SQS/SNS:** Cloud-native, simpler, recommended for new apps
- **MQ:** For migrating legacy apps with existing messaging

### 📌 Quick Summary: Integration

- **SQS:** Queue (pull-based, decoupling)
- **SNS:** Pub/Sub (push-based, fan-out)
- **Kinesis:** Real-time streaming
- **EventBridge:** Event bus, scheduling
- **Step Functions:** Workflow orchestration
- **API Gateway:** REST API management
- **MQ:** Legacy message broker migration

---

## 📊 Part 2: Monitoring & Logging

### Amazon CloudWatch

**What:** Monitoring and observability service. **"Metric repository"**

**Key Components:**
| Component | Function | Example |
|-----------|----------|---------|
| **Metrics** | Numerical data | CPU utilization, Network In |
| **Alarms** | Alert on metrics | "Email SNS if CPU > 80%" |
| **Logs** | Log files | EC2 logs, Lambda logs |
| **Events (EventBridge)**| React to changes | "Trigger Lambda on EC2 start" |

---

### Amazon CloudTrail

**What:** API audit service. **"Risk & Compliance"**

**Key Question it answers:** "Who did what, where, and when?"

**Tracks:**
- Console logins
- API calls (e.g., launching EC2, deleting S3 bucket)
- Resource changes

**cloudWatch vs CloudTrail:**
| Feature | CloudWatch | CloudTrail |
|---------|------------|------------|
| **Focus** | Performance & Health | Audi & Compliance |
| **Data** | Metrics (CPU, Memory*) | API Calls (Who/When) |
| **Use Case** | "Is my server slow?" | "Who deleted my DB?" |
*\*Note: Memory is a custom metric.*

---

### Other Monitoring Tools

| Tool | Purpose |
|------|---------|
| **AWS X-Ray** | Trace distributed applications (debugging microservices) |
| **Amazon EventBridge** | Serverless event bus (evolution of CloudWatch Events) |

---

### AWS Health Dashboard

**What:** View the health status of AWS services and YOUR resources.

**Two Dashboards (Know the difference!):**

| Dashboard | What It Shows | Personalized? | Who Sees It |
|-----------|---------------|---------------|-------------|
| **Service Health Dashboard** | Global AWS service status | ❌ No | Everyone (public) |
| **Your Account Health Dashboard** | Events affecting YOUR resources | ✅ Yes | Only you |

### Service Health Dashboard

```
"EC2 is experiencing connectivity issues in us-east-1"
     ↓
Everyone sees this announcement
(not specific to your account)
```

**Use For:**
- Check if AWS is having a global outage
- View scheduled maintenance
- Historical uptime data

---

### Your Account Health Dashboard (EXAM FAVORITE!)

```
"Your RDS instance db-prod in us-east-1 is scheduled 
 for hardware maintenance on Feb 15, 2025"
     ↓
Only YOU see this (personalized to your resources!)
```

**Features:**
- Alerts specific to YOUR resources
- Proactive notifications
- Remediation guidance
- Integration with EventBridge for automation

**Exam Patterns:**

| Question Keyword | Answer |
|------------------|--------|
| "Personalized view of AWS status" | **Your Account Health** |
| "Events affecting YOUR resources" | **Your Account Health** |
| "YOUR Cloud architecture" | **Your Account Health** |
| "General AWS outage status" | Service Health |
| "Global AWS service status" | Service Health |

> **Exam Tip:** The word "**personalized**" or "**your**" → Answer is **Your Account Health Dashboard**

---

### AWS Trusted Advisor ⭐ EXAM FAVORITE!

**What:** Automated best practice recommendations.

**5 Categories (memorize these!):**

| Category | What It Checks | Example |
|----------|----------------|---------|
| **Cost Optimization** | Unused resources, idle instances | "Unused EBS volumes" |
| **Performance** | Over-utilized resources | "High utilization EC2" |
| **Security** | Open security groups, MFA | "Root MFA not enabled" |
| **Fault Tolerance** | Multi-AZ, backups | "RDS not Multi-AZ" |
| **Service Limits** | Approaching quotas | "VPC limit 80%" |

**Support Plan Access:**

| Plan | Trusted Advisor Access |
|------|------------------------|
| **Basic/Developer** | 7 core checks (security only) |
| **Business/Enterprise** | All 50+ checks |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "Identify security vulnerabilities automatically" | **Trusted Advisor** |
| "Find unused resources to reduce costs" | **Trusted Advisor** |
| "Check if approaching service limits" | **Trusted Advisor** |
| "Best practice recommendations" | **Trusted Advisor** |

### 📌 Quick Summary: Monitoring

- **CloudWatch:** Metrics, Alarms, Logs (Performance)
- **CloudTrail:** API Audit Logs (Compliance/Who)
- **X-Ray:** Distributed Tracing (Debugging)
- **Health Dashboard:** AWS service status
- **Trusted Advisor:** Best practice recommendations (5 categories)

---

### AWS Systems Manager

**What:** Manage and operate AWS resources at scale.

**Key Capabilities:**

| Feature | Purpose |
|---------|---------|
| **Session Manager** | Secure shell access without SSH keys |
| **Patch Manager** | Automate OS patching |
| **Parameter Store** | Store configuration and secrets |
| **Run Command** | Execute commands on multiple instances |
| **Automation** | Automate runbooks |

**Exam Pattern:**
> "Manage EC2 instances at scale without SSH..."
> → Answer: **Systems Manager (Session Manager)**

---

### AWS Config

**What:** Track resource configuration changes over time.

**Key Features:**
- Record configuration history
- Evaluate against rules (compliance)
- Receive alerts on changes

**Exam Pattern:**
> "Track all configuration changes for compliance..."
> → Answer: **AWS Config**

---

## 🚀 Part 3: Deployment & Infrastructure as Code

### Infrastructure as Code (IaC)

**What:** Provisioning infrastructure using code/configuration files instead of the console.

**Benefits:** version control, consistent environments, rapid deployment.

| Service | Description | Type |
|---------|-------------|------|
| **CloudFormation** | JSON/YAML templates defining resources | Declarative |
| **AWS CDK** | Define infra using Python, Java, TS | Imperative |

**Exam Pattern:**
> "Deploy infrastructure in a repeatable, automated way..."
> → Answer: **CloudFormation**

---

### AWS Elastic Beanstalk (PaaS)

**What:** Platform as a Service for web applications.

**You Provide:** Code (Java, Python, Docker, etc.)
**AWS Handles:** Deployment, capacity provisioning, load balancing, auto-scaling, health monitoring.
**Control:** You verify full control over underlying resources (EC2).

**Exam Pattern:**
> "Deploy web app quickly without worrying about infrastructure..."
> → Answer: **Elastic Beanstalk**

---

### CI/CD Tools (Developer Tools)

| Tool | Purpose | Equivalent |
|------|---------|------------|
| **CodeCommit** | Secure Git repositories | GitHub/Bitbucket |
| **CodeBuild** | Compile source code, run tests | Jenkins |
| **CodeDeploy** | Automate code deployment | Ansible/Octopus |
| **CodePipeline** | Orchestrate the release steps | Jenkins Pipeline |
| **CodeStar** | Unified UI for dev projects | (Dashboard) |

### 📌 Quick Summary: Deployment
- **CloudFormation:** IaC (Templates)
- **Elastic Beanstalk:** PaaS (Easy web app deploy)
- **CodePipeline:** Orchestrate CI/CD

---

## 💰 Part 4: Billing & Cost Management (Domain 4)

### AWS Pricing Fundamentals

**Three Pricing Principals:**
1. **Pay-as-you-go:** No long-term contracts (On-Demand)
2. **Save when you reserve:** Reserved Instances (RIs), Savings Plans
3. **Pay less by using more:** Volume discounts (S3 tiered pricing)

**Free Tier Types:**
- **Always Free:** Lambda (1M requests/mo), DynamoDB (25GB)
- **12-Months Free:** EC2 (t2.micro/t3.micro), S3 (5GB), RDS
- **Trials:** SageMaker, Redshift (short term)

---

### Billing Tools Strategy

| Tool | Question It Answers | When to Use |
|------|---------------------|-------------|
| **Pricing Calculator** | "How much *will* this cost?" | **Before** deploying (Estimates) |
| **AWS Budgets** | "Am I spending too much?" | **Alerts** when threshold breached |
| **Cost Explorer** | "Why is my bill high?" | **Analyze** historical data & trends/forecasts |
| **Cost & Usage Report** | "I need raw billing data." | **Granular** data for CSV/Athena analysis |
| **Cost Anomaly Detection** | "Alert me on unusual spending" | **ML-powered** automatic detection |

---

### AWS Cost Anomaly Detection

**What:** ML-powered service to detect unusual spending patterns.

**Key Features:**
- Uses machine learning (no configuration needed)
- Automatic alerts via SNS/email
- Root cause analysis
- Works with AWS Cost Explorer

**Exam Pattern:**
> "Automatically detect unexpected cost spikes..."
> → Answer: **Cost Anomaly Detection**

**Exam Patterns:**
| Scenario | Answer |
|----------|--------|
| "Receive an alert when spend exceeds $100" | **AWS Budgets** |
| "Visualize spending trends over last 6 months" | **Cost Explorer** |
| "Estimate cost for a new architecture" | **Pricing Calculator** |

---

### AWS Organizations

**What:** Manage multiple AWS accounts centrally.

**Benefits:**
1. **Consolidated Billing:** Combine usage for volume discounts.
2. **Central Management:** Single payment method.
3. **Service Control Policies (SCPs):** Restrict permissions (e.g., "No S3 access") across accounts.

---

### Cost Allocation Tags

**What:** Labels assigned to resources (e.g., `Project: Omega`, `Env: Prod`).
**Use:** Track costs by project or department in Cost Explorer.

---

## 🆘 Part 5: Support Plans (EXAM FAVORITE!)

**Memorize this table specifically the response times!**

| Plan | Price (Starts) | Tech Support | Key Features | Response Time (Critical) |
|------|----------------|--------------|--------------|--------------------------|
| **Basic** | Free | None | Docs, Service Health, Support Forums | N/A |
| **Developer** | $29/mo | Email (Biz hours) | 1 Primary Contact | < 12 hours (System impaired) |
| **Business** | $100/mo | 24/7 Phone/Chat | Unlimited Contacts, IAM Support | < 1 hour (Production down) |
| **Enterprise On-Ramp** | $5,500/mo | 24/7 Phone/Chat | Pool of TAMs | < 30 min (Biz critical) |
| **Enterprise** | $15,000/mo | 24/7 Phone/Chat | **Designated TAM**, Concierge | < 15 min (Biz critical) |

**TAM:** Technical Account Manager (Strategic advisor)

**Exam Patterns:**
| Scenario | Answer |
|----------|--------|
| "24/7 phone support for production workloads" | **Business** |
| "Strategic guidance and designated TAM" | **Enterprise** |
| "Email access during business hours" | **Developer** |
| "Access to full Trusted Advisor checks" | **Business** and up |

---

### 📌 Quick Summary: Support
- **Basic:** Free, no tech support
- **Developer:** $29, email only
- **Business:** $100, 24/7 phone, <1 hr urgent
- **Enterprise:** $15k, TAM, <15 min critical

---

## 🤝 Part 6: AWS Partner Network (APN)

### What Is APN?

**AWS Partner Network** is a global community of partners that use AWS to build solutions and services for customers.

### Two Types of Partners

| Partner Type | What They Do | Use For |
|--------------|--------------|---------|
| **APN Consulting Partner** | Professional services firms | Migration help, expert advice, implementation |
| **APN Technology Partner** | Software/SaaS companies | Tools that integrate with AWS |

### APN Consulting Partner

**Who:** Companies like Accenture, Deloitte, Capgemini, Infosys.

**Services:**
- Cloud migration planning
- Architecture design
- Implementation & deployment
- Managed services

**Exam Pattern:**
> "A company wants expert professional advice on migrating to AWS..."
> → Answer: **APN Consulting Partner**

---

### APN Technology Partner

**Who:** Software vendors like Splunk, Datadog, MongoDB.

**What They Offer:**
- Software products hosted on AWS
- Tools that integrate with AWS services
- SaaS solutions on AWS Marketplace

**Exam Pattern:**
> "A company needs monitoring software that integrates with AWS..."
> → Answer: **APN Technology Partner** (or check AWS Marketplace)

---

### Consulting vs Technology

| Question Keyword | Answer |
|------------------|--------|
| "Expert advice" | **Consulting Partner** |
| "Migration help" | **Consulting Partner** |
| "Professional services" | **Consulting Partner** |
| "Software integration" | **Technology Partner** |
| "SaaS product" | **Technology Partner** |

### 📌 Quick Summary: APN
- **Consulting Partner:** People who help you (services)
- **Technology Partner:** Products that work with AWS (software)

---

## 🧪 Self-Check Questions

### Integration & Monitoring
1. **Which service decouples components using specific pull-based logic?**
   <details><summary>Answer</summary>
   SQS (Simple Queue Service)
   </details>

2. **Which service logs API calls for compliance?**
   <details><summary>Answer</summary>
   CloudTrail
   </details>

3. **Which service provides metrics like CPU utilization?**
   <details><summary>Answer</summary>
   CloudWatch
   </details>

4. **Difference between SQS and SNS?**
   <details><summary>Answer</summary>
   SQS = Queue (Pull), SNS = Topic (Push/Fan-out)
   </details>

### Billing & Support
5. **Which tool alerts you when you exceed spend thresholds?**
   <details><summary>Answer</summary>
   AWS Budgets
   </details>

6. **Which support plan includes a designated TAM?**
   <details><summary>Answer</summary>
   Enterprise Plan
   </details>

7. **How can you get volume discounts across multiple accounts?**
   <details><summary>Answer</summary>
   Use AWS Organizations (Consolidated Billing)
   </details>

8. **Which tool estimates costs before deployment?**
   <details><summary>Answer</summary>
   AWS Pricing Calculator
   </details>

### Trusted Advisor & More

9. **What are the 5 categories of Trusted Advisor?**
   <details><summary>Answer</summary>
   Cost Optimization, Performance, Security, Fault Tolerance, Service Limits
   </details>

10. **Which support plan gives full Trusted Advisor access?**
    <details><summary>Answer</summary>
    Business or Enterprise (not Basic/Developer)
    </details>

11. **Which service orchestrates multiple Lambda functions?**
    <details><summary>Answer</summary>
    Step Functions
    </details>

12. **Which service detects unusual spending automatically?**
    <details><summary>Answer</summary>
    AWS Cost Anomaly Detection
    </details>

### Operations & Compliance

13. **Which service manages EC2 instances at scale without SSH?**
    <details><summary>Answer</summary>
    AWS Systems Manager (Session Manager)
    </details>

14. **Which service tracks resource configuration changes?**
    <details><summary>Answer</summary>
    AWS Config
    </details>

15. **Which service provides a secure place for secrets?**
    <details><summary>Answer</summary>
    Systems Manager Parameter Store (or Secrets Manager)
    </details>

16. **Which service automates OS patching?**
    <details><summary>Answer</summary>
    Systems Manager Patch Manager
    </details>

---

## 🔧 Hands-On Setup: Day 6 Practice

### Practice 1: Create a Billing Alarm (Crucial!)
**Objective:** Prevent surprise bills.
1. Go to **AWS Billing Dashboard**.
2. Select **Budgets** → Create Budget.
3. Choose **Cost Budget** → Next.
4. Set Amount: **$5.00**.
5. Set Alert: Send email to your address when **80%** ($4.00) is reached.
6. Create.

### Practice 2: Explore CloudWatch
1. Go to **CloudWatch Console**.
2. Click **Metrics** → **All metrics**.
3. Browse EC2 metrics (if you have running instances) or Billing metrics.
4. View the graph.

### Practice 3: Compare Support Plans
1. Go to **Support Center**.
2. Click **Create case**.
3. Notice you can only choose "Account and billing" (Basic plan restriction).
4. Search Google for "AWS Support Plans Compare" and view the official page.

---

## 💡 Tips & Tricks

### Exam Mnemonics & Keywords
- **"Decouple":** SQS
- **"Fan-out":** SNS
- **"Real-time stream":** Kinesis
- **"Audit/Compliance":** CloudTrail
- **"Metrics/Alarm":** CloudWatch
- **"Infrastructure as Code":** CloudFormation
- **"Designated TAM":** Enterprise Plan
- **"Estimate costs":** Pricing Calculator
- **"Analyze historical costs":** Cost Explorer
- **"Best practice checks":** Trusted Advisor
- **"Manage EC2 at scale":** Systems Manager
- **"Track config changes":** AWS Config
- **"Workflow orchestration":** Step Functions

### Common Mistakes
- Confusing **Budgets** vs **Cost Explorer**.
    - Budgets = Future alerts.
    - Cost Explorer = Past analysis.
- Confusing **Developer** vs **Business** support.
    - Developer = Email only, business hours.
    - Business = 24/7 Phone/Chat.

---

## ✅ Day 6 Completion Checklist

Before moving to the final Practice Exam day, make sure you can:
- [ ] **Distinguish** SQS, SNS, Kinesis, and Step Functions
- [ ] **Explain** CloudWatch vs CloudTrail
- [ ] **List** Trusted Advisor's 5 categories
- [ ] **Define** CloudFormation and Elastic Beanstalk
- [ ] **Select** the correct Support Plan given a scenario
- [ ] **Identify** the purpose of Cost Explorer, Budgets, and Organizations
- [ ] **Describe** Systems Manager capabilities (Session, Patch, Parameter Store)
- [ ] **Explain** AWS Config for compliance tracking

## 📝 Quiz Guidance
**Target Score:** 80%+
- **Quiz 9:** Integration
- **Quiz 11:** Monitoring
- **Quiz 16/17:** Billing & Support

---

**Previous:** [← Day 5 - Databases & Serverless](day-05-databases-serverless.md)  
**Next:** [Day 7 - Full Practice Exam →](day-07-practice-exam.md)
