# Amazon DynamoDB

> "DynamoDB = NoSQL at infinite scale — milliseconds guaranteed, no servers to manage."

## What DynamoDB Does

```
✅ Fully managed NoSQL database (key-value and document)
✅ Single-digit millisecond latency at ANY scale
✅ Serverless — no servers, no patching, no capacity planning (on-demand)
✅ Built-in security with encryption at rest
✅ Automatic scaling to handle millions of requests per second
```

---

## DynamoDB vs Relational Databases

> **Memory Hook**: "DynamoDB = **Speed & scale**. RDS = **Relationships & structure**."

```
RELATIONAL (RDS/Aurora)                      NOSQL (DynamoDB)
───────────────────────                      ────────────────

┌─────────────────────────────────┐      ┌─────────────────────────────────┐
│         USERS TABLE              │      │        USERS TABLE (Items)      │
│  ┌────┬──────────┬────────────┐ │      │                                 │
│  │ ID │   Name   │   Email    │ │      │  { UserID: "123",               │
│  ├────┼──────────┼────────────┤ │      │    Name: "Alice",               │
│  │ 1  │  Alice   │ a@mail.com │ │      │    Email: "a@mail.com",         │
│  │ 2  │  Bob     │ b@mail.com │ │      │    FavoriteColor: "Blue" }      │
│  │ 3  │  Charlie │ c@mail.com │ │      │                                 │
│  └────┴──────────┴────────────┘ │      │  { UserID: "456",               │
│                                 │      │    Name: "Bob",                  │
│  Fixed schema, all rows same!   │      │    Phone: "555-1234" }          │
│                                 │      │                                 │
│  Need to ALTER TABLE to add     │      │  Flexible schema!               │
│  new columns                    │      │  Each item can have different   │
│                                 │      │  attributes                     │
└─────────────────────────────────┘      └─────────────────────────────────┘

✅ Complex queries with JOINs          ✅ Fast reads/writes at scale
✅ ACID transactions                   ✅ Horizontal scaling (partitions)
❌ Harder to scale                     ❌ No JOINs, limited queries
```

---

## 🔑 Key Concepts

### What is a Table?

> **Memory Hook**: "Table = **Container** for all your items (like a folder for files)"

A **Table** in DynamoDB is a collection of items. Unlike SQL tables, DynamoDB tables don't have fixed schemas.

---

### What is an Item?

> **Memory Hook**: "Item = **One record** (like a JSON document)"

An **Item** is a single record in DynamoDB. Each item is a collection of attributes (key-value pairs).

```json
{
  "UserID": "user-123",        // Partition key
  "Timestamp": "2024-01-15",   // Sort key (optional)
  "Name": "Alice",
  "Email": "alice@example.com",
  "Age": 28
}
```

---

### What is a Primary Key?

> **Memory Hook**: "Primary Key = **Address** to find your item uniquely"

DynamoDB supports TWO types of primary keys:

```
PRIMARY KEY TYPES

┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│   SIMPLE PRIMARY KEY               COMPOSITE PRIMARY KEY            │
│   (Partition Key only)             (Partition Key + Sort Key)       │
│                                                                     │
│   ┌──────────────────────┐         ┌──────────────────────────────┐│
│   │ UserID: "user-123"   │         │ UserID: "user-123"           ││
│   │                      │         │ Timestamp: "2024-01-15"      ││
│   │                      │         │                              ││
│   │ Unique by UserID     │         │ Unique by UserID + Timestamp ││
│   └──────────────────────┘         └──────────────────────────────┘│
│                                                                     │
│   Use when: Each item has          Use when: Items grouped by      │
│   one unique identifier            partition, sorted by another    │
│   (Users, Products)                attribute (Orders per user)     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

### What is a Partition Key?

> **Memory Hook**: "Partition Key = **Mailroom address** — determines which storage box"

The **Partition Key** is used by DynamoDB to distribute data across partitions (internal storage nodes).

- DynamoDB hashes the partition key to determine storage location
- Good partition key = even data distribution = better performance
- Example: `UserID`, `ProductID`

---

### What is a Sort Key?

> **Memory Hook**: "Sort Key = **Filing order within the folder**"

The **Sort Key** (optional) allows multiple items with the same partition key, ordered by the sort key.

- Enables range queries: "Get all orders from January"
- Example: `OrderDate`, `Timestamp`, `Score`

---

## 💰 Capacity Modes

### What is On-Demand Mode?

> **Memory Hook**: "On-Demand = **Pay per click** — no planning, just use"

**On-Demand** automatically scales to handle any workload. Pay per request.

- **Why it exists:** Unpredictable traffic, new applications, variable workloads
- **How it works:** AWS handles all scaling automatically
- **Cost:** Pay per read/write request (no upfront commitment)

---

### What is Provisioned Mode?

> **Memory Hook**: "Provisioned = **Reserved capacity** — plan ahead, save money"

**Provisioned** lets you specify read/write capacity upfront.

- **Why it exists:** Predictable workloads, cost optimization
- **How it works:** You set RCUs (Read Capacity Units) and WCUs (Write Capacity Units)
- **Cost:** Cheaper for consistent workloads, but throttling if you exceed

```
CAPACITY MODE COMPARISON

    On-Demand                              Provisioned
    ─────────                              ───────────
    
    Traffic ↗↘↗↘↗↘                         Traffic ──────────────
                                           
    Scales automatically                    You set: 100 RCU, 50 WCU
    
    Pay: $1.25 per million reads           Pay: ~$0.00013 per RCU/hour
         $1.25 per million writes               ~$0.00065 per WCU/hour
    
    ✅ Perfect for spiky/unknown           ✅ Perfect for steady workloads
    ❌ More expensive per-request          ❌ Throttled if exceeded
```

---

## 🚀 DynamoDB Features

### What is DAX (DynamoDB Accelerator)?

> **Memory Hook**: "DAX = **Turbo boost** — microseconds instead of milliseconds"

**DAX** is a fully managed in-memory cache for DynamoDB.

- **Why it exists:** Some apps need even faster reads than milliseconds
- **How it works:** Sits between your app and DynamoDB, caches reads
- **Key point:** 10x performance improvement (microsecond latency)

```
WITHOUT DAX                              WITH DAX
──────────                              ────────

App → DynamoDB                          App → DAX → DynamoDB
                                              ↓
~5 milliseconds                         Cache hit: ~400 microseconds
                                        Cache miss: ~5 milliseconds + cache
```

---

### What is DynamoDB Streams?

> **Memory Hook**: "Streams = **Security camera** — records every change"

**DynamoDB Streams** captures item-level changes (insert, update, delete) in order.

- **Why it exists:** Trigger Lambda on changes, replicate data, analytics
- **How it works:** 24-hour rolling window of changes
- **Key point:** Time-ordered sequence of modifications

```
DYNAMODB STREAMS

    ┌─────────────────────┐
    │    DynamoDB Table   │
    │                     │
    │  INSERT user-123    │──────┐
    │  UPDATE user-456    │──────┤
    │  DELETE user-789    │──────┤
    └─────────────────────┘      │
                                 ▼
                    ┌────────────────────────┐
                    │   DynamoDB Stream      │
                    │ (24-hour window)       │
                    │                        │
                    │ → Lambda trigger       │
                    │ → Send to Kinesis      │
                    │ → Replicate to another │
                    │   region               │
                    └────────────────────────┘
```

---

### What is Global Tables?

> **Memory Hook**: "Global Tables = **Multi-Region active-active** — write anywhere, read everywhere"

**Global Tables** automatically replicate tables across multiple AWS Regions.

- **Why it exists:** Low-latency global access, disaster recovery
- **How it works:** Multi-master replication — write to any Region
- **Key point:** Eventually consistent across Regions, sub-second replication

```
GLOBAL TABLES

    ┌─────────────────────────────────────────────────────────────────┐
    │                                                                 │
    │  US-EAST-1                EU-WEST-1                AP-TOKYO-1   │
    │  ──────────               ──────────               ──────────   │
    │                                                                 │
    │  ┌─────────┐    replicate  ┌─────────┐   replicate  ┌─────────┐│
    │  │DynamoDB │◄────────────►│DynamoDB │◄───────────►│DynamoDB ││
    │  │ Table   │   (sub-sec)   │ Table   │   (sub-sec)  │ Table   ││
    │  └────┬────┘               └────┬────┘              └────┬────┘│
    │       │                         │                        │     │
    │   ┌───▼───┐                ┌───▼───┐                ┌───▼───┐ │
    │   │ R + W │                │ R + W │                │ R + W │ │
    │   │ (USA) │                │ (EU)  │                │(Japan)│ │
    │   └───────┘                └───────┘                └───────┘ │
    │                                                                 │
    │   Users can read/write from their nearest Region!              │
    │                                                                 │
    └─────────────────────────────────────────────────────────────────┘
```

---

## DynamoDB vs RDS/Aurora Comparison

| Aspect | **DynamoDB** | **RDS/Aurora** |
|--------|--------------|----------------|
| **Type** | NoSQL (key-value, document) | Relational (SQL) |
| **Schema** | Flexible (schemaless) | Fixed (defined columns) |
| **Scaling** | Horizontal (automatic) | Vertical (instance size) |
| **Latency** | Single-digit milliseconds | Depends on query complexity |
| **Queries** | By primary key (no JOINs) | SQL with JOINs, complex queries |
| **Transactions** | Limited (within table) | Full ACID transactions |
| **Use Case** | High-scale, simple access patterns | Complex relationships, reporting |
| **Management** | Fully serverless (on-demand) | Managed but requires sizing |
| **Cost** | Per request or provisioned | Instance hours |

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "DynamoDB is a SQL database" | **NO!** DynamoDB is NoSQL — no tables with fixed schema, no JOINs. | ⚠️ Yes |
| "DynamoDB requires capacity planning" | **NOT ALWAYS!** On-Demand mode handles this automatically. | ⚠️ Yes |
| "DAX helps with writes" | **NO!** DAX is a READ cache. Writes still go directly to DynamoDB. | ⚠️ Yes |
| "Global Tables are read-only replicas" | **NO!** Global Tables are MULTI-MASTER — read AND write in any Region. | ⚠️ Yes |
| "DynamoDB replaces all databases" | **NO!** Use RDS/Aurora for complex queries with JOINs and relationships. | ⚠️ Yes |
| "Streams store data forever" | **NO!** Streams have a 24-hour retention window. | ⚠️ Sometimes |

---

## 🎯 Decision Scenarios

**Scenario 1: Gaming leaderboard with millions of players**
> "Real-time updates, thousands of writes per second, display top 100 scores."

**Answer:** DynamoDB
**Why:** NoSQL handles massive scale, single-digit millisecond latency. Partition by GameID, sort by Score.

---

**Scenario 2: E-commerce shopping cart**
> "Users add items, sessions expire, need fast access."

**Answer:** DynamoDB
**Why:** Key-value store perfect for session data. TTL can auto-expire old carts.

---

**Scenario 3: Need to query JOINed data across multiple tables**
> "Reports combining users, orders, and products with complex filtering."

**Answer:** RDS or Aurora (NOT DynamoDB!)
**Why:** DynamoDB has no JOINs. Use relational database for complex queries.

---

**Scenario 4: Trigger Lambda when data changes**
> "When a new order is inserted, send a notification email."

**Answer:** DynamoDB Streams + Lambda
**Why:** Streams capture all changes, Lambda triggers on new records.

---

**Scenario 5: Global app with users on every continent**
> "Need low-latency reads and writes for users in US, Europe, and Asia."

**Answer:** DynamoDB Global Tables
**Why:** Multi-Region, multi-master replication. Users write to nearest Region.

---

**Scenario 6: Speed up read-heavy application**
> "Same queries repeated thousands of times per second."

**Answer:** DynamoDB + DAX
**Why:** DAX caches reads, delivers microsecond latency for repeated queries.

---

## Common Exam Questions

**Q1**: Which AWS service is a serverless NoSQL database with single-digit millisecond latency?
> **DynamoDB** - Fully managed, serverless NoSQL with guaranteed performance at any scale.

**Q2**: A company needs to replicate a DynamoDB table across multiple Regions for low-latency global access. Which feature should they use?
> **Global Tables** - Multi-Region, multi-master replication with sub-second sync.

**Q3**: What is the difference between on-demand and provisioned capacity in DynamoDB?
> **On-demand:** Auto-scales, pay per request. **Provisioned:** You set capacity, cheaper for steady workloads.

**Q4**: Which DynamoDB feature provides in-memory caching for microsecond read latency?
> **DAX (DynamoDB Accelerator)** - Managed cache that reduces read latency from milliseconds to microseconds.

**Q5**: What is DynamoDB Streams used for?
> **Capture item-level changes** - Time-ordered sequence of modifications. Common trigger for Lambda functions.

**Q6**: When should you use DynamoDB vs RDS?
> **DynamoDB:** High-scale, key-value access, flexible schema. **RDS:** Complex queries, JOINs, relational data.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **DynamoDB** | "NoSQL at infinite scale — milliseconds guaranteed" |
| **Partition Key** | "Mailroom address — determines storage location" |
| **Sort Key** | "Filing order within the folder" |
| **On-Demand vs Provisioned** | "Pay per click vs reserved capacity" |
| **DAX** | "Turbo boost — microseconds instead of milliseconds" |
| **Streams** | "Security camera — records every change (24 hours)" |
| **Global Tables** | "Multi-Region active-active — write anywhere" |

---

## 🔗 Related Topics

- [Amazon RDS](rds.md) - Managed relational databases
- [Amazon Aurora](aurora.md) - High-performance relational database
- [AWS Lambda](lambda.md) - Serverless compute (pairs with Streams)
- [ElastiCache](elasticache.md) - Alternative caching solution
