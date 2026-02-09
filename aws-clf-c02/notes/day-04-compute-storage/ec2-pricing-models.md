# EC2 Pricing Models

> "Right pricing model = same performance, fraction of the cost. This is where AWS certification exams love to test!"

## What Are Pricing Models?

```
✅ Different ways to pay for EC2 compute time
✅ Same instance, same performance — just different billing
✅ Choosing correctly can save up to 90% on costs
✅ CLF-C02 exam heavily tests pricing scenarios!
```

---

## The 6 Pricing Models Overview

```
EC2 PRICING MODELS (by commitment level)

NO COMMITMENT                              LONG-TERM COMMITMENT
│                                                              │
▼                                                              ▼
┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│ On-Demand│   │   Spot   │   │ Savings  │   │ Reserved │   │Dedicated │
│          │   │          │   │  Plans   │   │          │   │  Hosts   │
│   $$$    │   │    $     │   │   $$     │   │   $$     │   │  $$$$    │
│   0%     │   │  ~90%    │   │  ~72%    │   │  ~72%    │   │ Varies   │
│ discount │   │ discount │   │ discount │   │ discount │   │          │
└──────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
     │              │              │              │              │
     ▼              ▼              ▼              ▼              ▼
 Flexible      Interruptible    Flexible      Fixed type    Compliance
 Short-term    Fault-tolerant   1-3 year      1-3 year      Licensing
```

---

## 💵 1. On-Demand Instances

> **Memory Hook**: "Pay as you go — like a taxi meter"

### Key Characteristics

| Aspect | Detail |
|--------|--------|
| **Billing** | Per second (Linux) or per hour (Windows) |
| **Commitment** | None |
| **Discount** | 0% (baseline pricing) |
| **Capacity** | No guarantee |

### When to Use

```
ON-DEMAND IS PERFECT FOR:
├── 🧪 Development and testing
├── 📈 Unpredictable workloads
├── 🚀 New applications (unknown traffic)
├── ⏱️ Short-term projects (< 1 year)
└── 🔥 Sudden traffic spikes
```

### Real-World Example

| Scenario | Why On-Demand? |
|----------|----------------|
| Startup MVP launch | Unknown traffic, can't predict usage |
| Black Friday traffic spike | Temporary, unexpected demand |
| Development environment | Only runs during work hours |

---

## 🎰 2. Spot Instances

> **Memory Hook**: "Spare capacity lottery — cheap but can be kicked out!"

### Key Characteristics

| Aspect | Detail |
|--------|--------|
| **Discount** | Up to 90% off On-Demand |
| **Commitment** | None |
| **Catch** | Can be interrupted with 2-minute warning |
| **Price** | Varies by supply/demand |

### How Spot Works

```
SPOT INSTANCE LIFECYCLE

    AWS has spare capacity
           │
           ▼
    ┌─────────────────┐
    │ Spot available  │──► You launch at current Spot price
    │ at 70% discount │
    └─────────────────┘
           │
           ▼ (Later... demand increases)
    ┌─────────────────┐
    │ AWS reclaims    │──► 2-minute warning
    │ capacity        │──► Instance terminated!
    └─────────────────┘
```

### When to Use (and NOT Use)

```
✅ PERFECT FOR SPOT:              ❌ NEVER USE SPOT FOR:
├── Batch processing              ├── Databases
├── Big data analytics            ├── Critical applications
├── CI/CD pipelines               ├── Anything that can't restart
├── Image/video rendering         └── Stateful workloads
├── Containerized workloads
└── Machine learning training
```

### Real-World Example

| Scenario | Why Spot? |
|----------|-----------|
| Hadoop data processing | Can checkpoint and resume |
| Jenkins CI/CD | Jobs can retry on new instance |
| Video encoding | Stateless, can restart |

> [!CAUTION]
> **Never use Spot for databases!** Data loss risk when terminated.

---

## 📋 3. Reserved Instances (RIs)

> **Memory Hook**: "Reserve a table at a restaurant — commit for discount"

### Key Characteristics

| Aspect | Detail |
|--------|--------|
| **Discount** | Up to 72% off On-Demand |
| **Commitment** | 1 year or 3 years |
| **Flexibility** | Fixed instance type (mostly) |

### Three Types of Reserved Instances

| Type | Flexibility | Discount | When to Use |
|------|-------------|----------|-------------|
| **Standard** | ❌ Fixed type, size, region | Up to 72% | Known, stable workloads |
| **Convertible** | ✅ Can change type/size | Up to 66% | May need to upgrade later |
| **Scheduled** | ⏰ Specific time windows | Up to 75% | Predictable daily/weekly patterns |

### Payment Options

```
RESERVED INSTANCE PAYMENT OPTIONS

    ALL UPFRONT        PARTIAL UPFRONT       NO UPFRONT
    ─────────────      ─────────────────     ────────────
    │Pay 100% now│     │Pay ~50% + hourly│   │Pay hourly │
    └────────────┘     └─────────────────┘   └───────────┘
         │                    │                    │
         ▼                    ▼                    ▼
    LARGEST              MEDIUM               SMALLEST
    DISCOUNT             DISCOUNT             DISCOUNT
```

### Standard vs Convertible

```
STANDARD RI:
┌─────────────────────────────────────────┐
│ Commit to: m5.large in us-east-1        │
│ Can't change: instance type, size       │
│ Discount: 72%                           │
│ Best for: Stable, predictable apps      │
└─────────────────────────────────────────┘

CONVERTIBLE RI:
┌─────────────────────────────────────────┐
│ Commit to: Any instance in region       │
│ Can change: m5.large → c6i.xlarge       │
│ Discount: 66%                           │
│ Best for: Evolving applications         │
└─────────────────────────────────────────┘
```

### Real-World Example

| Scenario | RI Type | Why? |
|----------|---------|------|
| Production database (24/7) | Standard RI | Fixed workload, max savings |
| Growing startup | Convertible RI | May need to scale up |
| Nightly batch job (8 PM - 6 AM) | Scheduled RI | Predictable schedule |

---

## 💰 4. Savings Plans

> **Memory Hook**: "Commit to a spending amount, use flexibly"

### Key Characteristics

| Aspect | Detail |
|--------|--------|
| **Discount** | Up to 72% off On-Demand |
| **Commitment** | 1 year or 3 years |
| **Flexibility** | More flexible than RIs |
| **How it works** | Commit to $/hour spend |

### Two Types of Savings Plans

| Type | Applies To | Flexibility | Discount |
|------|------------|-------------|----------|
| **Compute Savings Plans** | EC2, Fargate, Lambda | ✅ Any region, family, OS | Up to 66% |
| **EC2 Instance Savings Plans** | EC2 only | ⚠️ Fixed region + family | Up to 72% |

### How Savings Plans Work

```
SAVINGS PLANS BILLING

You commit: $10/hour for 1 year

Hour 1: Using $8 of compute
├── $8 billed at Savings Plans rate (discounted)
└── $0 excess

Hour 2: Using $15 of compute  
├── $10 billed at Savings Plans rate (discounted)
└── $5 billed at On-Demand rate (excess)

Hour 3: Using $5 of compute
├── $5 billed at Savings Plans rate (discounted)
└── $5 of commitment is "wasted" (still pay $10)
```

### Savings Plans vs Reserved Instances

| Aspect | Savings Plans | Reserved Instances |
|--------|---------------|-------------------|
| **Flexibility** | ✅ High | ⚠️ Lower |
| **Commitment** | $/hour spend | Specific instance |
| **Change instance type** | ✅ Automatic | ❌ Need Convertible |
| **Cross-service** | ✅ EC2, Fargate, Lambda | ❌ EC2 only |
| **Max discount** | 72% | 72% |

### Real-World Example

| Scenario | Plan Type | Why? |
|----------|-----------|------|
| Multi-region deployment | Compute Savings | Flexibility across regions |
| Stable EC2 in one region | EC2 Instance Savings | Max discount |
| Mix of EC2 + Lambda | Compute Savings | Covers both services |

---

## 🏢 5. Dedicated Options

> **Memory Hook**: "Your own hardware — for compliance and licensing"

### Two Types

| Option | What You Get | Use Case | Cost |
|--------|--------------|----------|------|
| **Dedicated Hosts** | Entire physical server | BYOL, compliance | $$$$ |
| **Dedicated Instances** | Instance on single-tenant hardware | Compliance | $$$ |

### Dedicated Hosts vs Dedicated Instances

```
DEDICATED HOSTS:
┌─────────────────────────────────────────────────────────┐
│              YOUR PHYSICAL SERVER                       │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐       │
│  │ Your EC2│ │ Your EC2│ │ Your EC2│ │ (Empty) │       │
│  │ #1      │ │ #2      │ │ #3      │ │         │       │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘       │
│                                                         │
│  You control: socket count, cores, host placement       │
│  Billing: Per HOST (not per instance)                   │
│  Best for: BYOL (Windows Server, SQL Server, Oracle)    │
└─────────────────────────────────────────────────────────┘

DEDICATED INSTANCES:
┌─────────────────────────────────────────────────────────┐
│              SHARED PHYSICAL SERVER (your account only) │
│  ┌─────────┐ ┌─────────────────────────────────────────┐│
│  │ Your EC2│ │            Other space (unused)        ││
│  │         │ │            (Not visible to you)        ││
│  └─────────┘ └─────────────────────────────────────────┘│
│                                                         │
│  You control: Just your instance                        │
│  Billing: Per INSTANCE + small hourly fee               │
│  Best for: Compliance without full server control       │
└─────────────────────────────────────────────────────────┘
```

### When to Use

| Scenario | Use |
|----------|-----|
| Windows Server/SQL Server licensing (BYOL) | **Dedicated Hosts** |
| Oracle database licensing | **Dedicated Hosts** |
| Regulatory compliance (no shared hardware) | **Dedicated Instances** |
| Healthcare/Financial data isolation | **Dedicated Instances** |

---

## 📦 6. Capacity Reservations

> **Memory Hook**: "Reserve capacity without commitment"

### Key Characteristics

| Aspect | Detail |
|--------|--------|
| **What** | Reserve capacity in specific AZ |
| **Discount** | None (On-Demand rates) |
| **Commitment** | None |
| **Guarantee** | ✅ Capacity guaranteed |

### When to Use

```
CAPACITY RESERVATIONS FOR:
├── 🚨 Disaster recovery (need capacity when failover)
├── 📅 Planned events (product launch, quarterly reports)
├── 🏛️ Regulatory requirements (must have capacity)
└── 🔄 Migration from on-premises (guaranteed landing)
```

---

## 🔥 Pricing Decision Tree

```
WHICH PRICING MODEL?

Start Here
    │
    ▼
Can workload be interrupted?
├── YES → Fault-tolerant?
│   ├── YES → SPOT INSTANCES (90% off)
│   └── NO  → ON-DEMAND
│
└── NO → How long will you run?
    ├── < 1 year → ON-DEMAND
    │
    └── ≥ 1 year → Predictable usage?
        ├── YES → Need flexibility?
        │   ├── YES → SAVINGS PLANS
        │   └── NO  → RESERVED INSTANCES
        │
        └── NO → ON-DEMAND

Need dedicated hardware?
├── BYOL licensing → DEDICATED HOSTS
└── Just compliance → DEDICATED INSTANCES

Need guaranteed capacity?
└── YES → CAPACITY RESERVATION
```

---

## 🎯 Real Exam Questions (With Answers)

### Question 1
> A company has a web application that runs 24/7 throughout the year. The workload is predictable and consistent. Which pricing option provides the MOST cost savings?

**Answer: Reserved Instances (Standard) or EC2 Instance Savings Plan**
- "24/7 throughout the year" = steady-state
- "Predictable and consistent" = can commit
- 1-3 year commitment = up to 72% savings

---

### Question 2
> A company needs to process large amounts of data using Apache Spark. The processing can be interrupted and restarted without issue. Which pricing option is MOST cost-effective?

**Answer: Spot Instances**
- "Can be interrupted and restarted" = fault-tolerant
- "Large amounts of data" = batch processing
- Up to 90% savings with Spot

---

### Question 3
> A company wants to save on EC2 costs but isn't sure which instance types they'll need in the future. They need flexibility to change instance families. Which option is best?

**Answer: Compute Savings Plans**
- "Flexibility to change instance families" = need flexibility
- Savings Plans allows changing instance types automatically
- Compute Savings Plans work across EC2, Fargate, Lambda

---

### Question 4
> A company needs to run Windows Server with their existing licenses (BYOL) on AWS. Which EC2 purchasing option should they use?

**Answer: Dedicated Hosts**
- "Existing licenses (BYOL)" = Bring Your Own License
- Dedicated Hosts give visibility into sockets/cores for licensing
- Only Dedicated Hosts support BYOL for per-socket licenses

---

### Question 5
> A startup is launching a new application. Traffic is unpredictable, and they don't want any long-term commitments. Which pricing model should they use?

**Answer: On-Demand**
- "New application, unpredictable traffic" = unknown usage
- "No long-term commitments" = no RI/Savings Plans
- On-Demand is most flexible for this scenario

---

### Question 6
> A company runs batch jobs every night from 10 PM to 6 AM. The jobs run 365 days a year. Which Reserved Instance type is MOST appropriate?

**Answer: Scheduled Reserved Instances**
- "Every night from 10 PM to 6 AM" = predictable schedule
- "365 days a year" = consistent pattern
- Scheduled RIs are for recurring, predictable time windows

---

### Question 7
> Which pricing option allows a company to change from a t3.medium instance to a c5.large instance without losing their commitment discount?

**Answer: Convertible Reserved Instances OR Compute Savings Plans**
- Both allow changing instance types
- Convertible RI requires exchange
- Compute Savings Plans automatically apply to any type

---

### Question 8
> A company is planning a migration from on-premises to AWS. They need to guarantee that EC2 capacity will be available in a specific Availability Zone during the migration. Which option should they use?

**Answer: Capacity Reservations**
- "Guarantee capacity" = need reservation
- "Specific Availability Zone" = capacity reservation is AZ-specific
- No commitment required, just pay On-Demand rates

---

## 🎯 Exam Strategy Cheat Sheet

```
KEYWORD → PRICING MODEL MATCHER

"unpredictable, short-term, testing"           → ON-DEMAND
"fault-tolerant, batch, can interrupt"         → SPOT
"steady, predictable, 24/7, 1-3 years"         → RESERVED or SAVINGS PLANS
"flexibility, change instance types"           → SAVINGS PLANS
"BYOL, licensing, sockets, cores"              → DEDICATED HOSTS
"compliance, no shared hardware"               → DEDICATED INSTANCES
"guaranteed capacity, specific AZ"             → CAPACITY RESERVATION
```

---

## Summary

| Model | Discount | Commitment | Memory Hook |
|-------|----------|------------|-------------|
| **On-Demand** | 0% | None | "Taxi meter" |
| **Spot** | ~90% | None | "Cheap but can be evicted" |
| **Reserved (Standard)** | ~72% | 1-3 years | "Restaurant reservation" |
| **Reserved (Convertible)** | ~66% | 1-3 years | "Flexible reservation" |
| **Savings Plans** | ~72% | 1-3 years ($/hr) | "Budget commitment" |
| **Dedicated Hosts** | Varies | Optional | "Own the server" |
| **Dedicated Instances** | Varies | None | "Private hardware" |
| **Capacity Reservation** | 0% | None | "Reserve a parking spot" |

---

## 🔗 Related Topics

- [EC2 Fundamentals](ec2.md) - Complete EC2 overview
- [EC2 Instance Families](ec2-instance-families.md) - Choose the right instance
- [Auto Scaling](auto-scaling.md) - Combine with pricing for cost optimization
