# AWS Storage Services (Snow, Gateway, Backup, DataSync)

> "Move data to the cloud your way — ship it, bridge it, sync it, or back it up."

## What These Services Do

```
✅ Snow Family     → Physical devices for offline data transfer (TB to EB)
✅ Storage Gateway → Hybrid cloud bridge (on-premises ↔ AWS)
✅ AWS Backup      → Centralized backup management for all AWS services
✅ DataSync        → Fast network-based data sync and migration
```

---

## Service Overview

```
AWS STORAGE SERVICES LANDSCAPE

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                         DATA TRANSFER & STORAGE                          │
    │                                                                          │
    │   ON-PREMISES                                       AWS CLOUD            │
    │   ────────────                                      ─────────            │
    │                                                                          │
    │   ┌──────────────┐                                  ┌────────────────┐  │
    │   │ Data Center  │                                  │      S3        │  │
    │   │              │─── Snow Family (truck/device) ──►│   Glacier      │  │
    │   │  100+ TB     │        Physical transport        │                │  │
    │   └──────────────┘                                  └────────────────┘  │
    │                                                                          │
    │   ┌──────────────┐                                  ┌────────────────┐  │
    │   │ File Server  │                                  │      S3        │  │
    │   │ NFS/SMB      │─── Storage Gateway (cache) ────►│   EBS/Glacier  │  │
    │   │              │        Hybrid bridge             │                │  │
    │   └──────────────┘                                  └────────────────┘  │
    │                                                                          │
    │   ┌──────────────┐                                  ┌────────────────┐  │
    │   │ NAS/SAN      │                                  │   S3 / EFS     │  │
    │   │              │─── DataSync (network agent) ───►│     FSx        │  │
    │   │              │        Fast online sync          │                │  │
    │   └──────────────┘                                  └────────────────┘  │
    │                                                                          │
    │                                                     ┌────────────────┐  │
    │                                                     │   AWS Backup   │  │
    │                                                     │  (Centralized) │  │
    │                                                     │ EC2,EBS,RDS,S3 │  │
    │                                                     └────────────────┘  │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘
```

---

## ❄️ AWS Snow Family

> **Memory Hook**: "**Snow** = **Ship** your data physically when internet is too slow"

### What is Snow Family?

Snow Family is a collection of **physical devices** that AWS ships to your location for **offline data transfer**. You load your data onto the device and ship it back — faster than internet transfer for large datasets.

---

### What is Snowcone?

> **Memory Hook**: "Snowcone = **Backpack courier** — small, portable, goes anywhere"

**Snowcone** is the smallest Snow device, small enough to fit in a backpack.

- **Why it exists:** Edge locations with limited space/connectivity
- **Key point:** Can be battery-powered for remote locations
- **Capacity:** 8 TB SSD or 14 TB HDD

---

### What is Snowball Edge?

> **Memory Hook**: "Snowball Edge = **Moving van** — the workhorse for most migrations"

**Snowball Edge** is a suitcase-sized device for large data transfers with optional compute power.

- **Why it exists:** Most common choice for TB-to-PB migrations
- **Key point:** Two types — Storage Optimized (80 TB) or Compute Optimized (52 vCPU + GPU)
- **Capacity:** 42-210 TB depending on variant

---

### What is Snowmobile?

> **Memory Hook**: "Snowmobile = **Data center on wheels** — for exabyte-scale moves"

**Snowmobile** is a literal shipping container truck that parks at your data center.

- **Why it exists:** When you're migrating an entire data center
- **Key point:** AWS sends it with security personnel and GPS tracking
- **Capacity:** 100 PB (100,000 TB!)

---

### Snow Family Size Comparison

```
SNOW FAMILY SIZE COMPARISON

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                                                                          │
    │   SNOWCONE              SNOWBALL EDGE              SNOWMOBILE           │
    │   ─────────             ─────────────              ──────────           │
    │                                                                          │
    │   ┌─────────┐           ┌─────────────┐           ┌─────────────────┐   │
    │   │  📦     │           │   📦📦📦    │           │  🚛 TRUCK       │   │
    │   │  Small  │           │   Medium    │           │  Data Center    │   │
    │   │  Box    │           │   Suitcase  │           │  on Wheels      │   │
    │   └─────────┘           └─────────────┘           └─────────────────┘   │
    │                                                                          │
    │   8 TB SSD              80-210 TB                 100 PB (Petabytes!)   │
    │   + 14 TB HDD                                                           │
    │                                                                          │
    │   Edge compute          Edge compute +            Massive migrations    │
    │   Small transfers       Large migrations          Entire data centers   │
    │                                                                          │
    │   Fits in backpack      Needs shipping            Needs parking lot!    │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘
```

### Snow Family Comparison

| Device | Capacity | Compute | Best For | Physical Size |
|--------|----------|---------|----------|---------------|
| **Snowcone** | 8 TB SSD / 14 TB HDD | 2 vCPU, 4 GB | Small transfers, edge | Fits in backpack |
| **Snowball Edge Storage** | 80 TB | 40 vCPU | Large migrations | Suitcase-sized |
| **Snowball Edge Compute** | 42 TB | 52 vCPU + GPU | Edge ML, processing | Suitcase-sized |
| **Snowmobile** | 100 PB | N/A | Exabyte migrations | Shipping container truck |

### When to Use Snow Family

```
DECISION: INTERNET vs SNOW

    Time to transfer via internet:
    
    Data Size    │ 100 Mbps       │ 1 Gbps         │ 10 Gbps
    ─────────────┼────────────────┼────────────────┼────────────────
    10 TB        │ 12 days        │ 1.2 days       │ 3 hours
    100 TB       │ 120 days       │ 12 days        │ 1.2 days
    1 PB         │ 3+ years       │ 120 days       │ 12 days
    
    RULE OF THUMB:
    ├── < 10 TB + good internet → DataSync (network)
    ├── 10 TB - 10 PB → Snowball Edge
    └── > 10 PB → Snowmobile
    
    OR: If transfer takes > 1 week over internet → Consider Snow!
```

---

## 🌉 AWS Storage Gateway

> **Memory Hook**: "**Gateway** = **Bridge** between on-premises and cloud"

### What is Storage Gateway?

Storage Gateway is a **hybrid cloud storage service** that connects your on-premises environment to AWS cloud storage. It caches frequently accessed data locally for low latency while storing the full dataset in AWS.

---

### What is File Gateway?

> **Memory Hook**: "File Gateway = **Cloud file server** — NFS/SMB to S3 behind the scenes"

**File Gateway** presents S3 buckets as NFS or SMB file shares to your on-premises applications.

- **Why it exists:** Apps see files, AWS stores objects in S3
- **How it works:** Local cache for recent files + S3 for infinite storage
- **Key point:** Each file becomes an S3 object automatically

---

### What is Volume Gateway?

> **Memory Hook**: "Volume Gateway = **Cloud hard drive** — iSCSI block storage with snapshots"

**Volume Gateway** provides block storage (iSCSI) with snapshots stored as EBS snapshots in S3.

- **Why it exists:** Databases and apps need block storage, not just files
- **How it works:** Cached mode (hot data local) or Stored mode (all data local)
- **Key point:** EBS snapshots can be restored to EC2 instances

---

### What is Tape Gateway?

> **Memory Hook**: "Tape Gateway = **Virtual tape library** — Glacier replaces your tape room"

**Tape Gateway** emulates a physical tape library, letting backup software write to virtual tapes in S3 Glacier.

- **Why it exists:** Enterprises have years of tape backup software/processes
- **How it works:** VTL interface → data goes to S3 Glacier or Deep Archive
- **Key point:** No more physical tape handling, retrieval, or storage costs

---

### Storage Gateway Types Diagram

```
STORAGE GATEWAY TYPES

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   FILE GATEWAY                 VOLUME GATEWAY              TAPE GATEWAY     │
│   ────────────                 ──────────────              ────────────     │
│                                                                              │
│   On-Prem App                  On-Prem App                 Backup App       │
│       │                            │                           │            │
│       ▼                            ▼                           ▼            │
│   ┌─────────┐                  ┌─────────┐                 ┌─────────┐      │
│   │ NFS/SMB │                  │  iSCSI  │                 │   VTL   │      │
│   │ Protocol│                  │ Protocol│                 │(Virtual │      │
│   └────┬────┘                  └────┬────┘                 │  Tape)  │      │
│        │                            │                      └────┬────┘      │
│        ▼                            ▼                           ▼           │
│   ┌─────────────┐              ┌─────────────┐             ┌─────────────┐  │
│   │ File Gateway│              │Volume Gateway│            │ Tape Gateway│  │
│   │  (Cache)    │              │  (Cache)     │            │  (Virtual)  │  │
│   └──────┬──────┘              └──────┬───────┘            └──────┬──────┘  │
│          │                            │                           │         │
│          ▼                            ▼                           ▼         │
│   ┌─────────────┐              ┌─────────────┐             ┌─────────────┐  │
│   │    S3       │              │ S3 + EBS    │             │  S3 Glacier │  │
│   │  (Objects)  │              │ (Snapshots) │             │  (Archives) │  │
│   └─────────────┘              └─────────────┘             └─────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Gateway Types Comparison

| Gateway | Protocol | Stores In | Best For |
|---------|----------|-----------|----------|
| **File Gateway** | NFS / SMB | S3 | File shares, media files |
| **Volume Gateway** | iSCSI | S3 + EBS Snapshots | Block storage, databases |
| **Tape Gateway** | VTL (Virtual Tape) | S3 Glacier | Backup, replace physical tapes |

### Gateway Use Cases

| Scenario | Gateway Type | Why |
|----------|--------------|-----|
| Replace on-prem file server | **File Gateway** | NFS/SMB to S3, infinite storage |
| Extend SAN to cloud | **Volume Gateway** | iSCSI block storage with snapshots |
| Replace tape library | **Tape Gateway** | Virtual tapes to Glacier |
| Hybrid cloud storage | **Any Gateway** | Low-latency cache + cloud backend |

---

## 💾 AWS Backup

> **Memory Hook**: "**Backup** = **One dashboard** for all AWS backups"

```
AWS BACKUP ARCHITECTURE

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                           AWS BACKUP                                     │
    │                     (Centralized Dashboard)                              │
    │                                                                          │
    │   ┌───────────────────────────────────────────────────────────────┐     │
    │   │                     BACKUP PLAN                                │     │
    │   │   • Schedule: Daily at 5 AM                                    │     │
    │   │   • Retention: 30 days                                         │     │
    │   │   • Cross-Region: us-west-2                                    │     │
    │   └───────────────────────────────────────────────────────────────┘     │
    │                               │                                          │
    │            ┌──────────────────┼──────────────────┐                      │
    │            │                  │                  │                      │
    │            ▼                  ▼                  ▼                      │
    │       ┌─────────┐       ┌─────────┐        ┌─────────┐                  │
    │       │   EC2   │       │   RDS   │        │   EFS   │                  │
    │       └─────────┘       └─────────┘        └─────────┘                  │
    │       ┌─────────┐       ┌─────────┐        ┌─────────┐                  │
    │       │   EBS   │       │DynamoDB │        │   S3    │                  │
    │       └─────────┘       └─────────┘        └─────────┘                  │
    │       ┌─────────┐       ┌─────────┐        ┌─────────┐                  │
    │       │   FSx   │       │Aurora   │        │ Storage │                  │
    │       └─────────┘       └─────────┘        │ Gateway │                  │
    │                                            └─────────┘                  │
    │                                                                          │
    │   Features:                                                              │
    │   ✅ Cross-region backup copies                                          │
    │   ✅ Cross-account backup copies                                         │
    │   ✅ Compliance reports and audit                                        │
    │   ✅ Point-in-time recovery                                              │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘
```

### Supported Services

| Service Type | Supported Services |
|--------------|-------------------|
| **Compute** | EC2 (including EBS) |
| **Storage** | EBS, EFS, S3, FSx |
| **Database** | RDS, Aurora, DynamoDB, DocumentDB, Neptune |
| **Hybrid** | Storage Gateway volumes |

---

## 🔄 AWS DataSync

> **Memory Hook**: "**DataSync** = **Fast network sync** between on-prem and cloud"

```
AWS DATASYNC ARCHITECTURE

    ┌────────────────────────────────────────────────────────────────────┐
    │                         AWS DATASYNC                                │
    │                                                                     │
    │   ON-PREMISES                              AWS CLOUD                │
    │                                                                     │
    │   ┌─────────────┐         Internet/        ┌─────────────────────┐ │
    │   │ NFS/SMB     │       Direct Connect     │        S3           │ │
    │   │ File Server │◄────────────────────────►│       EFS           │ │
    │   └──────┬──────┘   Up to 10 Gbps!         │       FSx           │ │
    │          │                                  └─────────────────────┘ │
    │          │                                                          │
    │   ┌──────▼──────┐                                                   │
    │   │  DataSync   │   Features:                                       │
    │   │   Agent     │   ✅ Automatic encryption                         │
    │   │  (VM/EC2)   │   ✅ Data validation                              │
    │   └─────────────┘   ✅ Bandwidth throttling                         │
    │                     ✅ Incremental sync                             │
    │                     ✅ Scheduled transfers                          │
    │                                                                     │
    └────────────────────────────────────────────────────────────────────┘
```

### DataSync vs Snow vs Gateway

| Aspect | DataSync | Snow Family | Storage Gateway |
|--------|----------|-------------|-----------------|
| **Method** | Network agent | Physical device | Hybrid cache |
| **Speed** | Up to 10 Gbps+ | Ship time | Cache-dependent |
| **Best for** | Migration, sync | Massive offline | Hybrid storage |
| **One-time or ongoing** | Both | Usually one-time | Ongoing |
| **Data size** | TB to PB | TB to EB | Any (streamed) |

---

## 🧭 Which Service Should I Use?

```
STORAGE SERVICE DECISION TREE

    Need to move large data to AWS?
              │
         ┌────┴────┐
         │         │
    ONLINE       OFFLINE
    (Network)    (Physical)
         │         │
         ▼         ▼
    ┌─────────┐   ┌───────────────┐
    │DataSync │   │ Snow Family   │
    │         │   │               │
    │ < 1 week│   │ > 1 week via  │
    │ transfer│   │ internet      │
    └─────────┘   └───────────────┘
    
    Need ongoing hybrid storage?
              │
              ▼
    ┌─────────────────┐
    │ Storage Gateway │
    │                 │
    │ File/Volume/Tape│
    └─────────────────┘
    
    Need centralized backup?
              │
              ▼
    ┌─────────────────┐
    │   AWS Backup    │
    │                 │
    │ One dashboard,  │
    │ all services    │
    └─────────────────┘
```

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Snowball works over the internet" | **NO!** Snowball is a PHYSICAL device you ship. DataSync is for network transfers. | ⚠️ Yes |
| "Storage Gateway replaces S3" | **NO!** Gateway is a BRIDGE. It uses S3/Glacier as backend storage. | ⚠️ Yes |
| "File Gateway and DataSync are the same" | **NO!** File Gateway = ongoing hybrid access. DataSync = migration/sync tool. | ⚠️ Yes |
| "AWS Backup creates its own storage" | **NO!** It manages backups but uses existing AWS storage (S3, etc.) | ⚠️ Yes |
| "Snowmobile is always the best for big data" | **NO!** Only use for >10 PB. For 80 TB, Snowball Edge is better and faster. | ⚠️ Yes |
| "Volume Gateway stores data on-prem only" | **NO!** It creates EBS snapshots in S3. Full data goes to cloud. | ⚠️ Yes |

---

## 🎯 Decision Scenarios

**Scenario 1: Migrate 200 TB, internet would take 3 months**
> "We need to move 200 TB to S3 but our 100 Mbps connection would take forever."

**Answer:** Snowball Edge (order 2-3 devices)
**Why:** Physical shipping takes days. 200 TB ÷ 80 TB = need 2-3 Snowball Edge devices. Much faster than 3 months over network.

---

**Scenario 2: Keep using existing file shares, unlimited storage**
> "Our apps use NFS file shares. We're running out of on-prem storage."

**Answer:** File Gateway
**Why:** Apps keep using NFS — no changes needed. Gateway caches hot data locally, stores everything in S3 for infinite capacity.

---

**Scenario 3: Replace physical tape backup**
> "We have 10 years of backup software and tape processes. Too expensive to maintain."

**Answer:** Tape Gateway
**Why:** VTL interface works with existing backup software (Veeam, NetBackup). Data goes to S3 Glacier — no more tape handling.

---

**Scenario 4: Sync files to S3 daily over fast network**
> "We need to copy changed files from our NAS to S3 every night."

**Answer:** DataSync (scheduled task)
**Why:** Agent-based, up to 10 Gbps, incremental sync. Perfect for ongoing scheduled migrations.

---

**Scenario 5: Central backup for EC2, RDS, DynamoDB**
> "We have 50 EC2 instances, 10 RDS databases, and DynamoDB. Need one backup dashboard."

**Answer:** AWS Backup
**Why:** Single policy for all services. Cross-region copies, retention rules, compliance reports — all in one place.

---

**Scenario 6: Edge computing in remote location**
> "We need local data processing at a mining site with no internet."

**Answer:** Snowball Edge Compute Optimized
**Why:** Has 52 vCPU + optional GPU for edge ML. Collect data, process locally, ship to AWS when done.

---

## Common Exam Questions

**Q1**: A company needs to migrate 50 TB of data to AWS but has slow internet connectivity (10 Mbps). What is the most efficient solution?
> **Snowball Edge** - Physical device for offline transfer. 50 TB over 10 Mbps would take months; shipping a Snowball takes days.

**Q2**: A company wants to keep using their existing NFS file shares while storing data in S3. Which service should they use?
> **AWS Storage Gateway (File Gateway)** - Provides NFS/SMB interface with S3 backend storage.

**Q3**: A company needs to centrally manage backups for EC2, RDS, and DynamoDB with cross-region copies. Which service provides this?
> **AWS Backup** - Single dashboard for all AWS service backups with cross-region and cross-account support.

**Q4**: A media company needs to replace their physical tape library for backup to reduce costs. Which AWS service can help?
> **Tape Gateway (Storage Gateway)** - Virtual tape library that stores data in S3 Glacier, compatible with existing backup software.

**Q5**: A company needs to continuously sync files from on-premises to S3 over their 1 Gbps connection. Which service is best?
> **AWS DataSync** - Agent-based service for fast, scheduled synchronization over network.

**Q6**: For an exabyte-scale data center migration, which Snow Family device is appropriate?
> **Snowmobile** - 100 PB capacity shipping container truck for massive migrations.

---

## Summary

| Service | Memory Hook | Best For |
|---------|-------------|----------|
| **Snowcone** | "Backpack size" (8-14 TB) | Small edge transfers |
| **Snowball Edge** | "Suitcase size" (80-210 TB) | Large migrations |
| **Snowmobile** | "Truck size" (100 PB) | Data center migrations |
| **File Gateway** | "NFS/SMB to S3" | Hybrid file shares |
| **Volume Gateway** | "iSCSI to snapshots" | Hybrid block storage |
| **Tape Gateway** | "Virtual tapes to Glacier" | Replace physical tapes |
| **AWS Backup** | "One dashboard, all backups" | Centralized backup |
| **DataSync** | "Fast network sync" | Online migration, sync |

---

## 🔗 Related Topics

- [Amazon S3](s3.md) - Object storage destination
- [Amazon EBS](ebs.md) - Block storage basics
- [Amazon EFS](efs.md) - File storage basics
- [S3 Glacier](s3.md#glacier) - Archive storage for tapes
