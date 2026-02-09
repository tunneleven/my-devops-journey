# EC2 Instance Families

> "Match the right instance to your workload bottleneck — CPU, RAM, Storage, or GPU."

## What Are Instance Families?

```
✅ Instance families group EC2 instances by optimization type
✅ Each family is designed for specific workload patterns
✅ Choosing the right family = better performance + lower cost
✅ CLF-C02 exam loves testing "which family for which scenario"
```

---

## Instance Naming Convention

```
    m5.2xlarge
    │ │  │
    │ │  └── SIZE: nano < micro < small < medium < large < xlarge < 2xlarge...
    │ │           (More vCPUs and RAM as size increases)
    │ │
    │ └───── GENERATION: Higher number = newer, better efficiency
    │                    (m5 → m6 → m7 = progressively better)
    │
    └─────── FAMILY: Letter indicating optimization type
                     M = General, C = Compute, R = Memory, etc.
```

### Additional Naming Suffixes

| Suffix | Meaning | Example |
|--------|---------|---------|
| **g** | AWS Graviton (ARM) | m7g.large |
| **a** | AMD processor | m6a.xlarge |
| **i** | Intel processor | m6i.large |
| **n** | Network optimized | m5n.large |
| **d** | Local NVMe storage | m5d.large |
| **z** | High frequency | m5zn.large |

---

## The 5 Instance Family Categories

```
EC2 INSTANCE FAMILIES
├── 🌐 GENERAL PURPOSE (M, T, Mac)
│   └── Balanced CPU/Memory/Network
│
├── ⚡ COMPUTE OPTIMIZED (C)
│   └── High CPU, lower memory ratio
│
├── 🧠 MEMORY OPTIMIZED (R, X, z, u-)
│   └── High RAM, for in-memory workloads
│
├── 💾 STORAGE OPTIMIZED (I, D, H)
│   └── High IOPS, fast local storage
│
└── 🎮 ACCELERATED COMPUTING (P, G, Trn, Inf, F)
    └── GPU/TPU/FPGA for ML and graphics
```

---

## 🌐 General Purpose (M, T, Mac)

> **Memory Hook**: "**M**iddle ground, **T**urbo bursts"

### Family Comparison

| Family | Key Feature | Use Case | Exam Keyword |
|--------|-------------|----------|--------------|
| **M** | Balanced (50/50 CPU/RAM) | Web servers, small DBs, app servers | "general purpose", "balanced" |
| **T** | Burstable (CPU credits) | Dev/test, low-traffic websites | "variable traffic", "cost-effective" |
| **Mac** | Apple hardware | iOS/macOS development, Xcode | "macOS", "iOS app" |

### Deep Dive: T-Series (Burstable)

```
T-SERIES CPU CREDIT SYSTEM

    Baseline CPU: 20%
    ├── Normal use: Accumulate credits
    ├── Burst use: Spend credits (up to 100% CPU)
    └── Credits depleted: Throttled to baseline
    
    ┌────────────────────────────────────────┐
    │ CPU                                    │
    │  ▲                                     │
    │  │    ████                             │
    │  │   ██████                            │
    │ 20%───────────────── Baseline          │
    │  │                                     │
    │  └──────────────────────────────► Time │
    └────────────────────────────────────────┘
    
    T3 Modes:
    ├── Standard Mode: Pay for extra burst (default)
    └── Unlimited Mode: Always burst, pay per vCPU-hour
```

### Real-World Examples

| Scenario | Family | Why |
|----------|--------|-----|
| WordPress blog (low traffic) | **T3.micro** | Bursty traffic, cost-effective |
| Corporate web app | **M6i.large** | Consistent load, balanced needs |
| iOS CI/CD pipeline | **Mac** | Requires macOS for Xcode builds |

---

## ⚡ Compute Optimized (C)

> **Memory Hook**: "**C**PU cruncher"

### When to Use

```
COMPUTE OPTIMIZED = HIGH CPU : LOW MEMORY RATIO

Perfect for:
├── 🔬 Scientific modeling
├── 🎮 Gaming servers (CPU-bound)
├── 📹 Video encoding/transcoding
├── 📊 Batch processing
├── 🌐 High-performance web servers
└── 🤖 ML inference (CPU-based)
```

### Comparison with General Purpose

| Aspect | M6i.large | C6i.large |
|--------|-----------|-----------|
| vCPUs | 2 | 2 |
| Memory | 8 GB | 4 GB |
| Ratio | 1:4 (balanced) | 1:2 (CPU-focused) |
| Best For | General apps | CPU-intensive |

### Real-World Examples

| Scenario | Instance | Why |
|----------|----------|-----|
| Apache Spark batch jobs | **C6i.2xlarge** | CPU-intensive data processing |
| Video transcoding | **C5.4xlarge** | High clock speed for encoding |
| Game server (Minecraft) | **C5.large** | Low latency, CPU-bound |

---

## 🧠 Memory Optimized (R, X, z, High Memory)

> **Memory Hook**: "**R**AM-focused, e**X**tra memory"

### Family Breakdown

| Family | RAM Capacity | Use Case |
|--------|--------------|----------|
| **R** | High (up to 768 GB) | In-memory DBs (Redis, Memcached) |
| **X** | Extra High (up to 4 TB) | SAP HANA, large in-memory analytics |
| **z** | High + compute | Memory-bound + high frequency |
| **u-** (High Memory) | Extreme (up to 24 TB) | Massive in-memory workloads |

### Memory-to-CPU Ratios

```
MEMORY RATIOS BY FAMILY

General Purpose (M):     1 vCPU : 4 GB RAM
Memory Optimized (R):    1 vCPU : 8 GB RAM  ← 2x memory!
Memory Optimized (X):    1 vCPU : 16 GB RAM ← 4x memory!

Example:
├── m6i.xlarge:  4 vCPU,  16 GB RAM
├── r6i.xlarge:  4 vCPU,  32 GB RAM  ← Same vCPU, 2x RAM
└── x2idn.xlarge: 4 vCPU, 64 GB RAM  ← Same vCPU, 4x RAM
```

### Real-World Examples

| Scenario | Instance | Why |
|----------|----------|-----|
| Redis cache cluster | **R6i.large** | In-memory caching |
| SAP HANA database | **X2idn.xlarge** | Massive in-memory DB |
| Real-time analytics | **R5.2xlarge** | Fast data processing in RAM |

---

## 💾 Storage Optimized (I, D, H)

> **Memory Hook**: "**I**ntense **I**/O"

### Family Breakdown

| Family | Storage Type | Best For |
|--------|--------------|----------|
| **I** | NVMe SSD (high IOPS) | NoSQL (Cassandra, MongoDB), transactional DBs |
| **D** | Dense HDD (high capacity) | Data lakes, Hadoop, HDFS |
| **H** | HDD + HPC | Sequential I/O, MapReduce, log processing |

### When to Use Each

```
STORAGE OPTIMIZED DECISION TREE

Need high random IOPS?
├── YES → I-series (SSD)
│   └── Use for: MongoDB, Cassandra, real-time analytics
│
└── NO → Need high sequential throughput?
    ├── YES → D-series or H-series (HDD)
    │   └── Use for: Hadoop, data warehousing, HDFS
    └── NO → Consider EBS instead
```

### Real-World Examples

| Scenario | Instance | Why |
|----------|----------|-----|
| MongoDB cluster | **I3.2xlarge** | High IOPS for random reads/writes |
| Hadoop data lake | **D3.xlarge** | Dense HDD for batch processing |
| Log aggregation (ELK) | **I4i.large** | Fast indexing with NVMe |

---

## 🎮 Accelerated Computing (P, G, Trn, Inf, F)

> **Memory Hook**: "**G**PU power for ML and **G**raphics"

### Family Breakdown

| Family | Hardware | Use Case |
|--------|----------|----------|
| **P** | NVIDIA GPUs (A100, V100) | Deep learning training, HPC |
| **G** | NVIDIA GPUs (T4, A10G) | Graphics, game streaming, video |
| **Trn** | AWS Trainium | Distributed ML training (cost-effective) |
| **Inf** | AWS Inferentia | ML inference (low latency) |
| **F** | FPGAs | Custom hardware acceleration |
| **DL** | Deep Learning AMI optimized | AI/ML with frameworks |
| **VT** | Video transcoding | Media processing |

### Training vs Inference

```
ML WORKFLOW → INSTANCE SELECTION

                    TRAINING                    INFERENCE
                (Building model)            (Using model)
                      │                           │
                      ▼                           ▼
            ┌─────────────────┐        ┌─────────────────┐
            │   P5, Trn1      │        │   Inf2, G5      │
            │   (Heavy GPU)   │        │   (Optimized)   │
            └─────────────────┘        └─────────────────┘
                      │                           │
               Hours/Days                   Milliseconds
               High cost                    Low cost
```

### Real-World Examples

| Scenario | Instance | Why |
|----------|----------|-----|
| Training GPT model | **P5.48xlarge** | NVIDIA H100 GPUs |
| Real-time ML inference | **Inf2.xlarge** | Low latency, cost-effective |
| Cloud gaming | **G5.xlarge** | NVIDIA A10G for graphics |
| Video streaming service | **VT1.3xlarge** | Hardware video transcoding |

---

## 🔥 Real Exam Questions (With Answers)

### Question 1
> A company needs to run a web application that experiences variable traffic throughout the day. During peak hours, CPU usage can spike to 80%, but most of the time it stays at 20%. Which instance type is MOST cost-effective?

**Answer: T3 (Burstable)**
- Variable traffic = bursty pattern
- Low baseline + occasional spikes = perfect for T-series CPU credits
- More cost-effective than M-series for this pattern

---

### Question 2
> A data analytics company is running Apache Spark jobs that are CPU-bound. The jobs complete slowly on current general-purpose instances. Which instance family should they migrate to?

**Answer: C (Compute Optimized)**
- "CPU-bound" = Compute Optimized
- Spark batch processing = high CPU requirement
- C-series has higher CPU-to-memory ratio

---

### Question 3
> A company runs an in-memory Redis cache that requires 128 GB of RAM. The cache is consistently hitting memory limits. Which instance family is MOST appropriate?

**Answer: R (Memory Optimized)**
- "In-memory cache" = Memory Optimized
- "Hitting memory limits" = need more RAM
- R-series provides 8 GB RAM per vCPU (vs 4 GB for M-series)

---

### Question 4
> A gaming company needs to train a deep learning model using GPU acceleration. The training is expected to take several days. Which instance family should they use?

**Answer: P (Accelerated Computing - Training)**
- "Deep learning training" = P-series
- "GPU acceleration" = NVIDIA GPUs
- P-series has most powerful GPUs for training

---

### Question 5
> A company runs a NoSQL database (Cassandra) that requires high disk IOPS for random read/write operations. Which instance family is MOST suited?

**Answer: I (Storage Optimized)**
- "High disk IOPS" = Storage Optimized
- "NoSQL (Cassandra)" = I-series SSD
- "Random read/write" = NVMe SSD performance

---

### Question 6
> A startup wants to deploy a machine learning model for real-time inference with the lowest latency possible. Which AWS chip should they consider?

**Answer: Inf (AWS Inferentia)**
- "Real-time inference" = Inferentia
- "Lowest latency" = AWS-designed inference chip
- Inf2 is optimized for production ML inference

---

### Question 7
> A company running a balanced web application can't decide between M and T series. Traffic is steady with no spikes. Which should they choose?

**Answer: M (General Purpose)**
- "Steady traffic, no spikes" = no need for burstable
- T-series is for variable workloads
- M-series provides consistent performance

---

## 🎯 Exam Strategy Cheat Sheet

```
KEYWORD → INSTANCE FAMILY MATCHER

"balanced, general purpose, web server"          → M (General Purpose)
"dev/test, low traffic, variable, burst"         → T (Burstable)
"CPU-intensive, batch, HPC, scientific"          → C (Compute Optimized)
"in-memory, cache, Redis, SAP HANA"              → R/X (Memory Optimized)
"high IOPS, NoSQL, Cassandra, MongoDB"           → I (Storage Optimized)
"Hadoop, data lake, HDFS, big data"              → D/H (Storage Optimized)
"ML training, deep learning, GPU"                → P/Trn (Accelerated)
"ML inference, real-time prediction"             → Inf (Accelerated)
"graphics, gaming, video streaming"              → G (Accelerated)
"iOS, macOS, Xcode"                              → Mac
```

---

## Summary

| Family | Memory Hook | Best For |
|--------|-------------|----------|
| **T** | **T**urbo bursts | Variable traffic, dev/test |
| **M** | **M**iddle ground | Balanced workloads |
| **C** | **C**PU cruncher | Compute-intensive tasks |
| **R** | **R**AM focused | In-memory databases |
| **X** | e**X**tra memory | Large in-memory (SAP HANA) |
| **I** | **I**ntense IOPS | NoSQL, transactional DBs |
| **D/H** | **D**ense storage | Data lakes, Hadoop |
| **P** | Deep learning **P**ower | ML training |
| **G** | **G**raphics | Gaming, video |
| **Trn** | AWS **Tr**ainium | Cost-effective ML training |
| **Inf** | **Inf**erence | ML serving, low latency |

---

## 🔗 Related Topics

- [EC2 Fundamentals](ec2.md) - Complete EC2 overview
- [EC2 Pricing Models](ec2.md#pricing-models) - Cost optimization
- [Auto Scaling](auto-scaling.md) - Scaling instance families
