# Day 5: Databases, Serverless & Global Infrastructure

**Domain 3: Technology (34% of exam)**  
**Study Time:** 6-8 hours  

### 🎯 Learning Goals

By the end of Day 5, you will be able to:

1. **Choose** the right database service for different workloads (RDS, Aurora, DynamoDB)
2. **Explain** when to use serverless compute (Lambda) vs containers (ECS, Fargate)
3. **Distinguish** between ECS, Fargate, and EKS container services
4. **Describe** AWS global infrastructure (Regions, AZs, Edge Locations)
5. **Select** Route 53, CloudFront, or Global Accelerator for global scenarios
6. **Apply** database migration strategies using DMS
7. **Match** analytics services to use cases (Athena, QuickSight, Glue, EMR)

---

## 📖 How to Use This Resource

1. **Focus on** service selection—exam tests "which database/service for this use case?"
2. **Understand** the difference between serverless and managed services
3. **Memorize** the database types and their specialty (key-value, graph, etc.)
4. **Test yourself** with the self-check questions at the end

> [!IMPORTANT]
> **Day 5 completes Domain 3!** Combined with Day 4, you'll have covered all Technology topics (34% of exam).

---

## 🗄️ Part 1: Database Fundamentals

### Database Types Overview

| Type | How Data Is Stored | Example Services |
|------|-------------------|------------------|
| **Relational** | Tables with rows/columns | RDS, Aurora |
| **Key-Value** | Simple key → value pairs | DynamoDB |
| **Document** | JSON-like documents | DocumentDB |
| **In-Memory** | RAM for speed | ElastiCache |
| **Graph** | Nodes and relationships | Neptune |
| **Time-Series** | Timestamped data | Timestream |
| **Ledger** | Immutable transactions | QLDB |
| **Data Warehouse** | Analytics, columnar | Redshift |

---

## 🔥 Part 2: Amazon RDS (Relational Database Service)

### What Is RDS?

**RDS:** Managed relational database service.

**Supported Engines:**

| Engine | Type | Notes |
|--------|------|-------|
| **MySQL** | Open source | Most popular |
| **PostgreSQL** | Open source | Advanced features |
| **MariaDB** | Open source | MySQL fork |
| **Oracle** | Commercial | BYOL or License Included |
| **SQL Server** | Commercial | Microsoft |
| **Aurora** | AWS-native | MySQL/PostgreSQL compatible |

---

### What RDS Manages For You

| AWS Manages | You Manage |
|-------------|-----------|
| Hardware provisioning | Application optimization |
| Database setup | Query tuning |
| Patching | Schema design |
| Backups | Data |
| Multi-AZ failover | |

---

### RDS Multi-AZ vs Read Replicas

| Feature | Multi-AZ | Read Replicas |
|---------|----------|---------------|
| **Purpose** | High availability | Performance |
| **Sync** | Synchronous | Asynchronous |
| **Failover** | Automatic | Manual promotion |
| **Read traffic** | No | Yes |
| **Cross-Region** | No | Yes |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "High availability for production database" | **Multi-AZ** |
| "Scale read-heavy workload" | **Read Replicas** |
| "Disaster recovery in another region" | **Cross-Region Read Replica** |

### 📌 Quick Summary: RDS

- **Managed relational database** (6 engines)
- **Multi-AZ:** High availability, automatic failover
- **Read Replicas:** Scale reads, can be cross-region
- AWS handles: provisioning, patching, backups

---

## ⚡ Part 3: Amazon Aurora

### What Is Aurora?

**Aurora:** AWS-designed cloud-native relational database.

**Key Characteristics:**
- **MySQL and PostgreSQL compatible**
- **5x faster than MySQL, 3x faster than PostgreSQL**
- **Auto-scales storage** from 10GB to 128TB
- **6 copies of data** across 3 AZs

---

### Aurora Features

| Feature | Description |
|---------|-------------|
| **Aurora Serverless** | Auto-scales compute capacity |
| **Aurora Global Database** | Cross-region replication (<1s lag) |
| **Aurora Multi-Master** | Multiple write nodes |
| **Backtrack** | Rewind database to previous state |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "High-performance MySQL compatible" | **Aurora** |
| "Database with variable/unpredictable workload" | **Aurora Serverless** |
| "Sub-second global replication" | **Aurora Global Database** |

### 📌 Quick Summary: Aurora

- **Cloud-native relational database** (MySQL/PostgreSQL compatible)
- **5x MySQL, 3x PostgreSQL** performance
- **Auto-scaling storage** (10GB to 128TB)
- **Aurora Serverless:** For variable workloads

---

## 📊 Part 4: Amazon DynamoDB

### What Is DynamoDB?

**DynamoDB:** Serverless, fully managed NoSQL key-value database.

**Key Characteristics:**
- **Serverless** - no servers to manage
- **Single-digit millisecond** latency
- **Automatic scaling** - handles any scale
- **Built-in security** - encryption at rest

---

### DynamoDB Concepts

| Term | What It Is |
|------|-----------|
| **Table** | Collection of items |
| **Item** | Single record (like a row) |
| **Attribute** | Data field (like a column) |
| **Primary Key** | Unique identifier |
| **Partition Key** | Distribution key |
| **Sort Key** | Optional ordering key |

---

### DynamoDB Features

| Feature | Purpose |
|---------|---------|
| **DynamoDB Accelerator (DAX)** | In-memory cache (microseconds) |
| **Global Tables** | Multi-region, multi-active |
| **Streams** | Capture changes for triggers |
| **On-Demand vs Provisioned** | Pricing modes |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "NoSQL with single-digit ms latency" | **DynamoDB** |
| "Key-value or document storage" | **DynamoDB** |
| "Serverless database" | **DynamoDB** |
| "Multi-region active-active database" | **DynamoDB Global Tables** |

### 📌 Quick Summary: DynamoDB

- **Serverless NoSQL** key-value database
- **Single-digit ms latency**, unlimited scale
- **DAX:** In-memory cache for microsecond reads
- **Global Tables:** Multi-region replication

### Shared Responsibility: DynamoDB

| AWS Manages | You Manage |
|-------------|------------|
| Physical security | Access controls (IAM) |
| Infrastructure patching | Table permissions |
| Encryption at rest | Application design |
| Underlying hardware | Data |

**Exam Pattern:**
> "Who is responsible for DynamoDB table permissions?"
> → Answer: **Customer** (Shared Responsibility Model)

---

## 🔥 Part 5: Other Database Services

### ElastiCache

**What:** In-memory caching service.

**Engines:**

| Engine | Use Case |
|--------|----------|
| **Redis** | Complex data types, persistence, pub/sub |
| **Memcached** | Simple caching, multi-threaded |

**Use Cases:**
- Session management
- Database query caching
- Real-time analytics

**Exam Pattern:**
> "Reduce database load for repeated queries..."
> → Answer: **ElastiCache**

---

### Amazon Redshift

**What:** Data warehouse for analytics (OLAP).

**Key Characteristics:**
- **Columnar storage** (column-based, not row-based)
- **Petabyte-scale**
- **SQL interface**
- **Integrates with BI tools**

**Exam Pattern:**
> "Analyze large datasets for business intelligence..."
> → Answer: **Redshift**

---

### Specialty Databases

| Service | Type | Use Case |
|---------|------|----------|
| **DocumentDB** | Document | MongoDB-compatible |
| **Neptune** | Graph | Social networks, fraud detection |
| **Timestream** | Time-series | IoT, metrics, DevOps |
| **QLDB** | Ledger | Immutable, cryptographic verification |
| **Keyspaces** | Wide-column | Apache Cassandra-compatible |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "Graph relationships (friends, fraud)" | **Neptune** |
| "IoT sensor data over time" | **Timestream** |
| "Immutable transaction history" | **QLDB** |
| "MongoDB application migration" | **DocumentDB** |

### 📌 Quick Summary: Other Databases

- **ElastiCache:** In-memory cache (Redis, Memcached)
- **Redshift:** Data warehouse, analytics, columnar
- **Neptune:** Graph database
- **Timestream:** Time-series for IoT
- **QLDB:** Immutable ledger

---

## 📊 Part 5B: Analytics Services

### Amazon Athena

**What:** Query S3 data using standard SQL.

**Key Features:**
- **Serverless** - no infrastructure to manage
- **Pay per query** - charged for data scanned
- Query CSV, JSON, Parquet files directly in S3

**Exam Pattern:**
> "Analyze data directly in S3 without loading to database..."
> → Answer: **Athena**

---

### Amazon QuickSight

**What:** Serverless business intelligence (BI) dashboards.

**Key Features:**
- Create interactive visualizations and dashboards
- Connect to many data sources (Athena, S3, RDS, Redshift)
- Machine learning-powered insights

**Exam Pattern:**
> "Create visualizations and dashboards for business users..."
> → Answer: **QuickSight**

---

### AWS Glue

**What:** Serverless ETL (Extract, Transform, Load) service.

**Key Features:**
- **Glue Data Catalog:** Central metadata repository
- **ETL Jobs:** Transform data between formats
- **Crawlers:** Discover and catalog data schemas

**Exam Pattern:**
> "Prepare and transform data for analytics..."
> → Answer: **AWS Glue**

---

### Amazon EMR (Elastic MapReduce)

**What:** Managed big data platform (Hadoop, Spark).

**Use Cases:**
- Big data processing
- Machine learning
- Log analysis

**Exam Pattern:**
> "Process large datasets using Hadoop or Spark..."
> → Answer: **Amazon EMR**

### 📌 Quick Summary: Analytics

- **Athena:** SQL queries on S3 (serverless)
- **QuickSight:** BI dashboards (serverless)
- **Glue:** ETL and data catalog
- **EMR:** Big data (Hadoop/Spark)
- **Redshift:** Data warehouse (covered above)

---

## 🔄 Part 6: Database Migration

### AWS DMS (Database Migration Service)

**What:** Migrate databases to AWS with minimal downtime.

**Supports:**
- Homogeneous migrations (Oracle → Oracle)
- Heterogeneous migrations (Oracle → Aurora)
- Continuous replication

**Key Points:**
- Source database remains operational during migration
- Use **SCT (Schema Conversion Tool)** for heterogeneous migrations

**Exam Pattern:**
> "Migrate on-premises database to AWS..."
> → Answer: **AWS DMS**

### 📌 Quick Summary: Migration

- **DMS:** Database migration with minimal downtime
- **SCT:** Schema conversion for different engines
- Supports continuous replication

---

## ⚡ Part 7: AWS Lambda (Serverless Compute)

### What Is Lambda?

**Lambda:** Run code without provisioning servers.

**Key Characteristics:**
- **Event-driven** - runs in response to triggers
- **Pay per invocation** - charged per request + duration
- **Automatic scaling** - handles any load
- **Supports** Python, Node.js, Java, Go, .NET, Ruby

---

### Lambda Limits

| Limit | Value |
|-------|-------|
| **Timeout** | 15 minutes max |
| **Memory** | 128 MB to 10 GB |
| **Package size** | 50 MB zipped, 250 MB unzipped |
| **Concurrent executions** | 1,000 (soft limit) |

---

### Lambda Triggers

| Trigger | Use Case |
|---------|----------|
| **API Gateway** | REST API endpoints |
| **S3** | Object created/deleted |
| **DynamoDB Streams** | Table changes |
| **CloudWatch Events** | Scheduled tasks (cron) |
| **SNS, SQS** | Message processing |
| **Kinesis** | Stream processing |

**Exam Patterns:**

| Scenario | Answer |
|----------|--------|
| "Run code without managing servers" | **Lambda** |
| "Process S3 file automatically on upload" | **Lambda + S3 trigger** |
| "Scheduled task (cron-like)" | **Lambda + CloudWatch Events** |

### 📌 Quick Summary: Lambda

- **Serverless compute** - no servers to manage
- **Event-driven** - triggered by AWS services
- **15 min max timeout**, pay per invocation
- Scales automatically, supports multiple languages

---

## 🐳 Part 8: Container Services

### Container Service Overview

| Service | What | You Manage |
|---------|------|------------|
| **ECS** | Container orchestration | EC2 instances |
| **Fargate** | Serverless containers | Nothing |
| **EKS** | Managed Kubernetes | Some control plane |
| **ECR** | Container registry | Images |

---

### Amazon ECS (Elastic Container Service)

**What:** Run Docker containers on AWS.

**Two Launch Types:**

| Launch Type | Infrastructure | Use Case |
|-------------|---------------|----------|
| **EC2** | You manage EC2 instances | More control |
| **Fargate** | AWS manages infrastructure | Serverless |

---

### AWS Fargate

**What:** Serverless compute engine for containers.

**Key Characteristics:**
- **No EC2 to manage** - just define containers
- **Pay for resources used** - vCPU and memory
- Works with **ECS and EKS**

**Exam Pattern:**
> "Run containers without managing servers..."
> → Answer: **Fargate**

---

### Amazon EKS (Elastic Kubernetes Service)

**What:** Managed Kubernetes service.

**Use When:**
- Already using Kubernetes
- Need Kubernetes-specific features
- Multi-cloud strategy (Kubernetes portability)

---

### Amazon ECR (Elastic Container Registry)

**What:** Private Docker image repository.

**Key Points:**
- Store, manage, deploy Docker images
- Integrated with ECS, EKS, Lambda
- Supports image scanning for vulnerabilities

### 📌 Quick Summary: Containers

- **ECS:** AWS-native container orchestration
- **Fargate:** Serverless containers (no EC2)
- **EKS:** Managed Kubernetes
- **ECR:** Private Docker image registry

---

## 🎯 Part 9: Other Compute Services

### Amazon Lightsail

**What:** Simple VPS (Virtual Private Server) service.

**Features:**
- Fixed monthly pricing
- Pre-configured applications
- Easy to use (simpler than EC2)

**Use When:** Simple websites, dev/test environments.

---

### AWS Batch

**What:** Fully managed batch computing.

**Use When:**
- Large-scale batch jobs
- HPC workloads
- Jobs that can wait for capacity

---

### AWS Outposts

**What:** Run AWS infrastructure on-premises.

**Use When:**
- Low latency to on-premises systems
- Local data processing requirements
- Regulatory requirements

### 📌 Quick Summary: Other Compute

- **Lightsail:** Simple VPS, fixed pricing
- **Batch:** Large-scale batch computing
- **Outposts:** AWS infrastructure on-premises

---

## 🌍 Part 10: AWS Global Infrastructure

### Infrastructure Components

| Component | What It Is | Count |
|-----------|-----------|-------|
| **Regions** | Geographic areas with multiple AZs | **39** |
| **Availability Zones** | Isolated data centers in a region | **123** (3+ per region) |
| **Edge Locations** | CloudFront PoPs + Regional Edge Caches | **750+** |
| **Local Zones** | Low-latency extensions near users | **43** |
| **Wavelength Zones** | Ultra-low latency for 5G | **33** |

> [!TIP]
> **Exam Note:** You do **NOT** need to memorize the exact number of Regions/AZs/PoPs (since they change often).
> **DO memorize:**
> - A Region has **at least 3 AZs**
> - Edge Locations are for **caching** (CloudFront) and are far more numerous than Regions
> - Lambda max duration is **15 minutes**

---

### Local Zones

**What:** AWS infrastructure extensions closer to end users.

**Use When:**
- Need single-digit millisecond latency
- Run latency-sensitive apps (gaming, media streaming)
- Keep compute closer to users

**Key Point:** Extends a Region's capabilities to metros without full Regions.

---

### Choosing a Region

**Factors to Consider:**

| Factor | Question |
|--------|----------|
| **Compliance** | Does data need to stay in a specific country? |
| **Latency** | How close are your users? |
| **Services** | Are the services you need available? |
| **Pricing** | Are there cost differences? |

---

### 📌 Quick Summary: Global Infrastructure

- **Regions:** 39 geographic areas
- **AZs:** 123 total (3+ per region)
- **PoPs:** 750+ CloudFront cache points
- **Local Zones:** 43 for low-latency
- Choose region based on: compliance, latency, services, pricing

---

## 🌐 Part 11: Global Networking Services

### Amazon Route 53

**What:** Managed DNS (Domain Name System) service.

**Features:**
- Domain registration
- DNS routing
- Health checks

**Routing Policies:**

| Policy | How It Routes |
|--------|---------------|
| **Simple** | Single resource |
| **Weighted** | Percentage-based distribution |
| **Latency** | Lowest latency to user |
| **Failover** | Primary/secondary |
| **Geolocation** | Based on user location |
| **Geoproximity** | Based on resource location + bias |
| **Multi-Value** | Multiple healthy resources |

**Exam Patterns:**

| Scenario | Route 53 Policy |
|----------|-----------------|
| "Route to closest region" | **Latency-based** |
| "A/B testing with traffic split" | **Weighted** |
| "DR with automatic failover" | **Failover** |
| "Different content by country" | **Geolocation** |

---

### Amazon CloudFront

**What:** Content Delivery Network (CDN).

**How It Works:**
```
User → Edge Location (cached) → Origin (S3, ALB, EC2)
         [Fast, nearby]         [If not cached]
```

**Key Features:**
- **Edge caching** at 750+ locations
- **HTTPS** support
- **DDoS protection** (Shield Standard included)
- **Origin types:** S3, ALB, EC2, custom HTTP

**Exam Pattern:**
> "Reduce latency for global users accessing static content..."
> → Answer: **CloudFront**

---

### AWS Global Accelerator

**What:** Improve global application performance using AWS backbone.

**CloudFront vs Global Accelerator:**

| Feature | CloudFront | Global Accelerator |
|---------|------------|-------------------|
| **Type** | CDN (caching) | Network optimization |
| **Best For** | Static content | Dynamic applications |
| **Caching** | Yes | No |
| **Protocol** | HTTP/HTTPS | TCP/UDP |
| **Use Case** | Websites, videos | Gaming, VoIP, APIs |

**Exam Pattern:**
> "Improve performance for global gaming application..."
> → Answer: **Global Accelerator**

### 📌 Quick Summary: Global Networking

- **Route 53:** DNS service, routing policies
- **CloudFront:** CDN, edge caching, static content
- **Global Accelerator:** Network optimization, dynamic apps

---

## 🧪 Self-Check Questions

### Databases

1. **Which database for high-performance MySQL compatible?**
   <details><summary>Answer</summary>
   Aurora (5x MySQL performance)
   </details>

2. **Which database for NoSQL key-value with ms latency?**
   <details><summary>Answer</summary>
   DynamoDB (serverless, single-digit ms)
   </details>

3. **Which database for graph relationships?**
   <details><summary>Answer</summary>
   Neptune (fraud detection, social networks)
   </details>

4. **Which service for caching database queries?**
   <details><summary>Answer</summary>
   ElastiCache (Redis or Memcached)
   </details>

5. **Which service to migrate database to AWS?**
   <details><summary>Answer</summary>
   AWS DMS (Database Migration Service)
   </details>

### Serverless & Containers

6. **Which service runs code without servers?**
   <details><summary>Answer</summary>
   Lambda (serverless compute)
   </details>

7. **Which service for serverless containers?**
   <details><summary>Answer</summary>
   Fargate (no EC2 to manage)
   </details>

8. **Which service for Kubernetes workloads?**
   <details><summary>Answer</summary>
   EKS (Elastic Kubernetes Service)
   </details>

### Global Infrastructure

9. **Which service for DNS routing?**
   <details><summary>Answer</summary>
   Route 53
   </details>

10. **Which service to cache content globally?**
    <details><summary>Answer</summary>
    CloudFront (CDN, edge locations)
    </details>

11. **CloudFront vs Global Accelerator: which for caching?**
    <details><summary>Answer</summary>
    CloudFront (CDN with edge caching)
    </details>

12. **How many AZs minimum per region?**
    <details><summary>Answer</summary>
    At least 3 AZs per region
    </details>

### Analytics

13. **Which service queries S3 data with SQL?**
    <details><summary>Answer</summary>
    Amazon Athena (serverless, pay per query)
    </details>

14. **Which service creates BI dashboards?**
    <details><summary>Answer</summary>
    Amazon QuickSight
    </details>

15. **Which service provides ETL for data transformation?**
    <details><summary>Answer</summary>
    AWS Glue
    </details>

16. **Which service runs Hadoop/Spark workloads?**
    <details><summary>Answer</summary>
    Amazon EMR (Elastic MapReduce)
    </details>

---

## 🔧 Hands-On Setup: Day 5 Practice

### Practice 1: Explore RDS Console

**Objective:** Understand RDS options

**Steps:**
1. Go to [RDS Console](https://console.aws.amazon.com/rds)
2. Click **Create database** (don't complete)
3. Note the 6 engine options
4. Explore **Multi-AZ** and **Read Replica** options
5. **Cancel** (don't create)

**Expected Result:** Understand RDS configuration options.

### Practice 2: Explore Lambda

**Objective:** See serverless configuration

**Steps:**
1. Go to [Lambda Console](https://console.aws.amazon.com/lambda)
2. Click **Create function**
3. Choose **Author from scratch**
4. Note runtime options (Python, Node.js, etc.)
5. Note memory and timeout settings
6. **Cancel** (don't create)

**Expected Result:** Understand Lambda configuration.

### Practice 3: View CloudFront

**Objective:** Understand CDN configuration

**Steps:**
1. Go to [CloudFront Console](https://console.aws.amazon.com/cloudfront)
2. Click **Create distribution**
3. Note origin options (S3, ALB, custom)
4. Note edge location settings
5. **Cancel** (don't create)

> [!CAUTION]
> **Free Tier Alert:** Lambda has 1M free requests/month. CloudFront has 1TB free transfer/month for first year.

---

## 💡 Tips & Tricks

### Exam Tips

| Tip | Details |
|-----|---------|
| **"MySQL compatible, high performance"** | Aurora |
| **"NoSQL, serverless"** | DynamoDB |
| **"Graph database"** | Neptune |
| **"Run code without servers"** | Lambda |
| **"Containers without servers"** | Fargate |
| **"Cache static content globally"** | CloudFront |
| **"Optimize dynamic app globally"** | Global Accelerator |
| **"DNS routing by location"** | Route 53 Geolocation |

### Time-Saving Tricks

| Trick | Why |
|-------|-----|
| Aurora = Cloud-native RDS | Remember: AWS-designed for cloud |
| DynamoDB = Serverless NoSQL | No capacity planning |
| Fargate = Serverless containers | No EC2 management |
| CloudFront = Caching | Global Accelerator = Routing |

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| Confusing RDS and Aurora | Aurora is AWS-designed, self-healing |
| Using Lambda for long jobs | Lambda max is 15 min; use Batch |
| Confusing CloudFront and GA | CloudFront caches; GA optimizes |
| Mixing ECS and EKS | ECS = AWS-native; EKS = Kubernetes |

---

## 📝 Flashcard Quick Reference

| Front | Back |
|-------|------|
| Aurora | Cloud-native relational, 5x MySQL |
| DynamoDB | Serverless NoSQL, ms latency |
| ElastiCache | In-memory cache, Redis/Memcached |
| Redshift | Data warehouse, analytics |
| Neptune | Graph database |
| Lambda | Serverless compute, 15 min max |
| Fargate | Serverless containers |
| ECS | AWS container orchestration |
| EKS | Managed Kubernetes |
| Route 53 | DNS, routing policies |
| CloudFront | CDN, edge caching |
| Global Accelerator | Network optimization |
| Regions | 39 geographic areas |
| AZs | 123 total, 3+ per region |
| **Athena** | SQL queries on S3 (serverless) |
| **QuickSight** | BI dashboards (serverless) |
| **Glue** | ETL, Data Catalog |
| **EMR** | Big data (Hadoop/Spark) |

---

## ✅ Day 5 Completion Checklist

Before moving to Day 6, make sure you can:

- [ ] **Choose** between RDS, Aurora, and DynamoDB for scenarios
- [ ] **Explain** Multi-AZ vs Read Replicas
- [ ] **List** specialty databases (Neptune, Timestream, QLDB)
- [ ] **Describe** Lambda triggers and limitations
- [ ] **Distinguish** ECS, Fargate, and EKS
- [ ] **Explain** Regions, AZs, and Edge Locations
- [ ] **Compare** CloudFront vs Global Accelerator
- [ ] **Select** Athena, QuickSight, Glue, or EMR for analytics scenarios

---

## 📝 Quiz Guidance

**After studying this resource, take these quizzes:**

| Quiz | Source | Focus |
|------|--------|-------|
| **Quiz 7** | Stephane Maarek Course | Databases |
| **Quiz 8** | Stephane Maarek Course | Other Compute (Lambda, Containers) |
| **Quiz 10** | Stephane Maarek Course | Global Infrastructure |

**Target Score:** 80%+ before proceeding to Day 6

> [!TIP]
> Database questions test "which database for X scenario" - match the specialty to the use case.

---

**Previous:** [← Day 4 - Compute & Storage](day-04-compute-storage.md)  
**Next:** [Day 6 - Integration, Monitoring & Billing →](day-06-integration-billing.md)
