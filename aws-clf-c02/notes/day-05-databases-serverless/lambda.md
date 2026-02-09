# AWS Lambda

> "Lambda = Code without servers — upload, trigger, forget about infrastructure."

## What Lambda Does

```
✅ Run code without provisioning servers
✅ Automatic scaling — handles any load
✅ Pay per invocation — no idle costs
✅ Event-driven — triggered by AWS services
```

---

## How Lambda Works

```
                    LAMBDA EXECUTION FLOW

     ┌─────────────────────────────────────────────────────┐
     │                   EVENT SOURCES                      │
     │  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────────┐   │
     │  │ S3  │  │ API │  │ SQS │  │ DDB │  │CloudWatch│   │
     │  │     │  │ GW  │  │     │  │     │  │ Events   │   │
     │  └──┬──┘  └──┬──┘  └──┬──┘  └──┬──┘  └────┬────┘   │
     │     │        │        │        │          │         │
     └─────┼────────┼────────┼────────┼──────────┼─────────┘
           │        │        │        │          │
           └────────┴────────┼────────┴──────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  AWS LAMBDA     │
                    │  ┌───────────┐  │
                    │  │ Your Code │  │
                    │  │ (Function)│  │
                    │  └───────────┘  │
                    │  • Auto-scale  │
                    │  • No servers  │
                    │  • Pay per use │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │     OUTPUT      │
                    │  • Response     │
                    │  • Write to DB  │
                    │  • Send message │
                    └─────────────────┘
```

---

## Lambda Key Limits (Exam Favorites!)

| Limit | Value | Note |
|-------|-------|------|
| **Timeout** | 15 minutes max | Hard limit, cannot increase |
| **Memory** | 128 MB to 10 GB | More memory = more vCPU |
| **Package size** | 50 MB zipped | 250 MB unzipped |
| **Concurrent executions** | 1,000 default | Soft limit, can request increase |
| **Ephemeral storage** | 512 MB to 10 GB | /tmp directory |

> **🔥 EXAM TIP:** "15 minutes max" is heavily tested. If a task runs longer, use Step Functions, Batch, or ECS instead.

---

## Lambda Triggers (Event Sources)

```
COMMON LAMBDA TRIGGERS

┌─────────────────────────────────────────────────────────────┐
│                                                              │
│   📦 S3              File upload/delete → Process images    │
│                                                              │
│   🌐 API Gateway     HTTP request → REST API backend        │
│                                                              │
│   ⏰ CloudWatch      Schedule (cron) → Cleanup jobs         │
│      Events/EventBridge                                      │
│                                                              │
│   📊 DynamoDB        Table changes → React to data updates  │
│      Streams                                                 │
│                                                              │
│   📨 SQS/SNS         Messages → Queue processing            │
│                                                              │
│   🌊 Kinesis         Stream data → Real-time analytics      │
│                                                              │
│   🔐 Cognito         User signup → Custom validation        │
│                                                              │
│   📧 SES             Email received → Email processing      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Lambda Pricing Model

```
PRICING = INVOCATIONS + DURATION

┌─────────────────────────────────────────────────────┐
│                                                      │
│   💰 INVOCATIONS                                     │
│   ─────────────────                                  │
│   $0.20 per 1 million requests                       │
│   First 1 million/month FREE                         │
│                                                      │
│   ⏱️ DURATION                                        │
│   ─────────────────                                  │
│   Charged per 1ms in GB-seconds                      │
│   More memory = higher cost per ms                   │
│   400,000 GB-seconds/month FREE                      │
│                                                      │
│   ✨ KEY BENEFIT                                     │
│   ─────────────────                                  │
│   NO CHARGE when not running!                        │
│   (Unlike EC2 which bills per hour)                  │
│                                                      │
└─────────────────────────────────────────────────────┘
```

---

## Lambda vs EC2 vs Fargate

| Feature | Lambda | EC2 | Fargate |
|---------|--------|-----|---------|
| **Type** | Serverless functions | Virtual servers | Serverless containers |
| **Management** | Zero (fully managed) | You manage OS/patching | Zero infrastructure |
| **Scaling** | Automatic, instant | Auto Scaling Groups | Automatic per task |
| **Billing** | Per invocation + duration | Per hour (always on) | Per vCPU/memory |
| **Max Duration** | 15 minutes | Unlimited | Unlimited |
| **Use When** | Short, event-driven tasks | Long-running, full control | Containerized apps |

### Decision Tree
```
Need to run code?
│
├─ Short task (<15 min)? → Lambda
│   └─ Event-driven (S3, API)? → Lambda ✅
│
├─ Long-running app? 
│   ├─ Need OS control? → EC2
│   └─ Containers? → ECS/Fargate
│
└─ Batch processing (hours)?
    ├─ Interruptible? → EC2 Spot / Batch
    └─ Container-based? → Fargate
```

---

## Lambda@Edge

> Lambda functions that run at **CloudFront edge locations** for low-latency processing.

```
              LAMBDA@EDGE AT CDN EDGES

    User Request                    Origin (S3/ALB)
         │                               ▲
         ▼                               │
    ┌─────────┐                    ┌─────┴─────┐
    │  Edge   │  ←── Lambda ──→   │  Origin   │
    │Location │    Processing      │  Request  │
    └─────────┘                    └───────────┘
```

| Trigger | Use Case |
|---------|----------|
| **Viewer Request** | URL rewrites, auth before cache |
| **Origin Request** | Add headers, change origin |
| **Origin Response** | Modify response before cache |
| **Viewer Response** | Add security headers |

**Limits:** 5 seconds (viewer) / 30 seconds (origin), 128-10GB memory

---

## Supported Languages

| Language | Runtime |
|----------|---------|
| **Python** | python3.9, python3.10, python3.11, python3.12 |
| **Node.js** | nodejs18.x, nodejs20.x |
| **Java** | java11, java17, java21 |
| **Go** | go1.x (provided.al2) |
| **Ruby** | ruby3.2 |
| **.NET** | dotnet6, dotnet8 |
| **Custom** | Bring your own runtime |

---

## Shared Responsibility Model

| AWS Manages | You Manage |
|-------------|------------|
| Physical security | Function code |
| Execution environment | Function permissions (IAM) |
| Operating system | Environment variables |
| Auto-scaling | Timeouts and memory settings |
| Patching Lambda runtime | Dependencies and libraries |

---

## Common Mistakes (Exam Traps)

| ❌ Wrong | ✅ Correct |
|----------|-----------|
| Lambda for 30-minute batch jobs | Use Step Functions, Batch, or ECS (15 min max) |
| Lambda always cheaper than EC2 | Depends on workload — constant traffic may favor EC2 |
| Lambda is a container service | Lambda runs functions, not containers (use Fargate) |
| Lambda manages your database | Lambda is compute; use RDS/DynamoDB for data |
| Lambda has no limits | 15 min timeout, 10GB memory, 1000 concurrent |

---

## Decision Scenarios

| Scenario | Service | Why |
|----------|---------|-----|
| "Process image when uploaded to S3" | **Lambda** | Event-driven, short task |
| "Run code without managing servers" | **Lambda** | Serverless by definition |
| "Scheduled cleanup task every night" | **Lambda + EventBridge** | Cron-like scheduling |
| "Build REST API backend" | **Lambda + API Gateway** | HTTP trigger to functions |
| "Process messages from SQS queue" | **Lambda + SQS** | Message queue processing |
| "24/7 web application server" | **EC2 or Fargate** | Long-running, not event-driven |
| "3-hour data processing job" | **Batch or ECS** | Exceeds 15 min limit |

---

## Exam Question Patterns

### Q1: A company wants to run code to resize images when they're uploaded to S3. They want to minimize operational overhead. Which service should they use?

<details><summary>Answer</summary>

**AWS Lambda**

Lambda is serverless (no ops), can be triggered by S3 events, and is perfect for short processing tasks like image resizing.
</details>

### Q2: What is the MAXIMUM execution time for a single AWS Lambda invocation?

<details><summary>Answer</summary>

**15 minutes (900 seconds)**

This is a hard limit. For longer jobs, use Step Functions to chain Lambdas, or use AWS Batch/ECS.
</details>

### Q3: A company runs Lambda functions that occasionally need to run for 20 minutes. What should they do?

<details><summary>Answer</summary>

**Use AWS Step Functions or refactor to use ECS/Fargate**

Lambda max is 15 minutes. Step Functions can orchestrate multiple Lambda functions, or migrate to containers for longer tasks.
</details>

### Q4: How is AWS Lambda priced?

<details><summary>Answer</summary>

**Number of invocations + Duration (GB-seconds)**

No charge when idle. Free tier: 1M requests + 400,000 GB-seconds per month.
</details>

### Q5: Which service allows running Lambda functions at CloudFront edge locations?

<details><summary>Answer</summary>

**Lambda@Edge**

Runs Lambda at edge locations for low-latency processing of viewer requests and responses.
</details>

---

## Summary Table

| Aspect | Detail | Memory Hook |
|--------|--------|-------------|
| **What** | Serverless compute service | "Code without servers" |
| **Trigger** | Event-driven (S3, API, schedule) | "Something happens → Lambda runs" |
| **Timeout** | 15 minutes max | "Fifteen or find another way" |
| **Memory** | 128 MB to 10 GB | "More memory = more vCPU" |
| **Pricing** | Per invocation + duration | "Pay only when running" |
| **Languages** | Python, Node.js, Java, Go, .NET, Ruby | "All popular languages" |
| **Scaling** | Automatic, instant | "From 0 to 1000s in seconds" |
| **Edge** | Lambda@Edge at CloudFront | "Lambda at the edge" |

---

## Quick Reference

```
LAMBDA MENTAL MODEL

┌─────────────────────────────────────────────┐
│  EVENT → FUNCTION → OUTPUT                   │
│  ─────────────────────────────────          │
│  • Upload file → Resize → Save              │
│  • HTTP request → Process → Response        │
│  • Schedule → Cleanup → Complete            │
│  • Message → Transform → Forward            │
└─────────────────────────────────────────────┘

LIMITS TO REMEMBER
• 15 min timeout
• 10 GB memory
• 1000 concurrent (soft)
• Pay per use (no idle cost)
```
