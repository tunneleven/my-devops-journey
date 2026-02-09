# Amazon Aurora

> "Aurora = RDS on steroids — same MySQL/PostgreSQL, 5x faster, cloud-native architecture."

## What Aurora Does

```
✅ Fully managed relational database (MySQL and PostgreSQL compatible)
✅ Up to 5x faster than MySQL, 3x faster than PostgreSQL on RDS
✅ Auto-scaling storage (10 GB to 128 TB, no pre-provisioning)
✅ High availability with 6 copies across 3 AZs by default
✅ Up to 15 low-latency read replicas
```

---

## Aurora vs Standard RDS: The Key Difference

> **Memory Hook**: "RDS = Renting an apartment. Aurora = Living in a smart home designed by AWS."

```
                    STANDARD RDS                           AURORA
                    ────────────                           ──────
                    
    ┌─────────────────────────────────┐      ┌─────────────────────────────────┐
    │           EC2 Instance          │      │         Aurora Instance         │
    │         ┌───────────┐           │      │         ┌───────────┐           │
    │         │  Database │           │      │         │  Database │           │
    │         │   Engine  │           │      │         │   Engine  │           │
    │         └─────┬─────┘           │      │         └─────┬─────┘           │
    │               │                 │      │               │                 │
    │         ┌─────▼─────┐           │      │               │ (Redo logs)     │
    │         │   EBS     │           │      │               ▼                 │
    │         │  Storage  │           │      │   ┌───────────────────────────┐ │
    │         │ (attached)│           │      │   │   SHARED CLUSTER VOLUME   │ │
    │         └───────────┘           │      │   │                           │ │
    │                                 │      │   │   AZ-a    AZ-b    AZ-c    │ │
    │    Storage tied to instance!    │      │   │   ┌──┐    ┌──┐    ┌──┐   │ │
    │                                 │      │   │   │📦│    │📦│    │📦│   │ │
    │                                 │      │   │   │📦│    │📦│    │📦│   │ │
    │                                 │      │   │   └──┘    └──┘    └──┘   │ │
    │                                 │      │   │   6 copies, auto-heals!  │ │
    │                                 │      │   └───────────────────────────┘ │
    └─────────────────────────────────┘      └─────────────────────────────────┘
    
    Compute + Storage = Coupled               Compute + Storage = Separated!
```

---

## 🧬 Aurora Architecture

### What Makes Aurora Different?

> **Memory Hook**: "Aurora separates the brain (compute) from the memory (storage) — they scale independently."

**Aurora's cloud-native design:**

1. **Distributed Storage Layer** — Data written to 6 copies across 3 AZs automatically
2. **Separation of Compute and Storage** — Replicas share the same storage volume
3. **Log-Based Writes** — Only sends redo logs (not pages) = faster replication
4. **Self-Healing** — Data blocks continuously scanned and repaired

---

### How Aurora Achieves 5x Performance

```
TRADITIONAL RDS                              AURORA
─────────────                               ──────

App → DB → Write to disk → Sync to standby   App → DB → Write redo log only
         → Acknowledge                                → Replicate to 6 nodes (quorum)
                                                     → Acknowledge when 4/6 confirm
                                                     
Multiple disk I/O operations                 Minimal I/O (just logs!)
                                             Storage handles the rest async
```

**Why it's faster:**
- No crash recovery replay (uses log-structured storage)
- No heavy disk writes — only redo logs sent over network
- Replicas read from shared storage (not shipped logs)

---

## 🚀 Aurora Flavors

### What is Aurora Provisioned?

> **Memory Hook**: "Provisioned = You pick the size. Like choosing a hotel room class."

Standard Aurora where you choose instance size (db.r5.large, db.r6g.xlarge, etc.)

- **When to use:** Predictable workloads with known capacity needs
- **Scaling:** Manual instance size changes + up to 15 read replicas

---

### What is Aurora Serverless?

> **Memory Hook**: "Serverless = Pay for what you sip. Like a metered coffee machine."

**Aurora Serverless** automatically scales compute capacity based on actual usage.

- **Why it exists:** Variable or unpredictable workloads, dev/test environments
- **How it works:** Scales up/down in ACUs (Aurora Capacity Units), can pause to $0
- **Key point:** No instance management — AWS handles scaling automatically

```
AURORA SERVERLESS SCALING

    Compute Capacity
          ▲
    8 ACU │                    ┌─────┐
          │                    │     │ Traffic spike
    4 ACU │           ┌────────┘     └───┐
          │           │                   │
    2 ACU │ ──────────┘                   └────────
          │
    0 ACU │ ═══════ (paused, $0 when idle) ═══════
          └──────────────────────────────────────────► Time
```

---

### What is Aurora Global Database?

> **Memory Hook**: "Global = One writer, readers everywhere. Like CNN broadcasting worldwide."

**Aurora Global Database** replicates data across multiple AWS Regions.

- **Why it exists:** Disaster recovery + low-latency global reads
- **How it works:** One primary Region (read/write), up to 5 secondary Regions (read-only)
- **Key point:** < 1 second replication lag, failover to secondary in < 1 minute

```
AURORA GLOBAL DATABASE

    ┌─────────────────────────────────────────────────────────────────────┐
    │                                                                     │
    │  PRIMARY REGION (us-east-1)         SECONDARY REGION (eu-west-1)   │
    │  ─────────────────────────          ────────────────────────────   │
    │                                                                     │
    │  ┌────────────────────────┐         ┌────────────────────────┐     │
    │  │   Aurora Cluster       │         │   Aurora Cluster       │     │
    │  │                        │ <1 sec  │                        │     │
    │  │  ┌────────┐            │ ─────►  │  ┌────────┐            │     │
    │  │  │ Writer │            │  async  │  │ Reader │ (promoted  │     │
    │  │  └────────┘            │         │  └────────┘  on DR)    │     │
    │  │  ┌────────┐ ┌────────┐ │         │  ┌────────┐ ┌────────┐ │     │
    │  │  │Reader 1│ │Reader 2│ │         │  │Reader 1│ │Reader 2│ │     │
    │  │  └────────┘ └────────┘ │         │  └────────┘ └────────┘ │     │
    │  │     │           │      │         │       │          │     │     │
    │  │     └─────┬─────┘      │         │       └────┬─────┘     │     │
    │  │           │            │         │            │           │     │
    │  │  ┌────────▼────────┐   │         │  ┌─────────▼────────┐  │     │
    │  │  │ Cluster Volume  │   │         │  │ Cluster Volume   │  │     │
    │  │  │  (3 AZs, 6x)    │   │         │  │  (3 AZs, 6x)     │  │     │
    │  │  └─────────────────┘   │         │  └──────────────────┘  │     │
    │  └────────────────────────┘         └────────────────────────┘     │
    │                                                                     │
    └─────────────────────────────────────────────────────────────────────┘
```

---

## Aurora vs RDS Comparison

| Aspect | **Standard RDS** | **Aurora** |
|--------|------------------|------------|
| **Performance** | Baseline engine speed | 5x MySQL / 3x PostgreSQL |
| **Storage** | EBS attached to instance | Shared cluster volume, auto-scales |
| **Replication** | Log shipping (lag) | Shared storage (< 100ms lag) |
| **Read Replicas** | Up to 5 | Up to 15 |
| **Failover Time** | 60-120 seconds | ~30 seconds |
| **Storage Scaling** | Manual, up to 64 TB | Auto, up to 128 TB |
| **Engines** | 6 engines (MySQL, PostgreSQL, Oracle, SQL Server, MariaDB, Aurora) | MySQL and PostgreSQL compatible only |
| **Cost** | Lower base cost | Higher, but better $/performance |
| **Serverless** | ❌ No | ✅ Aurora Serverless |
| **Global** | ❌ Cross-Region read replicas only | ✅ Aurora Global Database |

---

## 🧭 When to Use Aurora vs RDS

```
DECISION TREE

    Need MySQL or PostgreSQL?
              │
         ┌────┴────┐
         │         │
        YES        NO
         │         │
         ▼         ▼
    High performance    Need Oracle/SQL Server/MariaDB?
    requirements?              │
         │                ┌────┴────┐
    ┌────┴────┐          YES        Use RDS
    │         │           │         (those engines)
   YES        NO          ▼
    │         │         RDS
    ▼         ▼
 AURORA    Workload?
           ┌────┴────┐
           │         │
     Variable    Predictable
           │         │
           ▼         ▼
    Aurora Serverless   RDS (if cost-sensitive)
                       Aurora (if performance matters)
```

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Aurora supports Oracle and SQL Server" | **NO!** Aurora is MySQL and PostgreSQL compatible ONLY. | ⚠️ Yes |
| "Aurora Serverless runs 24/7" | **NO!** It can pause to $0 when not in use. | ⚠️ Yes |
| "Aurora has 5 read replicas like RDS" | **NO!** Aurora supports up to 15 read replicas. | ⚠️ Yes |
| "Aurora Global writes to all Regions" | **NO!** One primary Region writes. Secondaries are read-only. | ⚠️ Yes |
| "Aurora is just faster RDS" | **PARTIAL!** Architecture is completely different (separated compute/storage). | ⚠️ Yes |
| "Aurora is always more expensive" | **DEPENDS!** Better price/performance for high throughput workloads. | ⚠️ Sometimes |

---

## 🎯 Decision Scenarios

**Scenario 1: E-commerce with traffic spikes**
> "Black Friday causes 10x traffic. We can't predict when."

**Answer:** Aurora Serverless
**Why:** Auto-scales with demand, can pause during off-peak. No over-provisioning.

---

**Scenario 2: Global app with disaster recovery**
> "Users in US, Europe, Asia. Need fast reads everywhere and DR capability."

**Answer:** Aurora Global Database
**Why:** Primary in US, read-only clusters in EU/Asia. < 1 second replication for DR failover.

---

**Scenario 3: High-transaction banking application**
> "MySQL database struggles under load. Need 5x performance boost."

**Answer:** Aurora (MySQL compatible)
**Why:** Drop-in replacement for MySQL with 5x performance. No code changes needed.

---

**Scenario 4: Need Oracle database**
> "Our ERP runs on Oracle. Want managed database in AWS."

**Answer:** RDS for Oracle (NOT Aurora!)
**Why:** Aurora only supports MySQL/PostgreSQL. RDS supports Oracle.

---

**Scenario 5: Dev/test environment**
> "Developers need database access, but only during work hours."

**Answer:** Aurora Serverless
**Why:** Pauses when idle ($0), starts automatically when accessed. Perfect for intermittent usage.

---

## Common Exam Questions

**Q1**: A company wants a MySQL-compatible database with automatic storage scaling and up to 15 read replicas. Which service should they choose?
> **Aurora** - Supports MySQL compatible, auto-scales to 128 TB, and up to 15 read replicas.

**Q2**: Which Aurora feature allows the database to automatically scale compute capacity based on demand and pause when not in use?
> **Aurora Serverless** - Scales in ACUs, can pause to zero during inactivity.

**Q3**: A company needs low-latency reads for users across multiple AWS Regions. Which Aurora feature should they use?
> **Aurora Global Database** - Replicates to up to 5 secondary Regions with < 1 second lag.

**Q4**: How many copies of data does Aurora maintain across how many Availability Zones?
> **6 copies across 3 AZs** - Aurora automatically replicates data 6 ways for durability.

**Q5**: A company needs to run Oracle database in AWS with automated backups and patching. Should they use Aurora?
> **No, use RDS for Oracle** - Aurora only supports MySQL and PostgreSQL.

**Q6**: What makes Aurora faster than standard RDS MySQL?
> **Distributed storage architecture** - Separated compute/storage, log-based writes, and quorum-based replication minimize I/O.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **Aurora** | "RDS on steroids — 5x MySQL, 3x PostgreSQL" |
| **Aurora vs RDS** | "Separated storage vs attached EBS" |
| **6 copies / 3 AZs** | "Aurora's durability default" |
| **15 replicas** | "Aurora's read scaling limit" |
| **Aurora Serverless** | "Pay per sip — scales and pauses automatically" |
| **Aurora Global** | "One writer, worldwide readers" |
| **MySQL/PostgreSQL only** | "Aurora doesn't do Oracle/SQL Server!" |

---

## 🔗 Related Topics

- [Amazon RDS](rds.md) - Managed relational databases
- [DynamoDB](dynamodb.md) - NoSQL alternative
- [Read Replicas vs Multi-AZ](rds.md#multi-az-vs-read-replicas) - HA and scaling patterns
