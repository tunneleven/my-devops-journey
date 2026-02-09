# AWS Specialty Databases

> "Right tool for the right job — AWS has a purpose-built database for every data model."

## Overview

```
AWS SPECIALTY DATABASES

┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   DATA MODEL           SERVICE              ICON       USE CASE              │
│   ──────────           ───────              ────       ────────              │
│                                                                              │
│   Document (JSON)      DocumentDB           📄         MongoDB workloads     │
│                                                                              │
│   Graph (Nodes)        Neptune              🕸️         Relationships, fraud  │
│                                                                              │
│   Time-Series          Timestream           ⏱️         IoT, metrics         │
│                                                                              │
│   Ledger (Immutable)   QLDB                 📒         Audit trails, finance │
│                                                                              │
│   Wide-Column          Keyspaces            📊         Cassandra workloads   │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 📄 Amazon DocumentDB

### What is DocumentDB?

> **Memory Hook**: "DocumentDB = **MongoDB in the cloud** — same API, zero ops"

**DocumentDB** is a fully managed document database compatible with MongoDB workloads.

- **Why it exists:** Run MongoDB applications without managing MongoDB clusters
- **How it works:** Stores JSON-like documents with flexible schemas
- **Key point:** MongoDB API compatible — migrate without code changes

```
DOCUMENT DATABASE CONCEPT

    ┌─────────────────────────────────────────────────┐
    │              USERS COLLECTION                   │
    │                                                 │
    │   {                      {                      │
    │     "_id": "user-123",     "_id": "user-456",  │
    │     "name": "Alice",       "name": "Bob",      │
    │     "email": "a@x.com",    "email": "b@x.com", │
    │     "age": 28,             "phone": "555-1234" │
    │     "tags": ["premium"]    // No age field!   │
    │   }                      }                      │
    │                                                 │
    │   Flexible schema — each document can differ!  │
    └─────────────────────────────────────────────────┘
```

### DocumentDB Use Cases

| Use Case | Why DocumentDB |
|----------|----------------|
| Content management | Flexible JSON documents for articles, posts |
| User profiles | Varying attributes per user |
| Catalogs | Products with different properties |
| Mobile backends | Schema flexibility for rapid iteration |

---

## 🕸️ Amazon Neptune

### What is Neptune?

> **Memory Hook**: "Neptune = **Social network detective** — finds fraud, friends, and connections"

**Neptune** is a fully managed graph database for highly connected data.

- **Why it exists:** Relational JOINs are slow for complex relationships
- **How it works:** Stores nodes (entities) and edges (relationships), traverses connections fast
- **Key point:** Supports Property Graph and RDF models

```
GRAPH DATABASE CONCEPT

                    RELATIONAL (Tables)
    ┌────────────────────────────────────────────────┐
    │  To find "friends of friends":                 │
    │                                                │
    │  SELECT ... FROM users u1                      │
    │  JOIN friendships f1 ON u1.id = f1.user_id    │
    │  JOIN users u2 ON f1.friend_id = u2.id        │
    │  JOIN friendships f2 ON u2.id = f2.user_id    │
    │  JOIN users u3 ON f2.friend_id = u3.id        │
    │                                                │
    │  😵 Complex JOINs, slow at scale!              │
    └────────────────────────────────────────────────┘

                    GRAPH (Neptune)
    ┌────────────────────────────────────────────────┐
    │                                                │
    │       Alice ──FRIEND─→ Bob ──FRIEND─→ Carol   │
    │         │                      │               │
    │         └──FRIEND─→ Dave ──────┘               │
    │                                                │
    │  Query: g.V('Alice').out('FRIEND').out('FRIEND') │
    │                                                │
    │  😊 Natural traversal, fast at any depth!     │
    └────────────────────────────────────────────────┘
```

### Neptune Use Cases

| Use Case | Why Neptune |
|----------|-------------|
| Social networks | Friend connections, followers |
| Fraud detection | Find suspicious transaction patterns |
| Recommendation engines | "Users who bought X also bought Y" |
| Knowledge graphs | Wikipedia-style interconnected data |
| Network/IT operations | Dependencies between systems |

---

## ⏱️ Amazon Timestream

### What is Timestream?

> **Memory Hook**: "Timestream = **Time machine for metrics** — trillions of IoT data points, fast"

**Timestream** is a serverless time-series database for timestamped data.

- **Why it exists:** Regular databases struggle with time-series queries at scale
- **How it works:** Optimized storage and functions for time-based data
- **Key point:** Serverless — automatically scales, built-in retention policies

```
TIME-SERIES DATABASE CONCEPT

    ┌─────────────────────────────────────────────────────────────┐
    │                  SENSOR READINGS                             │
    │                                                              │
    │   Time                Temperature    Humidity    Device      │
    │   ────                ───────────    ────────    ──────      │
    │   2024-01-15 10:00    22.5°C        45%         sensor-1    │
    │   2024-01-15 10:01    22.6°C        44%         sensor-1    │
    │   2024-01-15 10:02    22.7°C        44%         sensor-1    │
    │   2024-01-15 10:00    18.2°C        60%         sensor-2    │
    │   2024-01-15 10:01    18.3°C        59%         sensor-2    │
    │   ...billions of rows...                                     │
    │                                                              │
    │   Query: AVG(temperature) per hour for last 7 days          │
    │   Built-in: interpolation, smoothing, forecasting           │
    └─────────────────────────────────────────────────────────────┘
```

### Timestream Use Cases

| Use Case | Why Timestream |
|----------|----------------|
| IoT sensor data | Millions of devices, billions of readings |
| DevOps metrics | Application performance monitoring |
| Industrial telemetry | Factory equipment monitoring |
| Financial tickers | Stock prices over time |

---

## 📒 Amazon QLDB

### What is QLDB?

> **Memory Hook**: "QLDB = **Permanent ink ledger** — once written, never erased"

**QLDB** (Quantum Ledger Database) is a fully managed ledger database with immutable, cryptographically verifiable history.

- **Why it exists:** Some data MUST NEVER be modified (audit trails, compliance)
- **How it works:** Append-only journal, every change is recorded forever
- **Key point:** Cryptographic hashes prove data wasn't tampered with

```
LEDGER DATABASE CONCEPT

    ┌─────────────────────────────────────────────────────────────┐
    │                    QLDB JOURNAL (Immutable)                  │
    │                                                              │
    │   Block 1    Block 2    Block 3    Block 4                  │
    │   ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐                 │
    │   │Create│ → │Update│ → │Update│ → │Delete│                 │
    │   │$100  │   │$150  │   │$200  │   │(void)│                 │
    │   └──────┘   └──────┘   └──────┘   └──────┘                 │
    │      │          │          │          │                      │
    │      └──────────┴──────────┴──────────┘                      │
    │              Cryptographic chain                             │
    │                                                              │
    │   ❌ Cannot delete or modify history!                        │
    │   ✅ Can PROVE data wasn't changed (SHA-256 hash)           │
    └─────────────────────────────────────────────────────────────┘
```

### QLDB Use Cases

| Use Case | Why QLDB |
|----------|----------|
| Financial transactions | Audit trail for regulators |
| Supply chain | Track product history from origin |
| HR systems | Employee history, compensation changes |
| Healthcare | Patient record history |
| Insurance claims | Claim processing audit trail |

> [!IMPORTANT]
> QLDB is NOT blockchain. It's a centralized ledger controlled by one party (you). Use it when YOU need immutability, not decentralized consensus.

---

## 📊 Amazon Keyspaces

### What is Keyspaces?

> **Memory Hook**: "Keyspaces = **Cassandra without the headache** — wide-column, serverless"

**Keyspaces** is a serverless, scalable Apache Cassandra-compatible database.

- **Why it exists:** Run Cassandra workloads without managing Cassandra clusters
- **How it works:** Wide-column storage with Cassandra Query Language (CQL)
- **Key point:** Serverless — pay per request, auto-scales

```
WIDE-COLUMN DATABASE CONCEPT

    ┌─────────────────────────────────────────────────────────────┐
    │                    KEYSPACES TABLE                           │
    │                                                              │
    │   Row Key       Column1    Column2    Column3    ColumnN... │
    │   ───────       ───────    ───────    ───────    ────────   │
    │   user-123      email:a    name:Ali   age:28                │
    │   user-456      email:b    name:Bob   phone:555  zip:10001  │
    │   user-789      email:c    name:Cat                         │
    │                                                              │
    │   Each row can have DIFFERENT columns!                       │
    │   Designed for MASSIVE scale writes and reads.              │
    └─────────────────────────────────────────────────────────────┘
```

### Keyspaces Use Cases

| Use Case | Why Keyspaces |
|----------|---------------|
| Messaging systems | High-volume message storage |
| IoT data | Billions of device records |
| Gaming leaderboards | Fast writes, massive scale |
| Cassandra migrations | Move to AWS without code changes |

---

## Service Comparison

| Service | Data Model | Key Feature | Best For |
|---------|-----------|-------------|----------|
| **DocumentDB** | Document (JSON) | MongoDB compatible | MongoDB workloads |
| **Neptune** | Graph (nodes/edges) | Relationship traversal | Social, fraud, recommendations |
| **Timestream** | Time-series | Built-in time functions | IoT, metrics, monitoring |
| **QLDB** | Ledger (immutable) | Cryptographic verification | Audit trails, compliance |
| **Keyspaces** | Wide-column | Cassandra compatible | High-scale Cassandra apps |

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "DocumentDB IS MongoDB" | **NO!** It's MongoDB COMPATIBLE. AWS service, not MongoDB Inc. | ⚠️ Sometimes |
| "Neptune is for any database" | **NO!** Neptune is specifically for GRAPH data with relationships. | ⚠️ Yes |
| "QLDB is blockchain" | **NO!** QLDB is a centralized ledger. Blockchain is decentralized. | ⚠️ Yes |
| "Use Timestream for any data" | **NO!** Timestream is for TIME-SERIES data. Use DynamoDB for general key-value. | ⚠️ Yes |
| "Keyspaces requires cluster management" | **NO!** Keyspaces is serverless — no clusters to manage. | ⚠️ Sometimes |

---

## 🎯 Decision Scenarios

**Scenario 1: Migrating MongoDB application to AWS**
> "We have a MongoDB app and want managed database in AWS."

**Answer:** DocumentDB
**Why:** MongoDB API compatible. Migrate with minimal code changes.

---

**Scenario 2: Fraud detection in banking transactions**
> "Need to find suspicious patterns across millions of connected transactions."

**Answer:** Neptune
**Why:** Graph database excels at traversing relationships and finding patterns.

---

**Scenario 3: Factory IoT with 10,000 sensors**
> "Sensors report every second. Need to analyze trends over time."

**Answer:** Timestream
**Why:** Purpose-built for time-series data at massive scale. Built-in time functions.

---

**Scenario 4: Regulatory compliance requires audit trail**
> "Auditors need to verify no financial records were modified."

**Answer:** QLDB
**Why:** Immutable ledger with cryptographic verification. Proves data integrity.

---

**Scenario 5: High-scale messaging platform**
> "Billions of messages per day, need Cassandra-like performance."

**Answer:** Keyspaces
**Why:** Cassandra compatible, serverless, handles massive write volume.

---

## 🧭 Database Selection Flowchart

```
CHOOSING THE RIGHT DATABASE

    What type of data?
           │
    ┌──────┼──────┬──────────┬───────────┬────────────┐
    │      │      │          │           │            │
    ▼      ▼      ▼          ▼           ▼            ▼
 JSON   Graph   Time-    Immutable   Wide-      Key-Value/
 Docs   (Rel-   Series   History     Column     Simple
        ations)
    │      │      │          │           │            │
    ▼      ▼      ▼          ▼           ▼            ▼
Document Neptune Time-     QLDB     Keyspaces   DynamoDB
  DB           stream
    │
    └── MongoDB compatible? → Yes → DocumentDB
```

---

## Common Exam Questions

**Q1**: A company is migrating a MongoDB application to AWS. Which database service should they use?
> **DocumentDB** - Fully managed, MongoDB-compatible document database.

**Q2**: Which AWS database is best for analyzing social network connections and detecting fraud patterns?
> **Neptune** - Graph database optimized for relationship traversal.

**Q3**: A company needs to store IoT sensor data from millions of devices with time-based queries. Which service should they use?
> **Timestream** - Serverless time-series database with built-in time functions.

**Q4**: Which database provides an immutable, cryptographically verifiable transaction history for compliance?
> **QLDB** - Quantum Ledger Database with append-only journal.

**Q5**: A company wants to run Apache Cassandra workloads without managing clusters. Which service should they use?
> **Keyspaces** - Serverless Cassandra-compatible wide-column database.

**Q6**: What is the key difference between QLDB and blockchain?
> **QLDB is centralized** (trusted authority), blockchain is **decentralized** (consensus among untrusted parties).

---

## Summary

| Service | Memory Hook |
|---------|-------------|
| **DocumentDB** | "MongoDB in the cloud — same API, zero ops" |
| **Neptune** | "Social network detective — finds connections fast" |
| **Timestream** | "Time machine for metrics — IoT at scale" |
| **QLDB** | "Permanent ink ledger — immutable history" |
| **Keyspaces** | "Cassandra without headache — serverless wide-column" |

---

## 🔗 Related Topics

- [Amazon DynamoDB](dynamodb.md) - NoSQL key-value/document
- [Amazon RDS](rds.md) - Relational databases
- [Amazon Aurora](aurora.md) - High-performance relational
- [ElastiCache & Redshift](elasticache-redshift.md) - Caching and data warehouse
