# Day 4 Quiz: Compute & Storage

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

## Section 1: EC2 Instance Types (5 Questions)

### Q1. A data scientist needs to train a machine learning model that requires GPU acceleration. Which EC2 instance family should they choose?

A) C family (Compute Optimized)  
B) R family (Memory Optimized)  
C) P or G family (Accelerated Computing)  
D) M family (General Purpose)

<details><summary>Answer</summary>

**C) P or G family (Accelerated Computing)**

**Why:** P and G families have GPUs designed for machine learning training, graphics rendering, and high-performance computing.

**Memory Tip:** **P** = **P**rocessing power (GPU), **G** = **G**raphics/GPU.
</details>

---

### Q2. Which EC2 instance family is BEST suited for a real-time in-memory database like Redis?

A) T family  
B) C family  
C) R family  
D) I family

<details><summary>Answer</summary>

**C) R family**

**Why:** R family is Memory Optimized, designed for applications that need large amounts of RAM, like in-memory databases (Redis, Memcached, SAP HANA).

**Memory Tip:** **R** = **R**AM-focused.
</details>

---

### Q3. A small business needs a low-cost EC2 instance for their company blog that experiences occasional traffic spikes. Which instance family is most cost-effective?

A) C family  
B) R family  
C) T family  
D) I family

<details><summary>Answer</summary>

**C) T family**

**Why:** T family instances are burstable—they provide a baseline CPU with the ability to burst when needed. Perfect for variable workloads like blogs, dev/test environments.

**Cost Tip:** T instances are often the cheapest option for light, variable workloads.
</details>

---

### Q4. Looking at the instance name `r5.2xlarge`, what does the "5" represent?

A) Number of vCPUs  
B) Generation number  
C) Memory size  
D) Network bandwidth

<details><summary>Answer</summary>

**B) Generation number**

**Why:** EC2 naming format is: `[family][generation].[size]`. The "5" means this is the 5th generation of the R family. Higher generations = newer hardware.

**Format:** `r5.2xlarge` = R family, 5th gen, 2xlarge size.
</details>

---

### Q5. Which instance family should be used for a data warehouse running Apache Hadoop that requires high disk throughput?

A) T family  
B) C family  
C) I, D, or H family  
D) M family

<details><summary>Answer</summary>

**C) I, D, or H family (Storage Optimized)**

**Why:** Storage optimized instances are designed for workloads requiring high sequential read/write access to large datasets—perfect for data warehouses, HDFS, and distributed file systems.

**Memory Tip:** **I** = **I**ntense I/O, **D** = **D**ense storage, **H** = **H**DFS/Hadoop.
</details>

---

## Section 2: EC2 Pricing Models (6 Questions)

### Q6. A pharmaceutical company runs computational drug discovery jobs that can be interrupted and restarted without issue. Which pricing model offers the MAXIMUM cost savings?

A) On-Demand Instances  
B) Reserved Instances  
C) Spot Instances  
D) Dedicated Hosts

<details><summary>Answer</summary>

**C) Spot Instances**

**Why:** Spot Instances offer up to 90% discount vs On-Demand. They can be interrupted with 2-minute warning, so they're perfect for fault-tolerant batch processing like drug discovery simulations.

**Key Points:** Spot = maximum savings, but only for interruptible workloads.
</details>

---

### Q7. An enterprise runs a mission-critical database that must be available 24/7 for the next 3 years. Which pricing model provides the BEST value?

A) On-Demand Instances  
B) Reserved Instances (3-year)  
C) Spot Instances  
D) Savings Plans

<details><summary>Answer</summary>

**B) Reserved Instances (3-year)**

**Why:** For steady-state, predictable workloads running 24/7, Reserved Instances (1 or 3 year) offer up to 72% discount. 3-year terms give the highest discount.

**Decision Rule:** Predictable + 24/7 = Reserved Instances or Savings Plans.
</details>

---

### Q8. A startup is testing a new application and needs EC2 instances for 2 weeks. They cannot predict exactly which instance types they'll need. Which pricing is MOST appropriate?

A) Reserved Instances  
B) On-Demand Instances  
C) Spot Instances  
D) Dedicated Hosts

<details><summary>Answer</summary>

**B) On-Demand Instances**

**Why:** Short-term (2 weeks), unpredictable usage, and no fault tolerance requirements = On-Demand. No commitment, pay by the second, terminate anytime.

**Key Rule:** Can't commit? Can't be interrupted? → On-Demand.
</details>

---

### Q9. A software company needs to use their existing Windows Server licenses that require dedicated physical servers. Which option should they choose?

A) On-Demand Instances  
B) Reserved Instances  
C) Spot Instances  
D) Dedicated Hosts

<details><summary>Answer</summary>

**D) Dedicated Hosts**

**Why:** Dedicated Hosts provide an entire physical server for your use, enabling BYOL (Bring Your Own License) for software like Windows Server, SQL Server, etc.

**Use Cases:** BYOL licensing, compliance requiring dedicated hardware.
</details>

---

### Q10. Which EC2 pricing option allows you to commit to a consistent $/hour spend while maintaining flexibility to change instance types, regions, and operating systems?

A) Standard Reserved Instances  
B) Convertible Reserved Instances  
C) Compute Savings Plans  
D) Spot Instances

<details><summary>Answer</summary>

**C) Compute Savings Plans**

**Why:** Compute Savings Plans let you commit to a $/hour spend for 1-3 years, but you can use any instance family, size, OS, or region. Maximum flexibility with significant savings.

**Savings Plans:** Flexible → Compute | Fixed → EC2 Instance.
</details>

---

### Q11. Which statement about Spot Instances is TRUE?

A) They provide guaranteed availability  
B) They can be interrupted with a 2-minute warning  
C) They require a minimum 1-year commitment  
D) They are best for databases

<details><summary>Answer</summary>

**B) They can be interrupted with a 2-minute warning**

**Why:** AWS can reclaim Spot capacity when needed, providing only a 2-minute warning. This is why Spot is only for fault-tolerant, interruptible workloads.

**Never use Spot for:** Databases, critical workloads, stateful applications.
</details>

---

## Section 3: Auto Scaling & Load Balancing (4 Questions)

### Q12. A web application experiences predictable traffic spikes every day at 9 AM when employees start work. Which Auto Scaling type should be used?

A) Dynamic Scaling  
B) Predictive Scaling  
C) Scheduled Scaling  
D) Simple Scaling

<details><summary>Answer</summary>

**C) Scheduled Scaling**

**Why:** When you KNOW traffic patterns (like 9 AM daily spike), use Scheduled Scaling to proactively add capacity before the spike hits.

**Predictive vs Scheduled:** Scheduled = YOU define times. Predictive = ML learns patterns.
</details>

---

### Q13. A gaming company needs a load balancer that provides ultra-low latency for their multiplayer game servers. Which load balancer should they use?

A) Application Load Balancer (ALB)  
B) Network Load Balancer (NLB)  
C) Classic Load Balancer (CLB)  
D) Gateway Load Balancer

<details><summary>Answer</summary>

**B) Network Load Balancer (NLB)**

**Why:** NLB operates at Layer 4 (TCP/UDP) and provides ultra-low latency—ideal for gaming, real-time applications, and high-performance scenarios.

**NLB Features:** Layer 4, static IP, ultra-low latency, millions of requests/sec.
</details>

---

### Q14. A company needs to route web traffic to different backend services based on the URL path (e.g., /api goes to API servers, /images goes to image servers). Which load balancer should they use?

A) Application Load Balancer (ALB)  
B) Network Load Balancer (NLB)  
C) Classic Load Balancer (CLB)  
D) Gateway Load Balancer

<details><summary>Answer</summary>

**A) Application Load Balancer (ALB)**

**Why:** ALB operates at Layer 7 (HTTP/HTTPS) and supports path-based routing, host-based routing, and is ideal for microservices architectures.

**ALB Features:** Layer 7, path/host routing, WebSocket, HTTP/2.
</details>

---

### Q15. Which EC2 placement group provides the LOWEST network latency for an HPC cluster?

A) Spread Placement Group  
B) Cluster Placement Group  
C) Partition Placement Group  
D) Availability Zone Placement

<details><summary>Answer</summary>

**B) Cluster Placement Group**

**Why:** Cluster placement groups put instances on the same rack in the same AZ, providing the lowest network latency—essential for HPC and tightly-coupled workloads.

**Trade-off:** Lowest latency, but single point of failure (all on same rack).
</details>

---

## Section 4: Storage Services (5 Questions)

### Q16. Which EBS volume type is REQUIRED for EC2 boot volumes?

A) st1 (Throughput HDD)  
B) sc1 (Cold HDD)  
C) gp2 or gp3 (General Purpose SSD)  
D) Any EBS type

<details><summary>Answer</summary>

**C) gp2 or gp3 (General Purpose SSD)**

**Why:** Boot volumes MUST be SSD (gp2, gp3, io1, or io2). HDD volumes (st1, sc1) cannot be used as boot volumes.

**Rule:** Boot = SSD only. Data = Any type.
</details>

---

### Q17. A database administrator needs the HIGHEST IOPS performance for their critical Oracle database. Which EBS volume type should they choose?

A) gp3 (General Purpose SSD)  
B) io2 (Provisioned IOPS SSD)  
C) st1 (Throughput HDD)  
D) sc1 (Cold HDD)

<details><summary>Answer</summary>

**B) io2 (Provisioned IOPS SSD)**

**Why:** io1/io2 volumes provide up to 64,000 IOPS—designed for I/O-intensive workloads like databases that require consistent, high performance.

**Use Case:** Critical databases, apps requiring sub-millisecond latency.
</details>

---

### Q18. A company needs shared file storage that multiple Linux EC2 instances can access simultaneously. Which service should they use?

A) EBS  
B) Instance Store  
C) EFS  
D) S3

<details><summary>Answer</summary>

**C) EFS (Elastic File System)**

**Why:** EFS is a managed NFS file system that can be mounted by multiple EC2 instances simultaneously across Availability Zones. EBS is attached to a single instance.

**EFS:** Shared + Linux + NFS = EFS.
</details>

---

### Q19. What happens to data on an Instance Store when the EC2 instance is stopped?

A) Data persists indefinitely  
B) Data is automatically backed up to S3  
C) Data is lost  
D) Data moves to EBS

<details><summary>Answer</summary>

**C) Data is lost**

**Why:** Instance Store is ephemeral storage physically attached to the host. When the instance stops, terminates, or the underlying hardware fails, ALL data is lost.

**Use Instance Store for:** Cache, buffers, scratch data, temporary files—NEVER for permanent data.
</details>

---

### Q20. Which storage characteristic is TRUE about EBS volumes?

A) They are region-scoped  
B) They are AZ-scoped  
C) They can be attached to multiple instances simultaneously  
D) They lose data when detached

<details><summary>Answer</summary>

**B) They are AZ-scoped**

**Why:** EBS volumes exist within a single Availability Zone. To use in another AZ, you must create a snapshot and restore it.

**Key Point:** EBS = AZ-scoped. EFS = Region-scoped.
</details>

---

## Section 5: S3 Storage Classes & Features (5 Questions)

### Q21. A company stores data with unpredictable access patterns—some files are accessed daily, others not for months. Which S3 storage class automatically optimizes costs?

A) S3 Standard  
B) S3 Standard-IA  
C) S3 Intelligent-Tiering  
D) S3 Glacier

<details><summary>Answer</summary>

**C) S3 Intelligent-Tiering**

**Why:** S3 Intelligent-Tiering automatically moves objects between access tiers based on changing access patterns—no retrieval fees, small monthly monitoring fee.

**Key Word:** "Unpredictable" or "unknown access patterns" = Intelligent-Tiering.
</details>

---

### Q22. A company must retain financial records for 7 years but rarely needs to access them. They can wait 12-48 hours for retrieval. Which is the MOST cost-effective storage class?

A) S3 Standard-IA  
B) S3 Glacier Flexible Retrieval  
C) S3 Glacier Deep Archive  
D) S3 One Zone-IA

<details><summary>Answer</summary>

**C) S3 Glacier Deep Archive**

**Why:** Deep Archive is the lowest-cost storage class, designed for long-term retention where 12-48 hour retrieval is acceptable. Perfect for compliance archives (7+ years).

**Retrieval Times:** Deep Archive = 12-48 hours. Glacier Flexible = minutes to hours.
</details>

---

### Q23. How can a company protect S3 objects from accidental deletion while still allowing legitimate deletions?

A) Enable Bucket Encryption  
B) Enable Versioning  
C) Enable Transfer Acceleration  
D) Enable Lifecycle Policies

<details><summary>Answer</summary>

**B) Enable Versioning**

**Why:** Versioning keeps multiple versions of objects. Deleted objects get a "delete marker" but previous versions remain recoverable. You can still delete, but accidents are reversible.

**Versioning Benefits:** Rollback, recovery, protection from accidental deletes.
</details>

---

### Q24. A healthcare company must store patient records in a way that NO ONE—not even the root user—can delete them for 7 years. Which S3 feature should they use?

A) S3 Versioning  
B) S3 Object Lock - Governance Mode  
C) S3 Object Lock - Compliance Mode  
D) S3 Lifecycle Policies

<details><summary>Answer</summary>

**C) S3 Object Lock - Compliance Mode**

**Why:** Compliance Mode enforces WORM (Write-Once-Read-Many)—absolutely no one, including root, can delete the objects until the retention period expires. Required for HIPAA, SEC, etc.

**Governance vs Compliance:** Governance = admins CAN delete. Compliance = NO ONE can delete.
</details>

---

### Q25. A company has users around the world uploading large files to an S3 bucket in us-east-1. How can they accelerate upload speeds?

A) Enable S3 Versioning  
B) Enable S3 Transfer Acceleration  
C) Use S3 Standard-IA  
D) Enable S3 Replication

<details><summary>Answer</summary>

**B) Enable S3 Transfer Acceleration**

**Why:** Transfer Acceleration uses CloudFront edge locations to accelerate uploads. Users upload to the nearest edge location, then AWS's optimized network transfers to S3.

**Use Case:** Global users uploading to a central bucket. Large file transfers.
</details>

---

## Score Tracker

| Section | Questions | Your Score |
|---------|-----------|------------|
| EC2 Instance Types | Q1-Q5 | ___ / 5 |
| EC2 Pricing | Q6-Q11 | ___ / 6 |
| Auto Scaling & ELB | Q12-Q15 | ___ / 4 |
| Storage Services | Q16-Q20 | ___ / 5 |
| S3 Storage Classes | Q21-Q25 | ___ / 5 |
| **Total** | **25** | **___ / 25** |

---

## Score Interpretation

| Score | Verdict | Action |
|-------|---------|--------|
| 23-25 | ✅ Ready for Day 5 | Great job! Move on |
| 20-22 | 🟡 Almost there | Review missed topics |
| 15-19 | ⚠️ Needs work | Re-read resource, retake quiz |
| <15 | ❌ Not ready | Study resource thoroughly first |

---

## Weak Area Review Guide

| If you missed... | Review this section in Day 4 Resource |
|------------------|--------------------------------------|
| Q1-Q5 | Part 1: EC2 Instance Families |
| Q6-Q11 | Part 2: EC2 Pricing Models |
| Q12-Q15 | Part 2.6-2.8: Auto Scaling, ELB, Placement Groups |
| Q16-Q20 | Part 4-6: EBS, Instance Store, EFS |
| Q21-Q25 | Part 7-8: S3 Storage Classes & Features |

---

## Key Concepts Quick Reference

### EC2 Pricing Decision Tree
```
Predictable 24/7? → Reserved/Savings Plans
Can be interrupted? → Spot (90% off)
Unpredictable/short? → On-Demand
Need dedicated hardware? → Dedicated Hosts
```

### Storage Decision Tree
```
Boot volume? → EBS SSD (gp3/io2)
Shared file storage? → EFS
Temporary/cache? → Instance Store
Object storage? → S3
```

### S3 Storage Class Decision
```
Frequent access → Standard
Unknown pattern → Intelligent-Tiering
Monthly access → Standard-IA
Archive (hours wait) → Glacier Flexible
Archive (12-48 hrs) → Glacier Deep Archive
```
