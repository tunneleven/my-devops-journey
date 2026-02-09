# EC2 Placement Groups

> "Control where your instances physically sit — group them for speed, spread them for safety."

## What Placement Groups Do

```
✅ Control physical placement of EC2 instances on AWS hardware
✅ Optimize for low latency, high throughput, OR fault isolation
✅ FREE to use (no additional charges)
✅ Cannot span multiple Regions
```

---

## The 3 Placement Strategies

### What is a Cluster Placement Group?

> **Memory Hook**: "Cluster = **Carpool** — everyone in the same car, fastest route"

**Cluster** packs all instances onto the **same rack** in a single AZ for ultra-low latency.

- **Why it exists:** HPC and ML training need nanosecond-level communication
- **Trade-off:** If the rack fails, ALL instances fail
- **Key point:** Single AZ only, but 10-25 Gbps network speed

---

### What is a Spread Placement Group?

> **Memory Hook**: "Spread = **Solo travelers** — each person on a different flight"

**Spread** places each instance on a **different physical rack** for maximum fault isolation.

- **Why it exists:** Critical apps can't afford correlated failures
- **Trade-off:** Limited to 7 instances per AZ
- **Key point:** Multi-AZ supported, each instance isolated

---

### What is a Partition Placement Group?

> **Memory Hook**: "Partition = **Tour groups** — groups stay together, but groups are separated"

**Partition** divides instances into logical partitions, each on separate racks.

- **Why it exists:** Big data systems need to know failure boundaries
- **Trade-off:** Limited to 7 partitions per AZ
- **Key point:** Apps can query partition metadata for topology awareness

---

### Visual Comparison

```
EC2 PLACEMENT STRATEGIES

┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   CLUSTER                 SPREAD                    PARTITION               │
│   ─────────               ──────                    ─────────               │
│                                                                              │
│   ┌─────────────┐        Rack 1   Rack 2   Rack 3   ┌─────┐ ┌─────┐ ┌─────┐│
│   │ Same Rack   │        ┌───┐    ┌───┐    ┌───┐    │ P1  │ │ P2  │ │ P3  ││
│   │ ┌───┐ ┌───┐ │        │EC2│    │EC2│    │EC2│    │┌───┐│ │┌───┐│ │┌───┐││
│   │ │EC2│ │EC2│ │        └───┘    └───┘    └───┘    ││EC2││ ││EC2││ ││EC2│││
│   │ └───┘ └───┘ │                                   │└───┘│ │└───┘│ │└───┘││
│   │ ┌───┐ ┌───┐ │        Rack 4   Rack 5            │┌───┐│ │┌───┐│ │┌───┐││
│   │ │EC2│ │EC2│ │        ┌───┐    ┌───┐             ││EC2││ ││EC2││ ││EC2│││
│   │ └───┘ └───┘ │        │EC2│    │EC2│             │└───┘│ │└───┘│ │└───┘││
│   └─────────────┘        └───┘    └───┘             └─────┘ └─────┘ └─────┘│
│                                                                              │
│   SINGLE AZ              MULTI-AZ                   MULTI-AZ                │
│   Same hardware          Different racks            Partition isolation     │
│   Lowest latency         Max 7 per AZ               Max 7 partitions/AZ     │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Type Comparison

| Aspect | Cluster | Spread | Partition |
|--------|---------|--------|-----------|
| **Goal** | Performance | Fault isolation | Scale + isolation |
| **Placement** | Same rack, same AZ | Different racks | Separate partitions |
| **AZ Scope** | Single AZ only | Multi-AZ | Multi-AZ |
| **Max per AZ** | No limit | **7 instances** | **7 partitions** |
| **Failure risk** | High (single rack) | Low (isolated) | Medium (per partition) |
| **Network** | 10-25 Gbps enhanced | Standard | Standard |
| **Use case** | HPC, ML training | Critical apps | Big data, Hadoop |

---

## 🚀 Cluster Placement Group

> **Memory Hook**: "**Cluster** = **Close together** = Low latency"

```
CLUSTER: MAXIMUM PERFORMANCE

    ┌────────────────────────────────────────────────────────────────┐
    │                     SINGLE AVAILABILITY ZONE                    │
    │                                                                │
    │    ┌──────────────────────────────────────────────────────┐   │
    │    │                    SAME RACK                          │   │
    │    │                                                       │   │
    │    │   ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐    │   │
    │    │   │  EC2   │  │  EC2   │  │  EC2   │  │  EC2   │    │   │
    │    │   │        │◄─►│        │◄─►│        │◄─►│        │    │   │
    │    │   └────────┘  └────────┘  └────────┘  └────────┘    │   │
    │    │        │            │            │            │      │   │
    │    │        └────────────┴────────────┴────────────┘      │   │
    │    │                 10-25 Gbps Network                   │   │
    │    └──────────────────────────────────────────────────────┘   │
    │                                                                │
    │    ✅ Ultra-low latency between instances                      │
    │    ✅ High throughput network (enhanced networking)            │
    │    ⚠️ ALL instances fail if rack fails!                        │
    │                                                                │
    └────────────────────────────────────────────────────────────────┘
```

**Best For:**
- High-Performance Computing (HPC)
- Machine Learning training
- Scientific simulations
- Tightly-coupled distributed applications

---

## 🛡️ Spread Placement Group

> **Memory Hook**: "**Spread** = **Separate racks** = Max resilience"

```
SPREAD: MAXIMUM FAULT ISOLATION

    ┌────────────────────────────────────────────────────────────────┐
    │                    ACROSS MULTIPLE AZs                         │
    │                                                                │
    │   AZ-a                  AZ-b                  AZ-c             │
    │                                                                │
    │   Rack 1     Rack 2     Rack 3     Rack 4     Rack 5          │
    │   ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐         │
    │   │ EC2 │    │ EC2 │    │ EC2 │    │ EC2 │    │ EC2 │         │
    │   └─────┘    └─────┘    └─────┘    └─────┘    └─────┘         │
    │                                                                │
    │   ✅ Each instance on DIFFERENT rack                           │
    │   ✅ Independent power and networking                          │
    │   ⚠️ LIMIT: 7 running instances per AZ!                        │
    │                                                                │
    │   Example: 3 AZs × 7 = 21 max instances in group               │
    │                                                                │
    └────────────────────────────────────────────────────────────────┘
```

**Best For:**
- Critical applications that must stay running
- Small number of vital instances
- Stateful applications (databases, file servers)
- Applications requiring high availability

> [!IMPORTANT]
> **7 per AZ limit** is a common exam question! If you need more than 7 instances per AZ, use Partition instead.

---

## 📦 Partition Placement Group

> **Memory Hook**: "**Partition** = **Partitioned failures** = Big data isolation"

```
PARTITION: LARGE-SCALE FAULT ISOLATION

    ┌────────────────────────────────────────────────────────────────┐
    │                    ACROSS MULTIPLE AZs                         │
    │                                                                │
    │              AZ-a                           AZ-b               │
    │                                                                │
    │   ┌──────────────────────┐    ┌──────────────────────┐        │
    │   │    PARTITION 1       │    │    PARTITION 3       │        │
    │   │   ┌────┐ ┌────┐      │    │   ┌────┐ ┌────┐      │        │
    │   │   │EC2 │ │EC2 │      │    │   │EC2 │ │EC2 │      │        │
    │   │   └────┘ └────┘      │    │   └────┘ └────┘      │        │
    │   │   ┌────┐             │    │   ┌────┐             │        │
    │   │   │EC2 │  (Rack A)   │    │   │EC2 │  (Rack C)   │        │
    │   │   └────┘             │    │   └────┘             │        │
    │   └──────────────────────┘    └──────────────────────┘        │
    │                                                                │
    │   ┌──────────────────────┐    ┌──────────────────────┐        │
    │   │    PARTITION 2       │    │    PARTITION 4       │        │
    │   │   ┌────┐ ┌────┐      │    │   ┌────┐ ┌────┐      │        │
    │   │   │EC2 │ │EC2 │      │    │   │EC2 │ │EC2 │      │        │
    │   │   └────┘ └────┘      │    │   └────┘ └────┘      │        │
    │   │   (Rack B)           │    │   (Rack D)           │        │
    │   └──────────────────────┘    └──────────────────────┘        │
    │                                                                │
    │   ✅ Each partition on DIFFERENT rack                          │
    │   ✅ Instances in same partition MAY share rack                │
    │   ✅ Partition metadata available for topology-aware apps      │
    │   ⚠️ LIMIT: 7 partitions per AZ                                │
    │                                                                │
    └────────────────────────────────────────────────────────────────┘
```

**Best For:**
- Hadoop, HDFS, HBase
- Apache Cassandra, Apache Kafka
- Any distributed database that replicates data
- Large-scale applications needing fault isolation

---

## 🧭 Which Placement Group Should I Use?

```
DECISION TREE

    Need lowest possible latency between instances?
    (HPC, ML training, tightly-coupled apps)
              │
         ┌────┴────┐
         │         │
        YES        NO
         │         │
         ▼         ▼
      ┌───────┐   Need to protect a FEW critical instances?
      │CLUSTER│   (Max 7 per AZ is acceptable)
      └───────┘         │
                   ┌────┴────┐
                   │         │
                  YES        NO
                   │         │
                   ▼         ▼
                ┌──────┐   Need large-scale distributed system?
                │SPREAD│   (Hadoop, Kafka, Cassandra)
                └──────┘         │
                            ┌────┴────┐
                            │         │
                           YES        NO
                            │         │
                            ▼         ▼
                       ┌─────────┐   No placement group needed
                       │PARTITION│   (AWS handles placement)
                       └─────────┘
```

---

## Limitations Summary

| Limit | Cluster | Spread | Partition |
|-------|---------|--------|-----------|
| **AZ Span** | Single AZ only | Multi-AZ | Multi-AZ |
| **Instances per AZ** | Account limits | **7 max** | Many |
| **Partitions per AZ** | N/A | N/A | **7 max** |
| **Instance types** | Same type recommended | Any type | Any type |
| **Can add later?** | ⚠️ Tricky | ✅ Yes | ✅ Yes |

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Cluster can span multiple AZs" | **NO!** Cluster is SINGLE AZ only. That's how it gets low latency. | ⚠️ Yes |
| "Spread can have unlimited instances" | **NO!** Max 7 instances per AZ. Use Partition if you need more. | ⚠️ Yes (very common!) |
| "Partition means 7 instances per AZ" | **NO!** It's 7 PARTITIONS per AZ. Each partition can have many instances. | ⚠️ Yes |
| "Cluster is best for HA" | **NO!** Cluster sacrifices HA for performance. One rack = single point of failure. | ⚠️ Yes |
| "Placement groups cost extra" | **NO!** Placement groups are FREE. No additional charges. | ⚠️ Sometimes |
| "You can move existing instances to a placement group" | **TRICKY!** Instance must be stopped → move → start. Can't move running instance. | ⚠️ Yes |

---

## 🎯 Decision Scenarios

**Scenario 1: Training a large machine learning model**
> "We need 50 GPU instances to train an AI model. Training data moves constantly between instances."

**Answer:** Cluster Placement Group
**Why:** ML training needs ultra-low latency between nodes. 10-25 Gbps network. Single rack = fastest data transfer.

---

**Scenario 2: Running 5 stateful database primaries**
> "We have 5 critical database servers. If one fails, that's bad. If ALL fail simultaneously, company loses millions."

**Answer:** Spread Placement Group
**Why:** 5 instances < 7 limit. Each on different rack = no correlated failure. Maximum fault isolation.

---

**Scenario 3: Deploying a 100-node Hadoop cluster**
> "We're setting up HDFS with data replication. Nodes need to know which other nodes might fail together."

**Answer:** Partition Placement Group
**Why:** 100 nodes > 7 (needs Partition, not Spread). Hadoop can query partition metadata to place replicas across partitions.

---

**Scenario 4: Web application with 20 instances**
> "Standard web app, nothing special about networking or fault tolerance."

**Answer:** No placement group needed
**Why:** AWS default placement is fine. Placement groups are for specific performance or isolation requirements.

---

**Scenario 5: Need 15 isolated instances in one AZ**
> "We need fault isolation for 15 critical instances, all in the same AZ."

**Answer:** Partition Placement Group (NOT Spread!)
**Why:** Spread limit is 7 per AZ. Use 3-4 partitions with ~4 instances each instead.

---

## Common Exam Questions

**Q1**: A company is running a high-performance computing (HPC) application that requires the lowest possible network latency between instances. Which placement group should they use?
> **Cluster Placement Group** - Places instances on the same rack in a single AZ for ultra-low latency and high throughput networking.

**Q2**: A company has 5 critical EC2 instances that must not fail simultaneously. They want maximum fault isolation. Which placement group strategy should they use?
> **Spread Placement Group** - Each instance is placed on different hardware (racks), minimizing correlated failures. Max 7 per AZ.

**Q3**: A company is deploying Apache Cassandra which needs to replicate data across partitions and be aware of failure domains. Which placement group is most appropriate?
> **Partition Placement Group** - Provides partition metadata so applications can make topology-aware decisions. Best for distributed databases like Cassandra, Kafka, Hadoop.

**Q4**: What is the maximum number of running instances allowed per Availability Zone in a Spread placement group?
> **7 instances per AZ** - This is a hard limit. For more instances, use Partition placement groups.

**Q5**: Which placement group type would you choose if you prioritize performance over fault tolerance?
> **Cluster** - All instances on same rack gives best performance but single point of failure.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **Cluster** | "Close together" = Same rack, lowest latency, HPC |
| **Spread** | "Spread apart" = Different racks, max 7/AZ, critical apps |
| **Partition** | "Partitioned failures" = Logical groups, big data |
| **7 per AZ** | Spread limit = Remember for exam! |
| **7 partitions** | Partition limit per AZ |
| **Single AZ** | Cluster only spans one AZ |
| **Multi-AZ** | Spread and Partition span multiple AZs |

---

## 🔗 Related Topics

- [EC2 Fundamentals](ec2.md) - Instance basics
- [EC2 Instance Families](ec2-instance-families.md) - Choosing instance types for placement groups
- [Auto Scaling](auto-scaling.md) - Can work with placement groups
