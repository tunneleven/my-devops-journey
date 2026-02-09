# Day 5 Quiz: Databases, Serverless & Global Infrastructure

**Domain 3: Technology (34% of exam)**  
**Time:** 30-35 minutes  
**Passing Score:** 80% (20/25 correct)

---

## Instructions

1. Answer each question without looking at the resource
2. For scenario questions, think about **WHY** before choosing
3. Mark questions you're unsure about for review
4. Check answers at the end

---

## Section 1: RDS & Aurora (5 Questions)

### Q1. A company needs a MySQL database with automatic failover for high availability. Which RDS feature should they enable?

A) Read Replicas  
B) Multi-AZ deployment  
C) Aurora Global Database  
D) DynamoDB Streams

<details><summary>Answer</summary>

**B) Multi-AZ deployment**

**Why:** Multi-AZ provides automatic failover to a standby in another AZ. Read Replicas are for scaling reads, not high availability.

**Key Difference:** Multi-AZ = HA (synchronous). Read Replicas = Performance (asynchronous).
</details>

---

### Q2. A startup needs to scale their read-heavy application that currently uses RDS MySQL. What should they add?

A) Multi-AZ standby  
B) Read Replicas  
C) Global Tables  
D) DAX

<details><summary>Answer</summary>

**B) Read Replicas**

**Why:** Read Replicas distribute read traffic across up to 15 replicas. Multi-AZ standby doesn't serve read traffic.

**Exam Pattern:** "Scale reads" = Read Replicas. "High availability" = Multi-AZ.
</details>

---

### Q3. Which database offers 5x faster performance than MySQL and automatically scales storage up to 128TB?

A) RDS MySQL  
B) Amazon Aurora  
C) Amazon DynamoDB  
D) Amazon Redshift

<details><summary>Answer</summary>

**B) Amazon Aurora**

**Why:** Aurora is AWS's cloud-native database, optimized for the cloud. It's MySQL/PostgreSQL compatible but 5x faster than MySQL, 3x faster than PostgreSQL.

**Key Point:** Aurora auto-scales storage from 10GB to 128TB and stores 6 copies across 3 AZs.
</details>

---

### Q4. A gaming company needs a database with variable, unpredictable traffic that's sometimes idle. Which Aurora option is BEST?

A) Aurora Standard  
B) Aurora Serverless  
C) Aurora Global Database  
D) Aurora Multi-Master

<details><summary>Answer</summary>

**B) Aurora Serverless**

**Why:** Aurora Serverless automatically scales compute capacity based on demand—perfect for variable/unpredictable workloads. It can even pause when idle.

**Use Case:** Dev/test, variable workloads, infrequent use.
</details>

---

### Q5. For disaster recovery, a company needs their Aurora database replicated globally with less than 1 second replication lag. Which feature should they use?

A) Read Replicas  
B) Multi-AZ  
C) Aurora Global Database  
D) DMS

<details><summary>Answer</summary>

**C) Aurora Global Database**

**Why:** Aurora Global Database provides sub-second replication to up to 5 secondary regions. Perfect for DR and global read scaling.

**Key Point:** Cross-region replication with <1 second lag.
</details>

---

## Section 2: DynamoDB & NoSQL (5 Questions)

### Q6. Which database is serverless, fully managed, and provides single-digit millisecond latency for key-value lookups?

A) RDS  
B) Aurora  
C) DynamoDB  
D) Redshift

<details><summary>Answer</summary>

**C) DynamoDB**

**Why:** DynamoDB is AWS's serverless NoSQL database designed for single-digit millisecond performance at any scale.

**Memory Hook:** "DynamoDB = serverless + milliseconds + unlimited scale"
</details>

---

### Q7. A social media app needs a database that can handle multi-region, active-active writes. Which solution fits?

A) RDS Multi-AZ  
B) Aurora Global Database  
C) DynamoDB Global Tables  
D) ElastiCache

<details><summary>Answer</summary>

**C) DynamoDB Global Tables**

**Why:** Global Tables provide multi-region, multi-active replication. Both regions can read AND write. Aurora Global has read-only secondary regions.

**Key Difference:** DynamoDB Global Tables = multi-active. Aurora Global = single-write.
</details>

---

### Q8. A company needs to reduce DynamoDB read latency from milliseconds to MICROSECONDS. Which feature should they add?

A) Read Replicas  
B) Multi-AZ  
C) DAX (DynamoDB Accelerator)  
D) Global Tables

<details><summary>Answer</summary>

**C) DAX (DynamoDB Accelerator)**

**Why:** DAX is an in-memory cache for DynamoDB that reduces read latency from single-digit milliseconds to microseconds.

**Use Case:** Latency-sensitive apps like gaming leaderboards, real-time bidding.
</details>

---

### Q9. Who is responsible for managing DynamoDB table permissions according to the Shared Responsibility Model?

A) AWS  
B) Customer  
C) Both AWS and Customer  
D) Third-party vendors

<details><summary>Answer</summary>

**B) Customer**

**Why:** AWS manages the infrastructure (physical security, patching). Customer manages access controls, table permissions, and data.

**Shared Responsibility:** AWS = OF the cloud. Customer = IN the cloud.
</details>

---

### Q10. Which of the following is NOT a valid use case for DynamoDB?

A) Session management  
B) Gaming leaderboards  
C) Complex SQL joins with transactions  
D) IoT device data

<details><summary>Answer</summary>

**C) Complex SQL joins with transactions**

**Why:** DynamoDB is NoSQL—it doesn't support SQL joins. For complex relational queries, use RDS or Aurora.

**Rule:** Key-value/document = DynamoDB. Complex SQL = RDS/Aurora.
</details>

---

## Section 3: Specialty Databases & Analytics (5 Questions)

### Q11. A company needs to store social network relationship data to find connections between users. Which database is BEST?

A) DynamoDB  
B) Amazon Neptune  
C) Amazon Timestream  
D) Amazon QLDB

<details><summary>Answer</summary>

**B) Amazon Neptune**

**Why:** Neptune is a graph database designed for highly connected data—social networks, fraud detection, recommendation engines.

**Memory Hook:** Neptune = Nodes + Relationships = Social networks.
</details>

---

### Q12. An IoT company needs to store millions of sensor readings with timestamps. Which database is purpose-built for this?

A) DynamoDB  
B) Neptune  
C) Amazon Timestream  
D) Amazon Redshift

<details><summary>Answer</summary>

**C) Amazon Timestream**

**Why:** Timestream is a time-series database optimized for IoT and operational metrics—purpose-built for timestamped data.

**Use Cases:** IoT sensors, metrics, DevOps monitoring.
</details>

---

### Q13. A company needs to query data stored in S3 using standard SQL without loading it into a database. Which service should they use?

A) Redshift  
B) Amazon Athena  
C) AWS Glue  
D) Amazon EMR

<details><summary>Answer</summary>

**B) Amazon Athena**

**Why:** Athena is serverless and queries data directly in S3 using SQL. No data loading required.

**Pricing:** $5 per TB scanned. Use columnar formats (Parquet) to reduce costs.
</details>

---

### Q14. A company needs to create interactive dashboards for business analysts to visualize sales data. Which service should they use?

A) Amazon Athena  
B) Amazon QuickSight  
C) AWS Glue  
D) Amazon Kinesis

<details><summary>Answer</summary>

**B) Amazon QuickSight**

**Why:** QuickSight is a serverless BI service for creating visualizations and dashboards. Connects to Athena, S3, RDS, Redshift.

**Key Feature:** SPICE in-memory engine for fast analytics.
</details>

---

### Q15. A company needs to transform data from multiple sources before loading into Redshift for analytics. Which service handles ETL?

A) Amazon Athena  
B) Amazon QuickSight  
C) AWS Glue  
D) Amazon DMS

<details><summary>Answer</summary>

**C) AWS Glue**

**Why:** Glue is a serverless ETL service—Extract, Transform, Load. It also provides Data Catalog for metadata management.

**Components:** ETL Jobs + Data Catalog + Crawlers.
</details>

---

## Section 4: Serverless & Containers (5 Questions)

### Q16. A developer needs to run code that processes uploaded images to S3 without managing any servers. Which service is BEST?

A) EC2  
B) AWS Lambda  
C) Amazon ECS  
D) AWS Batch

<details><summary>Answer</summary>

**B) AWS Lambda**

**Why:** Lambda is serverless and can be triggered by S3 events. No servers to manage, auto-scales, pay per invocation.

**Exam Pattern:** "No servers" + "trigger" = Lambda.
</details>

---

### Q17. What is the MAXIMUM timeout for an AWS Lambda function?

A) 5 minutes  
B) 10 minutes  
C) 15 minutes  
D) 30 minutes

<details><summary>Answer</summary>

**C) 15 minutes**

**Why:** Lambda has a hard limit of 15 minutes (900 seconds). For longer jobs, use Step Functions, Batch, or ECS.

**Remember:** 15 minutes is a commonly tested limit.
</details>

---

### Q18. A company wants to run Docker containers without managing the underlying EC2 instances. Which service should they use?

A) Amazon ECS on EC2  
B) AWS Fargate  
C) Amazon EKS  
D) AWS Elastic Beanstalk

<details><summary>Answer</summary>

**B) AWS Fargate**

**Why:** Fargate is a serverless compute engine for containers. You define containers, AWS manages infrastructure.

**Key Point:** Fargate works with both ECS and EKS.
</details>

---

### Q19. A company already uses Kubernetes on-premises and wants to migrate to AWS with minimal changes. Which service provides managed Kubernetes?

A) Amazon ECS  
B) AWS Fargate  
C) Amazon EKS  
D) AWS Lambda

<details><summary>Answer</summary>

**C) Amazon EKS**

**Why:** EKS is managed Kubernetes. Existing Kubernetes workloads can migrate with minimal changes. ECS uses AWS-native orchestration.

**Decision:** Kubernetes expertise = EKS. AWS-native = ECS.
</details>

---

### Q20. Where should a company store Docker container images to use with ECS and EKS?

A) Amazon S3  
B) Amazon EBS  
C) Amazon ECR  
D) AWS CodeArtifact

<details><summary>Answer</summary>

**C) Amazon ECR**

**Why:** ECR (Elastic Container Registry) is AWS's private Docker registry. Integrated with ECS, EKS, and Lambda.

**Feature:** Built-in vulnerability scanning for images.
</details>

---

## Section 5: Global Infrastructure & Networking (5 Questions)

### Q21. A company needs to route users to the AWS region with the LOWEST latency. Which Route 53 policy should they use?

A) Simple routing  
B) Weighted routing  
C) Latency-based routing  
D) Geolocation routing

<details><summary>Answer</summary>

**C) Latency-based routing**

**Why:** Latency-based routing measures latency between users and regions, routing to the fastest one.

**Geolocation vs Latency:** Geo = content by location. Latency = lowest response time.
</details>

---

### Q22. A company wants to accelerate global users accessing static website content stored in S3. Which service should they use?

A) Route 53  
B) Amazon CloudFront  
C) AWS Global Accelerator  
D) AWS Transit Gateway

<details><summary>Answer</summary>

**B) Amazon CloudFront**

**Why:** CloudFront is a CDN that caches static content at 750+ edge locations worldwide.

**Key Point:** CloudFront = caching. Global Accelerator = no caching (dynamic).
</details>

---

### Q23. A gaming company needs to improve performance for their real-time multiplayer game with players worldwide. Which service optimizes network routing WITHOUT caching?

A) Amazon CloudFront  
B) AWS Global Accelerator  
C) Route 53  
D) AWS Transit Gateway

<details><summary>Answer</summary>

**B) AWS Global Accelerator**

**Why:** Global Accelerator routes traffic through AWS's global network backbone for consistent performance. No caching—ideal for dynamic, real-time applications.

**Use Cases:** Gaming, VoIP, real-time APIs.
</details>

---

### Q24. A company needs to migrate their on-premises Oracle database to Amazon Aurora PostgreSQL. Which service should they use?

A) AWS Glue  
B) AWS DMS  
C) AWS DataSync  
D) AWS Transfer Family

<details><summary>Answer</summary>

**B) AWS DMS (Database Migration Service)**

**Why:** DMS migrates databases to AWS with minimal downtime. For different engines (Oracle → PostgreSQL), also use SCT (Schema Conversion Tool).

**Key Point:** Source database stays operational during migration.
</details>

---

### Q25. What is the MINIMUM number of Availability Zones in an AWS Region?

A) 1  
B) 2  
C) 3  
D) 4

<details><summary>Answer</summary>

**C) 3**

**Why:** Every AWS Region has at least 3 Availability Zones for redundancy. Most have 3-6 AZs.

**Remember:** 3 AZs minimum per Region.
</details>

---

## Score Tracker

| Section | Questions | Your Score |
|---------|-----------|------------|
| RDS & Aurora | Q1-Q5 | ___ / 5 |
| DynamoDB & NoSQL | Q6-Q10 | ___ / 5 |
| Specialty DBs & Analytics | Q11-Q15 | ___ / 5 |
| Serverless & Containers | Q16-Q20 | ___ / 5 |
| Global Infrastructure | Q21-Q25 | ___ / 5 |
| **Total** | **25** | **___ / 25** |

---

## Score Interpretation

| Score | Verdict | Action |
|-------|---------|--------|
| 23-25 | ✅ Ready for Day 6 | Great job! Move on |
| 20-22 | 🟡 Almost there | Review missed topics |
| 15-19 | ⚠️ Needs work | Re-read resource, retake quiz |
| <15 | ❌ Not ready | Study resource thoroughly first |

---

## Weak Area Review Guide

| If you missed... | Review this section in Day 5 Resource |
|------------------|--------------------------------------|
| Q1-Q5 | Part 2-3: RDS & Aurora |
| Q6-Q10 | Part 4: DynamoDB |
| Q11-Q15 | Part 5-5B: Other Databases & Analytics |
| Q16-Q20 | Part 7-8: Lambda & Containers |
| Q21-Q25 | Part 10-11: Global Infrastructure & Networking |

---

## Key Concepts Quick Reference

### Database Selection Tree
```
Relational + SQL? → RDS or Aurora
Key-value + NoSQL? → DynamoDB
Graph relationships? → Neptune
Time-series (IoT)? → Timestream
Immutable ledger? → QLDB
Data warehouse? → Redshift
```

### Serverless vs Managed
```
Lambda: Code only, event-driven, 15 min max
Fargate: Containers without EC2
Aurora Serverless: Variable DB workloads
DynamoDB: NoSQL, unlimited scale
```

### Global Services Decision
```
DNS routing → Route 53
Static content caching → CloudFront
Dynamic app optimization → Global Accelerator
Database migration → DMS
```

### Analytics Pipeline
```
Data in S3 → Query with Athena
Transform data → Glue ETL
Visualize → QuickSight
Big data processing → EMR
```
