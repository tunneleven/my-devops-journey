# AWS Analytics Services

> "Modern analytics stack = Query (Athena), Transform (Glue), Analyze (EMR), Visualize (QuickSight)"

## Overview: The Analytics Pipeline

```
AWS ANALYTICS SERVICES

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                                                                         │
    │   RAW DATA              PREPARE              ANALYZE            VISUALIZE│
    │   ────────              ───────              ───────            ─────────│
    │                                                                         │
    │   ┌───────┐            ┌───────┐            ┌───────┐          ┌───────┐│
    │   │       │            │       │            │       │          │       ││
    │   │  S3   │──────────►│ GLUE  │──────────►│ATHENA │────────►│QUICK- ││
    │   │(Data) │  Crawl/   │(ETL)  │  Catalog  │(Query)│  Results │SIGHT  ││
    │   │       │  Catalog  │       │           │       │          │(BI)   ││
    │   └───────┘            └───────┘            └───────┘          └───────┘│
    │       │                    │                    │                       │
    │       │                    ▼                    │                       │
    │       │            ┌───────────────┐            │                       │
    │       └───────────►│     EMR       │◄───────────┘                       │
    │         Big Data   │(Hadoop/Spark) │    Complex                         │
    │                    └───────────────┘    Processing                      │
    │                                                                         │
    └─────────────────────────────────────────────────────────────────────────┘
```

| Service | Role | Memory Hook |
|---------|------|-------------|
| **Athena** | Query S3 with SQL | "SQL goggles for S3" |
| **Glue** | ETL + Data Catalog | "Librarian + data cleaner" |
| **EMR** | Big data processing | "Hadoop/Spark cluster in the cloud" |
| **QuickSight** | BI dashboards | "Graphs for executives" |

---

---

# 🔍 Amazon Athena

> "Athena = SQL on S3 — query your data lake without servers or loading."

## What Athena Does

```
✅ Query S3 data using standard SQL
✅ Serverless — no infrastructure to manage
✅ Pay per query — charged for data scanned ($5/TB)
✅ Supports CSV, JSON, Parquet, ORC, Avro
✅ Works with AWS Glue Data Catalog
```

---

## How Athena Works

> **Memory Hook**: "Athena = **SQL goggles for S3** — look at your data without moving it"

```
ATHENA ARCHITECTURE

    ┌─────────────────────────────────────────────────────────────────┐
    │                                                                 │
    │     YOU                                                         │
    │      │                                                          │
    │      │  SQL Query: "SELECT * FROM logs WHERE status = 500"     │
    │      ▼                                                          │
    │  ┌────────────────────────────────┐                            │
    │  │        AMAZON ATHENA           │                            │
    │  │     (Serverless Presto)        │                            │
    │  └────────────┬───────────────────┘                            │
    │               │                                                 │
    │      ┌────────┴────────┐                                       │
    │      │                 │                                        │
    │      ▼                 ▼                                        │
    │  ┌────────────┐   ┌─────────────────────────────┐              │
    │  │Glue Data   │   │         S3 BUCKET           │              │
    │  │Catalog     │   │                             │              │
    │  │(Metadata)  │   │  logs/2024/01/file1.parquet │              │
    │  │            │   │  logs/2024/01/file2.parquet │              │
    │  │ • Table    │   │  logs/2024/02/file3.parquet │              │
    │  │   schemas  │   │                             │              │
    │  │ • Partitions│  │  ← Data stays in S3!        │              │
    │  └────────────┘   └─────────────────────────────┘              │
    │                                                                 │
    │   No ETL! No loading! Query in place!                          │
    │                                                                 │
    └─────────────────────────────────────────────────────────────────┘
```

---

## 📂 File Formats

| Format | Type | Cost Efficiency |
|--------|------|-----------------|
| **CSV** | Row-based | ⭐ Basic |
| **JSON** | Row-based | ⭐ Basic |
| **Parquet** | Columnar | ⭐⭐⭐ 80-90% savings! |
| **ORC** | Columnar | ⭐⭐⭐ 80-90% savings! |

> [!TIP]
> **Use Parquet or ORC to save 80-90% on costs!** Athena only scans columns needed.

---

## 💰 Athena Pricing

**$5 per TB of data scanned** — no servers, no upfront costs.

| Optimization | Savings |
|-------------|---------|
| Use Parquet/ORC | 80-90% |
| Partition data | Skip irrelevant folders |
| Compress files | Less data to scan |

---

## 🔗 Athena Federated Query

> **Memory Hook**: "Federated = **One SQL, many sources** — S3 + databases together"

Query beyond S3: RDS, DynamoDB, Redshift, CloudWatch Logs, and more.

---

---

# 🧹 AWS Glue

> "Glue = The librarian AND janitor — catalogs your data AND cleans it up."

## What Glue Does

```
✅ Serverless ETL (Extract, Transform, Load)
✅ Data Catalog — central metadata repository
✅ Crawlers — auto-discover schemas
✅ Job Bookmarks — incremental processing
✅ Integrates with Athena, Redshift, EMR
```

---

## Glue Components

### What is Glue Data Catalog?

> **Memory Hook**: "Data Catalog = **Library card catalog** — knows what data you have and where it is"

The **Glue Data Catalog** stores metadata:
- Table schemas (columns, data types)
- Partition information
- S3 locations

```
GLUE DATA CATALOG

    ┌────────────────────────────────────────────────────────────┐
    │                                                            │
    │   Database: sales_db                                       │
    │     └── Table: transactions                                │
    │           ├── Column: order_id (string)                    │
    │           ├── Column: amount (decimal)                     │
    │           ├── Column: date (date)                          │
    │           └── Location: s3://bucket/transactions/          │
    │                                                            │
    │   Shared with: Athena, Redshift Spectrum, EMR, SageMaker  │
    │                                                            │
    └────────────────────────────────────────────────────────────┘
```

---

### What are Glue Crawlers?

> **Memory Hook**: "Crawler = **Robot librarian** — scans your data, figures out the schema"

**Glue Crawlers** automatically discover and catalog your data:

```
CRAWLER WORKFLOW

    1. Point crawler at S3 bucket
           │
           ▼
    2. Crawler scans sample files
           │
           ▼
    3. Infers schema (columns, types)
           │
           ▼
    4. Creates/updates tables in Data Catalog
           │
           ▼
    5. Athena can now query the data! ✅
```

---

### What are Glue ETL Jobs?

> **Memory Hook**: "ETL Jobs = **Data transformation factory** — clean, convert, load"

**Glue ETL Jobs** transform raw data into analytics-ready format:

```
GLUE ETL JOB

    ┌──────────────┐      ┌──────────────┐      ┌──────────────┐
    │   EXTRACT    │      │  TRANSFORM   │      │     LOAD     │
    │              │      │              │      │              │
    │  Raw CSV in  │─────►│  Clean data  │─────►│  Parquet to  │
    │  S3 bucket   │      │  Convert     │      │  S3 + Catalog│
    │              │      │  Aggregate   │      │              │
    └──────────────┘      └──────────────┘      └──────────────┘
    
    Serverless! Pay for compute time only.
```

---

## Glue Use Cases

| Use Case | Example |
|----------|---------|
| **Schema discovery** | Crawl new S3 data, create tables automatically |
| **Data transformation** | Convert CSV to Parquet for cheaper Athena queries |
| **Data lake preparation** | Clean and organize raw data for analytics |
| **Incremental processing** | Process only new data with job bookmarks |

---

---

# ⚡ Amazon EMR

> "EMR = Your own Hadoop/Spark cluster — managed by AWS, pay as you go."

## What EMR Does

```
✅ Managed Hadoop, Spark, Presto, HBase clusters
✅ Process petabytes of data
✅ Auto-scaling with spot instances
✅ EMR Studio for Jupyter notebooks
✅ Transient clusters — spin up, process, terminate
```

---

## How EMR Works

> **Memory Hook**: "EMR = **Big data factory** — bring your Spark jobs, AWS handles the servers"

```
EMR ARCHITECTURE

    ┌─────────────────────────────────────────────────────────────────┐
    │                                                                 │
    │                        EMR CLUSTER                              │
    │   ┌─────────────────────────────────────────────────────────┐  │
    │   │                                                         │  │
    │   │   ┌────────────┐   ┌────────────┐   ┌────────────┐     │  │
    │   │   │   MASTER   │   │   CORE     │   │   TASK     │     │  │
    │   │   │   NODE     │   │   NODES    │   │   NODES    │     │  │
    │   │   │            │   │            │   │            │     │  │
    │   │   │ Coordinates│   │ Store data │   │ Compute    │     │  │
    │   │   │ cluster    │   │ + compute  │   │ only       │     │  │
    │   │   └────────────┘   └────────────┘   └────────────┘     │  │
    │   │                                                         │  │
    │   │   Frameworks: Hadoop, Spark, Presto, Hive, HBase...    │  │
    │   │                                                         │  │
    │   └─────────────────────────────────────────────────────────┘  │
    │                            │                                    │
    │                            ▼                                    │
    │                    ┌───────────────┐                           │
    │                    │      S3       │                           │
    │                    │  (Data Lake)  │                           │
    │                    └───────────────┘                           │
    │                                                                 │
    └─────────────────────────────────────────────────────────────────┘
```

---

## EMR vs Glue

| Aspect | **AWS Glue** | **Amazon EMR** |
|--------|--------------|----------------|
| **Management** | Fully serverless | Managed clusters |
| **Use Case** | ETL, data prep | Complex big data processing |
| **Control** | Limited (Glue handles everything) | Full control over frameworks |
| **Frameworks** | Spark only | Hadoop, Spark, Presto, Hive, HBase... |
| **Pricing** | Pay per DPU-hour | Pay per instance-hour |
| **Best For** | Simple ETL | Custom big data workloads |

> **Decision rule:** Use Glue for serverless ETL. Use EMR when you need specific frameworks or custom configs.

---

## EMR Use Cases

| Use Case | Example |
|----------|---------|
| **Big data processing** | Process petabytes of log data |
| **Machine learning** | Train models on massive datasets |
| **Real-time analytics** | Stream processing with Spark Streaming |
| **Graph processing** | Social network analysis |
| **Interactive queries** | Ad-hoc SQL with Presto/Trino |

---

---

# 📊 Amazon QuickSight

> "QuickSight = Charts for executives — serverless BI dashboards anyone can use."

## What QuickSight Does

```
✅ Serverless BI dashboards and visualizations
✅ SPICE engine — super-fast in-memory queries
✅ ML insights — anomaly detection, forecasting
✅ Natural language queries (ask in English!)
✅ Pay-per-session pricing
```

---

## How QuickSight Works

> **Memory Hook**: "QuickSight = **Excel charts on steroids** — connected to your data lake"

```
QUICKSIGHT ARCHITECTURE

    ┌─────────────────────────────────────────────────────────────────┐
    │                                                                 │
    │   DATA SOURCES                    QUICKSIGHT                    │
    │   ────────────                    ──────────                    │
    │                                                                 │
    │   ┌─────────┐                   ┌─────────────────────────────┐│
    │   │ Athena  │──────────────────►│                             ││
    │   └─────────┘                   │        SPICE ENGINE         ││
    │   ┌─────────┐                   │     (In-Memory Cache)       ││
    │   │Redshift │──────────────────►│                             ││
    │   └─────────┘                   │    Sub-second queries!      ││
    │   ┌─────────┐                   │                             ││
    │   │   RDS   │──────────────────►│                             ││
    │   └─────────┘                   └─────────────┬───────────────┘│
    │   ┌─────────┐                                 │                │
    │   │   S3    │─────────────────────────────────┤                │
    │   └─────────┘                                 ▼                │
    │                                 ┌─────────────────────────────┐│
    │                                 │       DASHBOARDS            ││
    │                                 │                             ││
    │                                 │  📈 📊 📉 🥧                ││
    │                                 │                             ││
    │                                 │  Interactive & Embeddable  ││
    │                                 └─────────────────────────────┘│
    │                                                                 │
    └─────────────────────────────────────────────────────────────────┘
```

---

## QuickSight Features

### What is SPICE?

> **Memory Hook**: "SPICE = **Data in RAM** — queries in milliseconds, not seconds"

**SPICE** (Super-fast, Parallel, In-memory Calculation Engine):
- Loads data into memory for ultra-fast queries
- Up to 1 TB per dataset
- No query charges when using SPICE

---

### What are ML Insights?

> **Memory Hook**: "ML Insights = **AI assistant** for your charts"

QuickSight includes built-in machine learning:
- **Anomaly detection** — spots unusual patterns
- **Forecasting** — predicts future trends
- **Natural language queries** — ask questions in English!

---

## QuickSight Use Cases

| Use Case | Example |
|----------|---------|
| **Executive dashboards** | KPIs, sales metrics, financial reports |
| **Marketing analytics** | Campaign performance, customer segments |
| **Operational monitoring** | Real-time metrics from Athena/Redshift |
| **Embedded analytics** | Add charts to your own applications |

---

---

# Service Comparison

| Service | Type | Best For |
|---------|------|----------|
| **Athena** | Query | SQL on S3, ad-hoc analysis |
| **Glue** | ETL + Catalog | Data prep, schema discovery |
| **EMR** | Big Data | Hadoop/Spark, custom processing |
| **QuickSight** | BI | Dashboards, visualizations |

---

## When to Use Each Service

```
DECISION TREE

    What do you need?
           │
    ┌──────┼──────┬──────────┬────────────┐
    │      │      │          │            │
    ▼      ▼      ▼          ▼            ▼
 Query   ETL/    Big Data   Visualize   Schema
 S3?     Transform?  Spark?   Charts?   Discovery?
    │      │      │          │            │
    ▼      ▼      ▼          ▼            ▼
 ATHENA  GLUE    EMR    QUICKSIGHT  GLUE CRAWLER
```

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Athena requires servers" | **NO!** Athena is fully serverless. | ⚠️ Yes |
| "Glue is only for ETL" | **NO!** Glue Data Catalog is used by Athena, EMR, Redshift too. | ⚠️ Yes |
| "EMR is serverless like Glue" | **NO!** EMR manages clusters. Glue is serverless. | ⚠️ Yes |
| "QuickSight stores data" | **NO!** SPICE caches data, but source is external (S3, RDS, etc.) | ⚠️ Sometimes |
| "Use EMR for simple ETL" | **OVERKILL!** Use Glue for simple ETL. EMR for complex big data. | ⚠️ Yes |

---

## 🎯 Decision Scenarios

**Scenario 1: Query S3 logs without infrastructure**
> "Need to analyze CloudTrail logs in S3 with SQL."

**Answer:** Athena
**Why:** Serverless SQL on S3. No infrastructure.

---

**Scenario 2: Convert CSV to Parquet automatically**
> "Raw CSV files need to be converted for cheaper Athena queries."

**Answer:** AWS Glue ETL
**Why:** Serverless ETL to transform and load data.

---

**Scenario 3: Run Spark ML jobs on petabytes**
> "Data science team needs custom Spark for machine learning."

**Answer:** Amazon EMR
**Why:** Managed Spark clusters with full control.

---

**Scenario 4: Executive dashboards from Athena**
> "CEO wants visual charts from sales data in S3."

**Answer:** QuickSight (connected to Athena)
**Why:** Serverless BI with SPICE for fast charts.

---

**Scenario 5: Auto-discover new data schemas**
> "New files land in S3 daily. Need to auto-catalog them."

**Answer:** Glue Crawler
**Why:** Crawlers scan S3 and update Data Catalog automatically.

---

**Scenario 6: Simple ETL vs complex Spark job**
> "Need to clean data and load to Redshift."

**Answer:** Glue (if simple) or EMR (if complex)
**Why:** Glue for serverless ETL. EMR for custom frameworks.

---

## Common Exam Questions

**Q1**: Which service allows you to query S3 data using SQL without provisioning servers?
> **Athena** - Serverless, pay-per-query SQL on S3.

**Q2**: What AWS service provides a central metadata repository used by Athena, EMR, and Redshift?
> **AWS Glue Data Catalog** - Central schema and metadata store.

**Q3**: Which service should you use for managed Hadoop and Spark clusters?
> **Amazon EMR** - Managed big data platform.

**Q4**: What is QuickSight SPICE?
> **In-memory cache** for sub-second query performance on dashboards.

**Q5**: When should you use Glue vs EMR for data processing?
> **Glue:** Serverless, simple ETL. **EMR:** Full control, complex Spark/Hadoop.

**Q6**: Which service is best for creating executive BI dashboards?
> **Amazon QuickSight** - Serverless BI with ML insights.

---

## Summary

| Service | Memory Hook |
|---------|-------------|
| **Athena** | "SQL goggles for S3 — query without loading" |
| **Glue Data Catalog** | "Library card catalog — knows your data" |
| **Glue Crawlers** | "Robot librarian — discovers schemas" |
| **Glue ETL** | "Data cleaning factory — transform and load" |
| **EMR** | "Big data factory — Hadoop/Spark in the cloud" |
| **QuickSight** | "Charts for executives — serverless BI" |
| **SPICE** | "Data in RAM — millisecond queries" |

---

## 🔗 Related Topics

- [Amazon S3](s3.md) - Data lake storage
- [Amazon Redshift](elasticache-redshift.md) - Data warehouse
- [AWS Lambda](lambda.md) - Serverless compute
