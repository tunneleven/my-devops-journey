# Amazon EC2 (Elastic Compute Cloud)

> "The virtual server that powers the cloud — launch, scale, pay-as-you-go."

## What EC2 Does

```
✅ Launch virtual servers (instances) in minutes
✅ Scale up/down based on demand automatically
✅ Pay only for compute time you use (per second/hour)
✅ Choose from 750+ instance types for any workload
```

---

## How EC2 Works

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           YOUR AWS ACCOUNT                                   │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                             VPC                                         │ │
│  │  ┌─────────────────────────┐    ┌─────────────────────────┐           │ │
│  │  │       AZ-a              │    │       AZ-b              │           │ │
│  │  │  ┌───────────────────┐  │    │  ┌───────────────────┐  │           │ │
│  │  │  │   EC2 Instance    │  │    │  │   EC2 Instance    │  │           │ │
│  │  │  │ ┌───────────────┐ │  │    │  │ ┌───────────────┐ │  │           │ │
│  │  │  │ │ AMI (OS+Apps) │ │  │    │  │ │ AMI (OS+Apps) │ │  │           │ │
│  │  │  │ └───────────────┘ │  │    │  │ └───────────────┘ │  │           │ │
│  │  │  │ ┌───────────────┐ │  │    │  │ ┌───────────────┐ │  │           │ │
│  │  │  │ │  EBS Volume   │ │  │    │  │ │  EBS Volume   │ │  │           │ │
│  │  │  │ └───────────────┘ │  │    │  │ └───────────────┘ │  │           │ │
│  │  │  └───────────────────┘  │    │  └───────────────────┘  │           │ │
│  │  │         🔒               │    │         🔒               │           │ │
│  │  │   Security Group        │    │   Security Group        │           │ │
│  │  └─────────────────────────┘    └─────────────────────────┘           │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## EC2 Instance Families

```
INSTANCE TYPE HIERARCHY
├── 🌐 GENERAL PURPOSE (T, M)
│   ├── T → Burstable (dev/test, low-traffic web)
│   └── M → Balanced (web servers, small DBs)
│
├── ⚡ COMPUTE OPTIMIZED (C)
│   └── C → CPU-intensive (batch, gaming, HPC)
│
├── 🧠 MEMORY OPTIMIZED (R, X)
│   ├── R → RAM-focused (in-memory DBs, caching)
│   └── X → eXtra memory (SAP HANA, large DBs)
│
├── 💾 STORAGE OPTIMIZED (I, D, H)
│   └── I/D/H → Intense I/O (data warehouse, HDFS)
│
└── 🎮 ACCELERATED COMPUTING (P, G, Inf, Trn)
    ├── P/G → GPU (ML training, graphics)
    └── Inf/Trn → ML Inference/Training
```

### Instance Naming Convention

```
    m5.2xlarge
    │ │  │
    │ │  └── Size (nano < micro < small < medium < large < xlarge < 2xlarge...)
    │ └───── Generation (higher = newer, better)
    └─────── Family (m = general purpose)
```

### Quick Reference Table

| Family | Type | Memory Trick | Best For |
|--------|------|--------------|----------|
| **T** | Burstable | **T**urbo bursts | Dev/test, low traffic |
| **M** | General Purpose | **M**iddle ground | Web servers, small DBs |
| **C** | Compute Optimized | **C**PU intensive | Batch, gaming, HPC |
| **R** | Memory Optimized | **R**AM focused | In-memory DBs, Redis |
| **X** | Memory Optimized | e**X**tra memory | SAP HANA |
| **I/D/H** | Storage Optimized | **I**ntense I/O | Data warehouse |
| **P/G** | Accelerated | **G**PU power | ML training, graphics |

---

## 💰 EC2 Pricing Models (EXAM CRITICAL!)

```
PRICING DECISION TREE

Need 24/7 predictable workload?
├── YES → Need flexibility to change instance type?
│   ├── YES → Savings Plans (1-3 year, $/hr commitment)
│   └── NO  → Reserved Instance (1-3 year, up to 72% off)
│
└── NO → Can tolerate interruption?
    ├── YES → Spot Instance (up to 90% off, can be terminated!)
    └── NO  → On-Demand (no commitment, highest price)

Need dedicated hardware?
└── YES → Dedicated Host/Instance (compliance, BYOL)
```

### Pricing Comparison

| Model | Commitment | Discount | Use Case | Key Point |
|-------|------------|----------|----------|-----------|
| **On-Demand** | None | 0% | Short-term, unpredictable | Pay by second, most flexible |
| **Reserved** | 1-3 years | Up to 72% | Steady-state (24/7 DB) | Fixed instance type |
| **Savings Plans** | 1-3 years | Up to 72% | Flexible steady-state | $/hr commitment, any type |
| **Spot** | None | Up to 90% | Fault-tolerant batch | ⚠️ 2-min termination warning |
| **Dedicated Host** | Varies | Varies | Compliance, licensing | Entire physical server |

### Reserved Instance Types

| Type | Flexibility | Discount | When |
|------|-------------|----------|------|
| **Standard** | ❌ Fixed type | Highest | Know exact needs |
| **Convertible** | ✅ Can change | Medium | May need to upgrade |
| **Scheduled** | ⏰ Time-based | Medium | Predictable patterns |

### Payment Options (Reserved/Savings Plans)

```
All Upfront ──────► Largest discount
Partial Upfront ──► Medium discount  
No Upfront ───────► Smallest discount
```

---

## 🚀 EC2 Launch Process

```
Step 1: Choose AMI (Amazon Machine Image)
[Template] ──► Contains OS + software + configuration

Step 2: Choose Instance Type
[Workload] ──► Select family (M, C, R...) and size (large, xlarge...)

Step 3: Configure Instance
[Settings] ──► VPC, subnet, IAM role, user data script

Step 4: Add Storage  
[Volumes] ──► EBS root volume + additional volumes

Step 5: Configure Security Group
[Firewall] ──► Allow SSH (22), HTTP (80), HTTPS (443)

Step 6: Add Key Pair
[Access] ──► SSH key for Linux, RDP password for Windows

Step 7: Launch!
[Instance] ──► Running in ~1 minute
```

---

## 🔐 Security Groups (Virtual Firewall)

```
┌───────────────────────────────────────────────────────────┐
│                    INTERNET                               │
└───────────────────────────────────────────────────────────┘
                           │
                           ▼
┌───────────────────────────────────────────────────────────┐
│              🔒 SECURITY GROUP (Firewall)                 │
│                                                           │
│  INBOUND RULES (What can come IN):                        │
│  ┌─────────────────────────────────────────────────────┐  │
│  │ Type   │ Port │ Source      │ Purpose               │  │
│  │ SSH    │ 22   │ My IP       │ Admin access          │  │
│  │ HTTP   │ 80   │ 0.0.0.0/0   │ Web traffic           │  │
│  │ HTTPS  │ 443  │ 0.0.0.0/0   │ Secure web traffic    │  │
│  └─────────────────────────────────────────────────────┘  │
│                                                           │
│  OUTBOUND RULES (What can go OUT):                        │
│  ┌─────────────────────────────────────────────────────┐  │
│  │ All traffic │ All │ 0.0.0.0/0 │ Default allow all   │  │
│  └─────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────┘
                           │
                           ▼
              ┌─────────────────────┐
              │   EC2 INSTANCE      │
              └─────────────────────┘
```

### Key Security Group Facts

| Fact | Detail |
|------|--------|
| **Default Inbound** | ❌ Deny all |
| **Default Outbound** | ✅ Allow all |
| **Stateful** | Return traffic auto-allowed |
| **Level** | Instance-level (not subnet) |
| **Changes** | Take effect immediately |

---

## 📈 Auto Scaling

```
DEMAND SPIKE HANDLING

                 ┌─────────┐
    Demand ─────►│ Auto    │─────► Instances
    Increase     │ Scaling │      Added
                 └─────────┘
                      │
                      ▼
    [Min: 2] ◄──► [Desired: 4] ◄──► [Max: 10]
    
    CPU > 80%? ──► Scale OUT (add instances)
    CPU < 20%? ──► Scale IN (remove instances)
```

| Scaling Type | Trigger | Use Case |
|--------------|---------|----------|
| **Dynamic** | CloudWatch metrics | Variable traffic |
| **Scheduled** | Time-based | Known peak hours |
| **Predictive** | ML forecasting | Predictable patterns |

---

## ⚖️ Elastic Load Balancing (ELB)

```
                           Internet
                              │
                              ▼
                    ┌─────────────────┐
                    │  Load Balancer  │
                    │  (ALB or NLB)   │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
         [EC2 #1]       [EC2 #2]       [EC2 #3]
          (AZ-a)         (AZ-b)         (AZ-c)
```

| Type | Layer | Protocol | Best For |
|------|-------|----------|----------|
| **ALB** | Layer 7 | HTTP/HTTPS | Web apps, path routing |
| **NLB** | Layer 4 | TCP/UDP | Ultra-low latency, gaming |
| **CLB** | L4/L7 | Legacy | ❌ Avoid for new projects |

---

## 🏢 Placement Groups

```
CLUSTER:     All together → Lowest latency
┌────────────────────────────────────┐
│ [EC2][EC2][EC2][EC2] ← Same rack   │
└────────────────────────────────────┘

SPREAD:      All separate → Max resilience  
[EC2]          [EC2]          [EC2]
 Rack 1         Rack 2         Rack 3

PARTITION:   Grouped isolation → Fault domains
[Part 1]       [Part 2]       [Part 3]
[EC2][EC2]     [EC2][EC2]     [EC2][EC2]
```

| Type | Strategy | Use Case | Limit |
|------|----------|----------|-------|
| **Cluster** | Same rack | HPC, low latency | Single AZ |
| **Spread** | Different racks | Critical apps | 7 per AZ |
| **Partition** | Separate partitions | Hadoop, Kafka | 7 partitions |

---

## Common Exam/Interview Questions

**Q1**: A company needs to run a 24/7 database with predictable usage. Which pricing model is most cost-effective?
> **Reserved Instance** - 1-3 year commitment provides up to 72% discount for steady-state workloads

**Q2**: Which pricing model should you use for fault-tolerant batch processing jobs to maximize savings?
> **Spot Instance** - Up to 90% discount, perfect for interruptible workloads that can handle 2-minute termination notice

**Q3**: What's the difference between Security Groups and NACLs?
> **Security Groups** are stateful (at instance level), **NACLs** are stateless (at subnet level). Security Groups default deny inbound, NACLs support explicit deny rules.

**Q4**: Which instance family would you choose for a machine learning training workload?
> **P or G family** (Accelerated Computing) - These include GPU accelerators optimized for ML training

**Q5**: When should you use Savings Plans instead of Reserved Instances?
> **Savings Plans** when you need flexibility to change instance types, sizes, or regions while still getting significant discounts. You commit to $/hour spend, not specific instances.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **EC2** | "Elastic Compute Cloud = Virtual servers on demand" |
| **T/M instances** | "T = Turbo bursts, M = Middle ground" |
| **C instances** | "C = CPU cruncher" |
| **R/X instances** | "R = RAM, X = eXtra memory" |
| **On-Demand** | "Pay as you go, no strings attached" |
| **Reserved** | "Reserve a table = commit for discount" |
| **Spot** | "Spare capacity lottery = up to 90% off but can be kicked out" |
| **Savings Plans** | "Budget commitment, flexible usage" |
| **Security Group** | "Bouncer at the door (stateful, instance-level)" |
| **ALB vs NLB** | "ALB = Application (L7), NLB = Network (L4, fast)" |
| **Auto Scaling** | "Rubber band capacity = stretches with demand" |

---

## 🔗 Related Topics

- [Shared Responsibility Model](shared-responsibility-model.md) - AWS secures infrastructure, you secure instances
- [Security Groups vs NACLs](security-groups-vs-nacls.md) - Understand both firewall layers
- [VPC Fundamentals](vpc-fundamentals.md) - Network where your EC2 lives
