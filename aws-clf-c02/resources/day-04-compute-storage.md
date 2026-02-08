# Day 4: Compute & Storage

**Domain 3: Technology (34% of exam)**  
**Study Time:** 6-8 hours  

### 🎯 Learning Goals

By the end of Day 4, you will be able to:

1. **Choose** the right EC2 instance family for different workloads
2. **Select** the optimal EC2 pricing model for cost-efficiency
3. **Explain** Auto Scaling and ELB for high availability
4. **Distinguish** between EBS, EFS, Instance Store, and S3 use cases
5. **Match** S3 storage classes to access frequency requirements
6. **Apply** S3 features (versioning, replication, lifecycle, Object Lock)
7. **Explain** encryption options and S3 Transfer Acceleration

---

## 📋 Services You'll Meet Today

> Prerequisites from earlier days.

| Service | What It Does | Status |
|---------|--------------|--------|
| **IAM** | Identity & access | Day 2 ✅ Required |
| **VPC** | Virtual network | Day 3 ✅ Required |
| **Security Groups** | Instance firewall | Day 3 ✅ Required |
| **CloudWatch** | Monitoring & alarms | Day 6 (mentioned) |
| **Lambda** | Serverless functions | Day 5 (mentioned) |

📖 **Quick Reference:** [AWS Glossary](../notes/glossary.md)

---

## 📖 How to Use This Resource

1. **Understand** the trade-offs between services (when to use which)
2. **Focus on** pricing models—exam loves testing cost optimization
3. **Memorize** the S3 storage classes and their retrieval times
4. **Test yourself** with the self-check questions at the end

> [!IMPORTANT]
> **Day 4 covers the largest exam domain!** Technology is 34% of the exam. Master EC2 pricing and S3 storage classes thoroughly.

---

## 💻 Part 1: Amazon EC2 Fundamentals

### What Is EC2?

**EC2 (Elastic Compute Cloud):** Virtual servers in the cloud.

**Key Characteristics:**
- **On-demand capacity** - minutes to launch
- **Pay-as-you-go** - pay per second/hour
- **Scalable** - resize instances, add more
- **Root of AWS compute** - foundation for many services

---

### 🔥 EC2 Instance Families

**Mnemonic: "GTRC SIP"** (General, Turbo/Burstable, Compute, Memory, Storage, Accelerated)

| Family | Type | Use Case | Memory Tip |
|--------|------|----------|------------|
| **T** | Burstable | Dev/test, low traffic web | **T**urbo bursts |
| **M** | General Purpose | Web servers, small DBs | **M**iddle ground |
| **C** | Compute Optimized | Scientific, gaming, batch | **C**PU intensive |
| **R** | Memory Optimized | In-memory DBs, caching | **R**AM focused |
| **X** | Memory Optimized | SAP HANA, large in-memory | e**X**tra memory |
| **I, D, H** | Storage Optimized | Data warehousing, HDFS | **I**ntense I/O |
| **P, G** | Accelerated | ML training, graphics | **G**PU/TPU |
| **Inf, Trn** | ML Inference/Training | ML workloads | **Inf**erence |

### Instance Naming Convention

```
m5.2xlarge
│ │  │
│ │  └── Size (nano < micro < small < medium < large < xlarge < 2xlarge...)
│ └───── Generation (higher = newer)
└─────── Family (m = general purpose)
```

### Exam Patterns

| Scenario | Instance Family |
|----------|-----------------|
| "General purpose web application" | **M or T** |
| "High-performance computing" | **C** |
| "In-memory database" | **R or X** |
| "Machine learning training" | **P or G** |
| "Data warehouse, Hadoop" | **I, D, or H** |

### 📌 Quick Summary: EC2 Instance Types

- **T/M:** General purpose (web, small DBs)
- **C:** Compute optimized (CPU-intensive)
- **R/X:** Memory optimized (in-memory DBs)
- **I/D/H:** Storage optimized (data warehousing)
- **P/G:** Accelerated (ML, graphics)

---

## 💰 Part 2: EC2 Pricing Models

### 🔥 The 5 Pricing Options (CRITICAL!)

| Option | Commitment | Discount | Best For |
|--------|------------|----------|----------|
| **On-Demand** | None | 0% | Unpredictable, short-term |
| **Reserved** | 1-3 years | Up to 72% | Steady-state workloads |
| **Savings Plans** | 1-3 years | Up to 72% | Flexible commitment |
| **Spot** | None | Up to 90% | Fault-tolerant, flexible |
| **Dedicated Hosts** | None/Reserved | Varies | Compliance, licensing |

---

### On-Demand Instances

**What:** Pay by the second (Linux) or hour (Windows) with no commitment.

**Use When:**
- Short-term, spiky workloads
- Testing new applications
- Can't predict usage patterns

**Key Point:** Most expensive per hour, but no commitment.

---

### Reserved Instances (RIs)

**What:** Commit to 1 or 3 years for significant discount.

**Three Types:**

| Type | Description | Flexibility |
|------|-------------|-------------|
| **Standard** | Fixed instance type | Lowest price, least flexible |
| **Convertible** | Can change instance type | Higher price, more flexible |
| **Scheduled** | Reserved time windows | For predictable patterns |

**Payment Options:**
- **All Upfront:** Largest discount
- **Partial Upfront:** Medium discount
- **No Upfront:** Smallest discount

**Use When:** Steady-state, predictable workloads (24/7 databases, core apps).

---

### Savings Plans

**What:** Commit to $/hr spend for 1-3 years, flexible usage.

**Two Types:**

| Type | Applies To | Flexibility |
|------|------------|-------------|
| **Compute Savings** | EC2, Fargate, Lambda | Any region, family, OS |
| **EC2 Instance Savings** | EC2 only | Specific region and family |

**Use When:** Want savings but need flexibility to change instance types.

---

### Spot Instances

**What:** Use AWS spare capacity at steep discount.

**Key Characteristics:**
- **Up to 90% discount** vs On-Demand
- **Can be interrupted** with 2-minute warning
- **Fault-tolerant workloads only**

**Use When:**
- Batch processing
- Big data analysis
- CI/CD pipelines
- Containerized workloads

**Never Use For:**
- Databases (data loss risk)
- Critical workloads
- Anything that can't handle interruption

**Exam Pattern:**
> "Maximize cost savings for fault-tolerant batch job..."
> → Answer: **Spot Instances**

---

### Dedicated Options

| Option | What | Use Case |
|--------|------|----------|
| **Dedicated Instances** | Your instances on dedicated hardware | Compliance isolation |
| **Dedicated Hosts** | Entire physical server for you | BYOL (Bring Your Own License) |

**Use When:**
- Compliance requirements (no shared hardware)
- Software licensing that requires dedicated servers
- Regulatory requirements

---

### 💡 Pricing Decision Tree

```
Need 24/7, predictable?
├── Yes → Reserved Instance or Savings Plan
│   └── Need flexibility? → Savings Plan
│   └── Fixed type? → Reserved Instance
└── No → Can tolerate interruption?
    ├── Yes → Spot Instance
    └── No → On-Demand
    
Need dedicated hardware?
└── Yes → Dedicated Host/Instance
```

### 📌 Quick Summary: EC2 Pricing

- **On-Demand:** No commitment, highest price
- **Reserved:** 1-3 year commitment, up to 72% off
- **Savings Plans:** $/hr commitment, flexible
- **Spot:** Up to 90% off, can be interrupted
- **Dedicated:** For compliance/licensing

---

## 🖼️ Part 2.5: Amazon Machine Images (AMI)

### What Is AMI?

**AMI (Amazon Machine Image):** Pre-configured template for launching EC2 instances.

**Contains:**
- Operating system (Linux, Windows)
- Application software
- Configuration settings
- Launch permissions

**Types:**

| Type | Source | Use Case |
|------|--------|----------|
| **AWS-provided** | AWS | Quick start, standard OS |
| **Marketplace** | Third-party | Pre-built apps |
| **Custom** | You create | Golden images, compliance |

**Key Points:**
- AMIs are **region-specific** (copy to use in another region)
- Can be **shared** across accounts
- Used in **Launch Templates** for Auto Scaling

### 📌 Quick Summary: AMI

- **Template** for launching EC2 instances
- Contains OS, apps, configuration
- Region-specific, can be shared/copied

---

## 📈 Part 2.6: Auto Scaling

### What Is Auto Scaling?

**Auto Scaling:** Automatically adjusts EC2 capacity based on demand.

**Components:**

| Component | What It Does |
|-----------|-------------|
| **Launch Template** | EC2 configuration (AMI, type, security) |
| **Auto Scaling Group** | Min/max/desired instance count |
| **Scaling Policies** | Rules for when to scale |

---

### Scaling Types

| Type | How It Works | Use Case |
|------|--------------|----------|
| **Dynamic** | CloudWatch metrics trigger | Variable traffic |
| **Predictive** | ML-based forecasting | Predictable patterns |
| **Scheduled** | Time-based rules | Known peak times |

### Dynamic Scaling Policies

| Policy | How | Example |
|--------|-----|--------|
| **Target Tracking** | Maintain metric at target | Keep CPU at 50% |
| **Step Scaling** | Scale based on threshold | +2 if CPU > 80% |
| **Simple Scaling** | Single adjustment | Add 1 instance |

**Exam Patterns:**

| Scenario | Answer |
|----------|---------|
| "Automatically add EC2 during traffic spikes" | **Auto Scaling (Dynamic)** |
| "Scale based on predictable daily patterns" | **Auto Scaling (Scheduled)** |
| "Maintain 50% average CPU utilization" | **Target Tracking Policy** |

### 📌 Quick Summary: Auto Scaling

- **Automatically adjusts** EC2 capacity
- **Launch Template** + **Auto Scaling Group** + **Scaling Policies**
- **Dynamic:** Based on metrics | **Scheduled:** Based on time

---

## ⚖️ Part 2.7: Elastic Load Balancing (ELB)

### What Is ELB?

**ELB:** Distributes incoming traffic across multiple targets (EC2, containers, IPs).

**Benefits:**
- **High availability** - routes around failures
- **Fault tolerance** - health checks remove unhealthy targets
- **Scalability** - works with Auto Scaling

---

### 🔥 Three Load Balancer Types

| Type | Layer | Protocol | Best For |
|------|-------|----------|----------|
| **ALB** (Application) | Layer 7 | HTTP/HTTPS | Web apps, microservices |
| **NLB** (Network) | Layer 4 | TCP/UDP | Ultra-low latency, gaming |
| **CLB** (Classic) | L4/L7 | Legacy | Avoid for new projects |

### Feature Comparison

| Feature | ALB | NLB |
|---------|-----|-----|
| **Path routing** | ✅ Yes | ❌ No |
| **Host routing** | ✅ Yes | ❌ No |
| **Static IP** | ❌ No | ✅ Yes |
| **Latency** | Low | Ultra-low |
| **WebSocket** | ✅ Yes | ✅ Yes |

**Exam Patterns:**

| Scenario | Answer |
|----------|---------|
| "Route based on URL path (/api, /images)" | **ALB** |
| "Ultra-low latency for gaming" | **NLB** |
| "Distribute traffic across Availability Zones" | **Any ELB** |
| "Health checks for EC2 instances" | **ELB + Auto Scaling** |

### 📌 Quick Summary: ELB

- **Distributes traffic** across multiple targets
- **ALB:** Layer 7, HTTP/HTTPS, path routing
- **NLB:** Layer 4, TCP/UDP, ultra-low latency
- **Works with Auto Scaling** for high availability

---

## 🏢 Part 2.8: EC2 Placement Groups

### What Are Placement Groups?

**Placement Groups:** Control how EC2 instances are placed on underlying hardware.

| Type | Strategy | Use Case | Risk |
|------|----------|----------|------|
| **Cluster** | Same rack, same AZ | HPC, low latency | Single point of failure |
| **Spread** | Different racks | Critical apps | Max 7 per AZ |
| **Partition** | Separate partitions | Hadoop, Cassandra | Fault isolation |

### Visual Comparison

```
CLUSTER:     All together (fastest network)
[EC2][EC2][EC2][EC2] ← Same rack

SPREAD:      All separate (max resilience)
[EC2]     [EC2]     [EC2] ← Different racks

PARTITION:   Grouped isolation
[Partition 1]  [Partition 2]  [Partition 3]
[EC2][EC2]     [EC2][EC2]     [EC2][EC2]
```

**Exam Patterns:**

| Scenario | Answer |
|----------|---------|
| "Low-latency HPC workload" | **Cluster Placement Group** |
| "Critical app, minimize correlated failures" | **Spread Placement Group** |
| "Large distributed database (Hadoop, Kafka)" | **Partition Placement Group** |

### 📌 Quick Summary: Placement Groups

- **Cluster:** Same rack, lowest latency, HPC
- **Spread:** Different racks, max resilience, 7 per AZ max
- **Partition:** Fault isolation for distributed systems

---

## 💾 Part 3: Storage Overview

### Storage Types in AWS

| Type | What It Is | Analogy |
|------|------------|---------|
| **Block Storage** | Raw disk blocks | Hard drive (EBS, Instance Store) |
| **File Storage** | Hierarchical files | Network drive (EFS, FSx) |
| **Object Storage** | Flat with metadata | Blob storage (S3) |

---

## 📀 Part 4: Amazon EBS (Elastic Block Store)

### What Is EBS?

**EBS:** Network-attached block storage for EC2 instances.

**Key Characteristics:**
- **Persistent** - data survives instance stop/termination
- **AZ-scoped** - tied to one Availability Zone
- **Detachable** - can attach to different EC2 in same AZ
- **Snapshots** - backup to S3

---

### EBS Volume Types

| Type | Category | IOPS | Use Case |
|------|----------|------|----------|
| **gp3/gp2** | General Purpose SSD | 3,000-16,000 | Boot volumes, dev/test |
| **io2/io1** | Provisioned IOPS SSD | Up to 64,000 | Databases, critical apps |
| **st1** | Throughput HDD | 500 MB/s | Big data, data warehouse |
| **sc1** | Cold HDD | 250 MB/s | Infrequent access, archive |

### Exam Patterns

| Scenario | EBS Type |
|----------|----------|
| "Boot volume for EC2" | **gp3/gp2** (SSD required) |
| "High-performance database" | **io2/io1** (Provisioned IOPS) |
| "Big data processing, streaming" | **st1** (Throughput HDD) |
| "Lowest cost, infrequent access" | **sc1** (Cold HDD) |

---

### EBS Snapshots

**What:** Point-in-time backup of EBS volume to S3.

**Key Features:**
- **Incremental** - only changed blocks are saved
- **Cross-AZ** - restore to any AZ in region
- **Cross-Region** - copy snapshots to another region
- **Encryption** - snapshots of encrypted volumes are encrypted

### 📌 Quick Summary: EBS

- **Block storage** attached to EC2, AZ-scoped
- **gp3/gp2:** General purpose SSD (boot volumes)
- **io2/io1:** High IOPS for databases
- **st1/sc1:** HDD for throughput/archive
- **Snapshots:** Incremental backups to S3

---

## 📁 Part 5: Instance Store

### What Is Instance Store?

**Instance Store:** Temporary block storage physically attached to EC2 host.

| Feature | Instance Store | EBS |
|---------|----------------|-----|
| **Persistence** | Lost on stop/terminate | Persists |
| **Performance** | Highest (local disk) | Network-attached |
| **Cost** | Included in instance | Separate charge |
| **Best For** | Temp data, buffers, cache | Permanent data |

**Use Cases:**
- Temporary files
- Buffers and caches
- Scratch data

> [!CAUTION]
> **Data is LOST** when instance stops, terminates, or fails!

### 📌 Quick Summary: Instance Store

- **Ephemeral** - data lost on stop/terminate
- **Highest performance** - local physical disk
- Use for **temporary data only** (cache, buffers)

---

## 📂 Part 6: Amazon EFS (Elastic File System)

### What Is EFS?

**EFS:** Managed NFS (Network File System) for Linux.

**Key Characteristics:**
- **Shared storage** - multiple EC2 can access simultaneously
- **Region-scoped** - accessible from any AZ
- **Auto-scaling** - grows/shrinks automatically
- **Linux only** - POSIX-compliant

---

### EFS Storage Classes

| Class | Access | Cost | Use Case |
|-------|--------|------|----------|
| **Standard** | Frequent | Higher | Active data |
| **Infrequent Access (IA)** | Infrequent | Lower + retrieval fee | Older files |

**Lifecycle Policy:** Auto-move files to IA after X days.

### EFS vs FSx

| Feature | EFS | FSx Windows | FSx Lustre |
|---------|-----|-------------|------------|
| **Protocol** | NFS | SMB | Lustre |
| **OS** | Linux | Windows | Linux |
| **Use Case** | Linux shared | Windows shares | HPC, ML |

### 📌 Quick Summary: EFS

- **Shared file storage** for Linux (NFS)
- **Region-scoped** - accessible from all AZs
- **Auto-scaling** - pay only for what you use
- **Two classes:** Standard and Infrequent Access

---

## 🪣 Part 7: Amazon S3 (Simple Storage Service)

### What Is S3?

**S3:** Object storage with virtually unlimited capacity.

**Key Characteristics:**
- **Object storage** - files stored as objects with metadata
- **Regional service** - data replicated across 3+ AZs
- **11 nines durability** - 99.999999999%
- **Unlimited storage** - per object max 5 TB

---

### S3 Core Concepts

| Concept | What It Is |
|---------|-----------|
| **Bucket** | Container for objects (globally unique name) |
| **Object** | File + metadata (up to 5 TB) |
| **Key** | Full path to object within bucket |
| **Version ID** | Unique ID when versioning enabled |

---

### 🔥 S3 Storage Classes (EXAM FAVORITE!)

| Class | Access Pattern | Min Duration | Retrieval | Use Case |
|-------|----------------|--------------|-----------|----------|
| **Standard** | Frequent | None | Instant | Active data |
| **Intelligent-Tiering** | Unknown | None | Instant | Unpredictable |
| **Standard-IA** | Infrequent | 30 days | Instant | Backups |
| **One Zone-IA** | Infrequent | 30 days | Instant | Reproducible data |
| **Glacier Instant** | Rare | 90 days | Instant | Archive, instant access |
| **Glacier Flexible** | Archive | 90 days | Minutes-hours | Long-term backup |
| **Glacier Deep Archive** | Long-term | 180 days | 12-48 hours | Compliance archive |

### Storage Class Decision Tree

```
How often do you access the data?
├── Frequently → S3 Standard
├── Don't know → Intelligent-Tiering
├── Infrequently (monthly)
│   ├── Need multi-AZ? → Standard-IA
│   └── Single-AZ OK? → One Zone-IA
└── Rarely/Archive
    ├── Need instant access? → Glacier Instant
    ├── Can wait minutes-hours? → Glacier Flexible
    └── Can wait 12-48 hours? → Glacier Deep Archive
```

### Exam Patterns

| Scenario | Storage Class |
|----------|---------------|
| "Frequently accessed website assets" | **Standard** |
| "Unpredictable access patterns" | **Intelligent-Tiering** |
| "Monthly backups, quick retrieval" | **Standard-IA** |
| "Backups for reproducible data" | **One Zone-IA** |
| "Archive, immediate access needed" | **Glacier Instant** |
| "Archive, can wait hours" | **Glacier Flexible** |
| "7-year compliance archive" | **Glacier Deep Archive** |

### 📌 Quick Summary: S3 Storage Classes

- **Standard:** Frequent access, highest cost
- **Intelligent-Tiering:** Auto-moves based on usage
- **IA classes:** Infrequent access, retrieval fee
- **Glacier:** Archive, varying retrieval times
- **Deep Archive:** Cheapest, slowest retrieval (12-48 hrs)

---

### Glacier Retrieval Options (Detail)

| Storage Class | Retrieval Tier | Time | Cost |
|---------------|---------------|------|------|
| **Glacier Flexible** | Expedited | 1-5 minutes | Highest |
| **Glacier Flexible** | Standard | 3-5 hours | Medium |
| **Glacier Flexible** | Bulk | 5-12 hours | Lowest (free) |
| **Deep Archive** | Standard | 12 hours | Medium |
| **Deep Archive** | Bulk | 48 hours | Lowest |

**Exam Pattern:**
> "Retrieve archived data within minutes..."
> → Answer: **Glacier Flexible with Expedited retrieval**

---

## 🛡️ Part 8: S3 Features

### S3 Versioning

**What:** Keep multiple versions of objects.

**Benefits:**
- Protect from accidental deletion
- Easy rollback to previous versions
- Deleted objects get "delete marker" (recoverable)

**Exam Pattern:**
> "Protect S3 objects from accidental deletion..."
> → Answer: **Enable Versioning**

---

### S3 Replication

| Type | What | Use Case |
|------|------|----------|
| **CRR** | Cross-Region Replication | DR, compliance, latency |
| **SRR** | Same-Region Replication | Log aggregation, dev/prod sync |

**Requirements:** Versioning must be enabled on both buckets.

---

### S3 Lifecycle Policies

**What:** Automatically transition or expire objects.

**Actions:**
- **Transition** - move to different storage class
- **Expiration** - delete objects after X days

**Example:**
```
After 30 days → Standard-IA
After 90 days → Glacier Flexible
After 365 days → Delete
```

---

### S3 Encryption

| Type | Who Manages Keys | Key Storage |
|------|------------------|-------------|
| **SSE-S3** | AWS | AWS-managed |
| **SSE-KMS** | AWS KMS | Customer-controlled |
| **SSE-C** | Customer | Customer provides |
| **Client-Side** | Customer | Before upload |

**Exam Pattern:**
> "Encrypt S3 with audit trail of key usage..."
> → Answer: **SSE-KMS** (CloudTrail logs key access)

---

### S3 Access Control

| Method | Scope | Use Case |
|--------|-------|----------|
| **Bucket Policy** | Bucket-level | Cross-account, public access |
| **ACLs** | Object/bucket | Legacy, simple scenarios |
| **IAM Policies** | User/role | Per-identity permissions |
| **Access Points** | Application | Simplified access management |

### 📌 Quick Summary: S3 Features

- **Versioning:** Multiple versions, deletion protection
- **Replication:** CRR (cross-region), SRR (same-region)
- **Lifecycle:** Auto-transition to cheaper classes
- **Encryption:** SSE-S3, SSE-KMS, SSE-C

---

### 🔒 S3 Object Lock (WORM Storage)

**What:** Write-Once-Read-Many storage for regulatory compliance.

**Two Modes:**

| Mode | Can Admin Delete? | Use Case |
|------|-------------------|----------|
| **Governance** | Yes (with permissions) | Testing, internal policy |
| **Compliance** | No (nobody can delete) | SEC, HIPAA, legal hold |

**Retention:**
- **Retention Period:** Lock until specific date
- **Legal Hold:** Lock indefinitely (until removed)

**Requirements:** Versioning must be enabled.

**Exam Pattern:**
> "Prevent anyone from deleting files for 7 years..."
> → Answer: **S3 Object Lock (Compliance Mode)**

---

### 🚀 S3 Transfer Acceleration

**What:** Faster uploads to S3 using CloudFront edge locations.

**How It Works:**
```
User (Tokyo) → Edge Location (Tokyo) → AWS Backbone → S3 (us-east-1)
                   [Fast]                [Optimized]     [Destination]
```

**Use When:**
- Users upload from distant geographic locations
- Large files need faster transfer
- Global application with central S3 bucket

**Key Points:**
- Uses CloudFront edge locations
- Additional cost per GB transferred
- Must be enabled per bucket

**Exam Pattern:**
> "Speed up uploads from users around the world..."
> → Answer: **S3 Transfer Acceleration**

### 📌 Quick Summary: Advanced S3 Features

- **Object Lock:** WORM storage, Governance vs Compliance mode
- **Transfer Acceleration:** Faster global uploads via edge locations

---

## 🔄 Part 9: Other Storage Services

### Snow Family (Offline Data Transfer)

| Device | Capacity | Use Case |
|--------|----------|----------|
| **Snowcone** | 8-14 TB | Edge computing, small transfers |
| **Snowball Edge** | 80-210 TB | Large migrations |
| **Snowmobile** | 100 PB | Massive data center migrations |

**Use When:** Internet transfer would take too long (weeks/months).

---

### AWS Storage Gateway

**What:** Hybrid cloud storage connecting on-premises to AWS.

| Type | What | Use Case |
|------|------|----------|
| **File Gateway** | NFS/SMB to S3 | File shares |
| **Volume Gateway** | iSCSI to EBS snapshots | Block storage |
| **Tape Gateway** | Virtual tapes to Glacier | Backup |

---

### AWS Backup

**What:** Centralized backup across AWS services.

**Key Features:**
- Single dashboard for all backups
- Cross-region and cross-account
- Supports EC2, EBS, RDS, DynamoDB, EFS, S3

### 📌 Quick Summary: Other Storage

- **Snow Family:** Offline data transfer (Snowcone, Snowball, Snowmobile)
- **Storage Gateway:** Hybrid cloud storage bridge
- **AWS Backup:** Centralized backup management

---

## 🧪 Self-Check Questions

### EC2

1. **Which instance family for in-memory database?**
   <details><summary>Answer</summary>
   R or X family (Memory Optimized)
   </details>

2. **Which pricing for 24/7 steady workload?**
   <details><summary>Answer</summary>
   Reserved Instances or Savings Plans (1-3 year commitment)
   </details>

3. **Which pricing for fault-tolerant batch jobs?**
   <details><summary>Answer</summary>
   Spot Instances (up to 90% discount, can be interrupted)
   </details>

4. **Spot vs Reserved: which can be interrupted?**
   <details><summary>Answer</summary>
   Spot Instances can be interrupted with 2-minute warning
   </details>

### Storage

5. **Which storage for EC2 boot volume?**
   <details><summary>Answer</summary>
   EBS (gp3 or gp2 SSD)
   </details>

6. **Which storage for Linux shared files?**
   <details><summary>Answer</summary>
   EFS (Elastic File System)
   </details>

7. **Instance Store: is it persistent?**
   <details><summary>Answer</summary>
   No, data is lost when instance stops/terminates
   </details>

### S3

8. **Which S3 class for unpredictable access?**
   <details><summary>Answer</summary>
   S3 Intelligent-Tiering
   </details>

9. **Which class for 7-year compliance archive?**
   <details><summary>Answer</summary>
   Glacier Deep Archive (lowest cost, 12-48 hr retrieval)
   </details>

10. **How to protect S3 from accidental deletion?**
    <details><summary>Answer</summary>
    Enable Versioning
    </details>

### Auto Scaling & ELB

11. **What automatically adds EC2 during traffic spikes?**
    <details><summary>Answer</summary>
    Auto Scaling (Dynamic scaling policy)
    </details>

12. **Which load balancer for HTTP path-based routing?**
    <details><summary>Answer</summary>
    ALB (Application Load Balancer) - Layer 7
    </details>

13. **Which placement group for HPC with lowest latency?**
    <details><summary>Answer</summary>
    Cluster Placement Group (same rack, same AZ)
    </details>

14. **How to prevent regulatory data deletion for 7 years?**
    <details><summary>Answer</summary>
    S3 Object Lock with Compliance Mode
    </details>

15. **How to speed up global uploads to S3?**
    <details><summary>Answer</summary>
    S3 Transfer Acceleration (uses CloudFront edge locations)
    </details>

---

## 🔧 Hands-On Setup: Day 4 Practice

### Practice 1: Explore EC2 Console

**Objective:** Understand EC2 instance types and pricing

**Steps:**
1. Go to [EC2 Console](https://console.aws.amazon.com/ec2)
2. Click **Launch Instance** (don't complete)
3. Browse instance types:
   - Filter by family (t, m, c, r)
   - Note the vCPU and memory differences
4. Look at **Compare instance types** to see specs
5. **Cancel** (don't launch)

**Expected Result:** Understand instance family differences.

### Practice 2: Explore S3 Storage Classes

**Objective:** See storage class options

**Steps:**
1. Go to [S3 Console](https://console.aws.amazon.com/s3)
2. Click **Create bucket** → Enter unique name → **Create**
3. Upload a small file
4. Select the file → **Properties** → **Storage class**
5. Note all available classes
6. **Delete** the bucket after exploring

**Expected Result:** Understand S3 storage class options.

### Practice 3: View EC2 Pricing

**Objective:** Understand pricing models

**Steps:**
1. Go to [EC2 Pricing](https://aws.amazon.com/ec2/pricing/)
2. Compare On-Demand prices for t3.micro
3. Click **Reserved Instances** → See savings
4. Click **Spot Instances** → See savings %

> [!CAUTION]
> **Free Tier Alert:** Don't launch instances beyond Free Tier (t2.micro/t3.micro, 750 hrs/month).

---

## 💡 Tips & Tricks

### Exam Tips

| Tip | Details |
|-----|---------|
| **"Cost savings for steady workload"** | Reserved or Savings Plans |
| **"Can tolerate interruption"** | Spot Instances |
| **"In-memory database"** | R or X instance family |
| **"Shared Linux storage"** | EFS |
| **"Archive with instant access"** | Glacier Instant |
| **"Cheapest archive storage"** | Glacier Deep Archive |
| **"Protect from accidental delete"** | S3 Versioning |
| **"Encrypt with audit trail"** | SSE-KMS |

### Time-Saving Tricks

| Trick | Why |
|-------|-----|
| Instance Store = Ephemeral | Always remember data is lost |
| EBS = AZ-scoped | Must snapshot to move across AZs |
| EFS = Multi-AZ | Accessible from any AZ |
| S3 = 11 nines | 99.999999999% durability |

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| Using Spot for databases | Spot can be interrupted; use Reserved |
| Forgetting EBS is AZ-scoped | Need snapshot to copy to another AZ |
| Instance Store for permanent data | Data is lost on stop; use EBS |
| Wrong S3 class for access pattern | Match class to access frequency |

---

## 📝 Flashcard Quick Reference

| Front | Back |
|-------|------|
| EC2 T/M Family | General purpose |
| EC2 C Family | Compute optimized |
| EC2 R/X Family | Memory optimized |
| Spot Instances | Up to 90% off, can be interrupted |
| Reserved Instances | 1-3 year, up to 72% off |
| EBS Scope | AZ-scoped |
| EFS Scope | Region-scoped, multi-AZ |
| Instance Store | Ephemeral, data lost on stop |
| S3 Standard | Frequent access |
| S3 Intelligent-Tiering | Unknown access |
| Glacier Deep Archive | Cheapest, 12-48 hr retrieval |
| S3 Versioning | Deletion protection |
| SSE-KMS | Encryption with audit trail |

---

## ✅ Day 4 Completion Checklist

Before moving to Day 5, make sure you can:

- [ ] **Name** 5 EC2 instance families and their use cases
- [ ] **Explain** 5 EC2 pricing models and when to use each
- [ ] **Choose** Spot vs Reserved vs On-Demand for scenarios
- [ ] **Distinguish** EBS, EFS, Instance Store, and S3
- [ ] **List** S3 storage classes from hottest to coldest
- [ ] **Apply** S3 lifecycle policies and versioning
- [ ] **Explain** S3 encryption options (SSE-S3, SSE-KMS, SSE-C)

---

## 📝 Quiz Guidance

**After studying this resource, take these quizzes:**

| Quiz | Source | Focus |
|------|--------|-------|
| **Quiz 3** | Stephane Maarek Course | EC2 Fundamentals |
| **Quiz 4** | Stephane Maarek Course | EC2 Instance Storage |
| **Quiz 6** | Stephane Maarek Course | Amazon S3 |

**Target Score:** 80%+ before proceeding to Day 5

> [!TIP]
> Pricing questions often give you a scenario. Match the commitment level and interruption tolerance to the pricing model.

---

**Previous:** [← Day 3 - Security Services & VPC](day-03-security-vpc.md)  
**Next:** [Day 5 - Databases & Serverless →](day-05-databases-serverless.md)
