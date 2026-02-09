# Amazon RDS (Relational Database Service)

> "Your database, AWS's problem — they manage the server, you focus on the data."

## What RDS Does

```
✅ Managed relational database (SQL)
✅ Automated backups, patching, and software updates
✅ Multi-AZ for high availability
✅ Read Replicas for performance
✅ Encryption at rest and in transit
```

---

## RDS Architecture Overview

```
AMAZON RDS: MANAGED DATABASE

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                          AWS MANAGES                                     │
    │                                                                          │
    │   ┌───────────────────────────────────────────────────────────────┐     │
    │   │                      AMAZON RDS                                │     │
    │   │                                                                │     │
    │   │    ┌─────────────────────────────────────────────────────┐    │     │
    │   │    │              YOUR DATABASE                           │    │     │
    │   │    │                                                      │    │     │
    │   │    │   ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐     │    │     │
    │   │    │   │MySQL │ │Postgr│ │Maria │ │Oracle│ │  SQL │     │    │     │
    │   │    │   │      │ │  SQL │ │  DB  │ │      │ │Server│     │    │     │
    │   │    │   └──────┘ └──────┘ └──────┘ └──────┘ └──────┘     │    │     │
    │   │    │                      ┌──────────────┐               │    │     │
    │   │    │                      │   AURORA     │               │    │     │
    │   │    │                      │ MySQL/Postgr │               │    │     │
    │   │    │                      └──────────────┘               │    │     │
    │   │    └──────────────────────────────────────────────────────┘    │     │
    │   │                                                                │     │
    │   │   AWS Handles:                                                 │     │
    │   │   • Hardware provisioning     • Patching                      │     │
    │   │   • Database setup            • Automated backups             │     │
    │   │   • Multi-AZ failover         • Monitoring                    │     │
    │   └───────────────────────────────────────────────────────────────┘     │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                          YOU MANAGE                                      │
    │                                                                          │
    │   • Application optimization      • Schema design                        │
    │   • Query tuning                  • Your data                            │
    │   • Access controls (IAM)                                                │
    └─────────────────────────────────────────────────────────────────────────┘
```

---

## Supported Database Engines

| Engine | Type | Notes |
|--------|------|-------|
| **MySQL** | Open Source | Most popular web database |
| **PostgreSQL** | Open Source | Advanced features, JSON support |
| **MariaDB** | Open Source | MySQL fork with enhancements |
| **Oracle** | Commercial | Enterprise, high-security |
| **SQL Server** | Commercial | Microsoft ecosystem |
| **Aurora** | AWS-Native | MySQL/PostgreSQL compatible, 5x faster |

> [!TIP]
> **Exam Tip**: For CLF-C02, just know there are **6 engines** (5 traditional + Aurora). You don't need to memorize specifics of each.

---

## 🔄 Multi-AZ vs Read Replicas

### What is Multi-AZ?

> **Memory Hook**: "Multi-AZ = Your **standby pilot**. If the captain goes down, the copilot takes over instantly."

**Multi-AZ** creates a **synchronous standby copy** of your database in a different Availability Zone. 

- **Why it exists:** To survive hardware failures and AZ outages
- **How it works:** Every write goes to BOTH primary AND standby before confirming
- **Key point:** Standby does NOT serve reads — it's ONLY for failover

---

### What is a Read Replica?

> **Memory Hook**: "Read Replica = Your **assistant librarian**. Helps answer questions (reads), but can't update the catalog (writes)."

**Read Replica** creates an **asynchronous read-only copy** of your database to handle read traffic.

- **Why it exists:** To scale read-heavy workloads without overloading primary
- **How it works:** Changes copy to replicas in the background (slight delay)
- **Key point:** Read-only! All writes must still go to primary

---

### Visual: Multi-AZ vs Read Replicas

```
MULTI-AZ: HIGH AVAILABILITY

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                           AWS REGION                                     │
    │                                                                          │
    │      AZ-a (Primary)                    AZ-b (Standby)                   │
    │                                                                          │
    │      ┌─────────────┐                   ┌─────────────┐                  │
    │      │  PRIMARY    │  Synchronous     │   STANDBY   │                  │
    │      │  DATABASE   │ ═══════════════► │   (Copy)    │                  │
    │      │ Read/Write  │  Replication     │  Promoted   │                  │
    │      └──────┬──────┘                   │  on Fail    │                  │
    │             │                          └─────────────┘                  │
    │             │                                                            │
    │             ▼                                                            │
    │      ┌─────────────┐                                                    │
    │      │ Application │   If primary fails → Automatic failover!           │
    │      └─────────────┘                                                    │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘


READ REPLICAS: PERFORMANCE SCALING

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                                                                          │
    │                        ┌─────────────┐                                  │
    │                        │   PRIMARY   │                                  │
    │                        │ Read/Write  │                                  │
    │                        └──────┬──────┘                                  │
    │                               │ Asynchronous                            │
    │              ┌────────────────┼────────────────┐                        │
    │              │                │                │                        │
    │              ▼                ▼                ▼                        │
    │      ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                 │
    │      │  REPLICA 1  │  │  REPLICA 2  │  │  REPLICA 3  │                 │
    │      │  (Read-Only)│  │  (Read-Only)│  │  (Cross-Reg)│                 │
    │      └─────────────┘  └─────────────┘  └─────────────┘                 │
    │           Same AZ          Same AZ        Different                     │
    │                                            Region                        │
    │                                                                          │
    │      Use for: Reporting, analytics, read-heavy workloads                │
    └─────────────────────────────────────────────────────────────────────────┘
```

### Multi-AZ vs Read Replicas Comparison

| Feature | Multi-AZ | Read Replicas |
|---------|----------|---------------|
| **Purpose** | High Availability | Read Performance |
| **Synchronization** | Synchronous | Asynchronous |
| **Failover** | Automatic | Manual promotion |
| **Read Traffic** | No (standby) | Yes |
| **Cross-Region** | No | Yes |
| **Max Replicas** | 1 standby | Up to 15 |

---

### How Multi-AZ Failover Actually Works

```
FAILOVER TIMELINE

    0s: PRIMARY database fails
         │  (hardware failure, AZ outage, maintenance)
         ▼
    0-30s: AWS detects failure
         │  (continuous health checks)
         ▼
    30-60s: STANDBY promoted to PRIMARY
         │  (automatic, no manual intervention)
         ▼
    60-120s: DNS record updated
         │  (endpoint now points to new PRIMARY)
         ▼
    Application reconnects automatically
         │  (no code changes needed!)
         ▼
    ✅ Service restored (total: 1-2 minutes)
```

**What happens to your writes during failover?**
```
DURING FAILOVER

    Your App                 RDS
       │                      │
       │  Write request       │
       │───────────────────►  │
       │                      │  PRIMARY down!
       │  ❌ Connection error │
       │◄───────────────────  │
       │                      │
       │  (60-120s later)     │  DNS updated
       │                      │
       │  Retry write         │
       │───────────────────►  │  NEW PRIMARY
       │  ✅ Success          │
       │◄───────────────────  │
```

---

### Why Synchronous vs Asynchronous Matters

| Aspect | Synchronous (Multi-AZ) | Asynchronous (Read Replicas) |
|--------|------------------------|------------------------------|
| **How it works** | Write waits for BOTH copies | Write returns immediately, copy happens later |
| **Data on failure** | **ZERO data loss** | Possible **seconds of data loss** |
| **Write speed** | Slightly slower | Faster |
| **Best for** | Production databases | Read scaling, analytics |

```
SYNCHRONOUS (Multi-AZ)

    App writes "Order #123"
           │
           ▼
    ┌─────────────┐      ┌─────────────┐
    │   PRIMARY   │ ───► │   STANDBY   │
    │  Write data │      │  Confirm!   │
    └──────┬──────┘      └─────────────┘
           │
           ▼
    ✅ "Success" returned to App
    
    → Write isn't complete until BOTH have the data


ASYNCHRONOUS (Read Replicas)

    App writes "Order #123"
           │
           ▼
    ┌─────────────┐
    │   PRIMARY   │
    │  Write data │──────────┐
    └──────┬──────┘          │ (background copy)
           │                 ▼
    ✅ "Success" returned    ┌─────────────┐
       immediately           │   REPLICA   │
                             │  (delayed)  │
                             └─────────────┘
    
    → Data might be seconds behind on replica
```

---

### ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Multi-AZ standby serves read queries" | **NO!** Standby is ONLY for failover. It does NOT handle any traffic. | ⚠️ Yes |
| "Read Replicas have automatic failover" | **NO!** You must MANUALLY promote a replica to become primary. | ⚠️ Yes |
| "Multi-AZ protects against region failure" | **NO!** Multi-AZ only spans AZs in ONE region. Use cross-region Read Replica for DR. | ⚠️ Yes |
| "Replicas always have the same data as primary" | **NO!** Due to async replication, replicas can be seconds behind (replication lag). | ⚠️ Yes |

---

### 🎯 Decision Scenarios

**Scenario 1: E-commerce checkout system**
> "We process payments and can't afford ANY data loss."

**Answer:** Multi-AZ
**Why:** Synchronous replication guarantees zero data loss. Even if primary fails, standby has identical data. Automatic failover keeps you online.

---

**Scenario 2: Analytics dashboard with heavy reads**
> "Thousands of users running reports are slowing down our database."

**Answer:** Read Replicas
**Why:** Offload read traffic to replicas. A few seconds of data lag is acceptable for analytics. Primary can focus on writes.

---

**Scenario 3: Disaster recovery across regions**
> "If the entire us-east-1 region goes down, we need a backup."

**Answer:** Cross-Region Read Replica + Multi-AZ in primary region
**Why:** Multi-AZ doesn't span regions. Create a read replica in another region (e.g., us-west-2) for regional DR.

---

**Scenario 4: Dev/Test environment**
> "I need a database for development. Cost is the main concern."

**Answer:** Single-AZ (no Multi-AZ, no replicas)
**Why:** Multi-AZ doubles cost. For non-production, single-AZ is sufficient.

---

## ⚡ RDS vs Aurora

> **Memory Hook**: "Aurora = AWS's **supercharged** RDS"

| Aspect | Standard RDS | Aurora |
|--------|--------------|--------|
| **Design** | Managed wrapper | Cloud-native |
| **Performance** | Engine-dependent | **5x MySQL, 3x PostgreSQL** |
| **Storage** | Fixed size | Auto-scales to **128 TB** |
| **Replicas** | Up to 5 | Up to **15** |
| **Availability** | Multi-AZ | **6 copies across 3 AZs** |
| **Serverless** | No | **Yes (Aurora Serverless)** |
| **Cost** | Engine-based | Lower TCO for high workloads |

### Aurora Special Features

| Feature | What It Does |
|---------|--------------|
| **Aurora Serverless** | Auto-scales compute (pay per use) |
| **Aurora Global Database** | Cross-region replication (<1s lag) |
| **Aurora Backtrack** | Rewind database to any point |

---

## RDS Key Features

### Automated Backups

```
AUTOMATED BACKUPS

    ┌──────────────────────────────────────────────────────────────┐
    │                                                               │
    │   Daily Automated Snapshots                                   │
    │   ────────────────────────                                   │
    │                                                               │
    │   Mon    Tue    Wed    Thu    Fri    Sat    Sun              │
    │    │      │      │      │      │      │      │               │
    │    ▼      ▼      ▼      ▼      ▼      ▼      ▼               │
    │   [📷]  [📷]   [📷]   [📷]   [📷]   [📷]   [📷]              │
    │                                                               │
    │   Retention: 0-35 days (default: 7 days)                     │
    │   Point-in-Time Recovery: Restore to any second!             │
    │                                                               │
    └──────────────────────────────────────────────────────────────┘
```

### Encryption

| Encryption Type | Details |
|-----------------|---------|
| **At Rest** | AWS KMS (enabled at creation) |
| **In Transit** | SSL/TLS |
| **Read Replicas** | Inherit encryption from primary |

---

## 🆚 RDS vs DynamoDB

| Aspect | RDS (Relational) | DynamoDB (NoSQL) |
|--------|------------------|------------------|
| **Data Model** | Tables with schemas | Key-value documents |
| **Query Language** | SQL | API-based |
| **Scaling** | Vertical + Read Replicas | Horizontal (auto) |
| **Best For** | Joins, transactions, ACID | High-velocity, simple queries |
| **Example** | E-commerce orders, CMS | Gaming leaderboards, IoT |
| **Serverless?** | Aurora Serverless only | Yes (fully) |

### When to Use Each

| Scenario | Choose |
|----------|--------|
| Complex SQL queries with JOINs | **RDS** |
| ACID transactions required | **RDS** |
| Existing MySQL/PostgreSQL app | **RDS** |
| Key-value with massive scale | **DynamoDB** |
| Single-digit millisecond latency | **DynamoDB** |
| Unpredictable traffic patterns | **DynamoDB** |

---

## 🆚 RDS vs Database on EC2

> **Memory Hook**: "RDS = AWS drives the car. EC2 = You drive, you maintain."

| Aspect | **Amazon RDS** (Managed) | **DB on EC2** (Self-Managed) |
|--------|--------------------------|------------------------------|
| **Setup** | Minutes, automated | Hours/Days, manual config |
| **Patching** | AWS handles it | You do it (risk of downtime) |
| **Backups** | Automated, point-in-time recovery | Manual setup, your responsibility |
| **High Availability** | One-click Multi-AZ | Complex setup (replication, failover) |
| **Scaling** | Push-button vertical + Read Replicas | Manual migration, complex |
| **Cost** | Higher base cost | Lower (but hidden ops cost) |
| **Control** | Limited (no OS access) | Full control (OS, tuning, plugins) |
| **Engine Choice** | 6 supported engines | **Anything** (MongoDB, Cassandra, custom forks...) |

### When to Choose RDS

| Scenario | Why RDS |
|----------|---------|
| Standard SQL database (MySQL, PostgreSQL, etc.) | Fully supported, optimized |
| Want zero operational burden | AWS handles backups, patching, HA |
| Need Multi-AZ failover | One-click setup, automatic |
| Team lacks dedicated DBA | Reduced complexity |

### When to Choose EC2

| Scenario | Why EC2 |
|----------|---------|
| Need unsupported database (MongoDB, CockroachDB) | RDS only supports 6 engines |
| Require OS-level access | Custom tuning, plugins, scripts |
| Highly specialized configurations | RDS has limits on what you can configure |
| Cost optimization at scale | You can manage ops efficiently |

> [!TIP]
> **Exam Tip**: The trade-off is always **Convenience vs Control**.  
> RDS = Managed, automated, less control  
> EC2 = Full control, more responsibility

---

## Common Exam Questions

**Q1**: A company needs a managed MySQL database with automatic failover for their production application. Which service and feature should they use?
> **Amazon RDS with Multi-AZ** - Provides synchronous replication and automatic failover to a standby in another AZ.

**Q2**: A company has a read-heavy application and wants to reduce load on their primary database. What should they implement?
> **RDS Read Replicas** - Create up to 15 read replicas to offload read traffic from the primary database.

**Q3**: Which database service is 5x faster than MySQL and designed by AWS for the cloud?
> **Amazon Aurora** - Cloud-native, MySQL/PostgreSQL compatible with superior performance.

**Q4**: A company needs a database that automatically scales compute capacity based on application demand. Which service should they use?
> **Aurora Serverless** - Automatically adjusts capacity based on actual usage, pay per second.

**Q5**: What is the maximum retention period for automated RDS backups?
> **35 days** - Automated backups can be retained for 0-35 days.

**Q6**: A company wants to perform analytics queries without impacting their production RDS database. What should they do?
> **Create a Read Replica** - Offload analytical queries to read replicas to avoid impacting production.

**Q7**: Which AWS service would you use to migrate an on-premises Oracle database to Aurora PostgreSQL?
> **AWS DMS (Database Migration Service)** with **SCT (Schema Conversion Tool)** for heterogeneous migration.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **RDS** | "Managed SQL database" - 6 engines |
| **Multi-AZ** | "High Availability" - Automatic failover |
| **Read Replicas** | "Performance" - Scale reads, up to 15 |
| **Aurora** | "Supercharged RDS" - 5x MySQL, auto-scale |
| **Aurora Serverless** | "Pay per use" - Variable workloads |
| **Backups** | 35 days max retention |
| **RDS vs DynamoDB** | SQL/schema vs NoSQL/key-value |

---

## 🔗 Related Topics

- [Amazon Aurora](aurora.md) - Cloud-native RDS engine
- [DynamoDB](dynamodb.md) - NoSQL alternative
- [ElastiCache](elasticache.md) - Caching for RDS
- [AWS DMS](dms.md) - Database migration
