# AWS CloudTrail

> CloudTrail = Your AWS security camera - records WHO did WHAT, WHEN, and from WHERE

---

## The Big Picture

```
                    EVERY API CALL IN AWS
                           │
                           ▼
                  ┌─────────────────┐
                  │   CloudTrail    │
                  │   📹 Records    │
                  └────────┬────────┘
                           │
    ┌──────────────────────┼──────────────────────┐
    │                      │                      │
    ▼                      ▼                      ▼
┌─────────┐         ┌─────────────┐        ┌─────────┐
│  WHO?   │         │   WHAT?     │        │  WHEN?  │
│ User/   │         │ API action  │        │ Time &  │
│ Role    │         │ Parameters  │        │ IP addr │
└─────────┘         └─────────────┘        └─────────┘
```

---

## What CloudTrail Logs

Every log entry contains:

| Field | Example |
|-------|---------|
| **Who** | IAM user "john" or role "AdminRole" |
| **What** | `DeleteBucket`, `TerminateInstances` |
| **When** | 2024-02-08T19:51:46Z |
| **Where from** | IP address 192.168.1.1 |
| **Request** | Parameters sent |
| **Response** | Success or error |

---

## Event Types

| Type | What It Logs | Default | Cost |
|------|--------------|---------|------|
| **Management Events** | Control plane (create, delete, modify) | ✅ ON | Free (90 days) |
| **Data Events** | Data plane (S3 GetObject, Lambda invoke) | ❌ OFF | Paid |
| **Insights Events** | Unusual activity detection | ❌ OFF | Paid |

### Examples

```
Management Events (ON by default):
├── CreateBucket
├── DeleteInstance
├── ModifySecurityGroup
└── CreateUser

Data Events (OFF by default):
├── GetObject (S3)
├── PutObject (S3)
└── Invoke (Lambda)
```

---

## Event History vs Trails

| Feature | Event History | Trail |
|---------|---------------|-------|
| **Duration** | Last **90 days** | **Indefinite** |
| **Storage** | AWS console only | **S3 bucket** |
| **Cost** | **FREE** | S3 storage cost |
| **Setup** | Automatic | You create |

```
Need logs > 90 days?
├── NO → Event History (free, automatic)
└── YES → Create a Trail → S3 bucket
```

---

## CloudTrail vs CloudWatch vs Config (EXAM FAVORITE!)

| Service | What It Does | Key Question |
|---------|--------------|--------------|
| **CloudTrail** | **API activity logs** | "Who did what?" |
| **CloudWatch** | **Metrics & alarms** | "How is it performing?" |
| **Config** | **Resource compliance** | "Is it configured correctly?" |

### Memory Hook

```
Cloud TRAIL  = Follow the TRAIL (audit who did what)
Cloud WATCH  = WATCH the metrics (performance)
Config       = CONFIG-uration compliance (rules)
```

---

## Integration with Other Services

```
                  CloudTrail
                      │
    ┌─────────────────┼─────────────────┐
    │                 │                 │
    ▼                 ▼                 ▼
┌───────┐       ┌───────────┐     ┌──────────┐
│  S3   │       │CloudWatch │     │   SNS    │
│ Store │       │  Alarms   │     │  Alerts  │
│ Logs  │       │           │     │          │
└───────┘       └───────────┘     └──────────┘
```

---

## 📝 Exam Practice Questions

### Question 1
**A security team needs to find out who deleted an S3 bucket last week. Which service should they use?**

A) Amazon CloudWatch  
B) AWS CloudTrail  
C) AWS Config  
D) Amazon Inspector  

<details><summary>Answer</summary>
**B) AWS CloudTrail** - CloudTrail logs all API calls including who performed actions like DeleteBucket.
</details>

---

### Question 2
**How long does CloudTrail Event History retain management events for FREE?**

A) 30 days  
B) 60 days  
C) 90 days  
D) 365 days  

<details><summary>Answer</summary>
**C) 90 days** - Event History provides 90 days of management events at no cost.
</details>

---

### Question 3
**A company needs to retain API logs for 7 years for compliance. What should they do?**

A) Use Event History  
B) Create a trail that stores logs in S3  
C) Use CloudWatch Logs  
D) Enable AWS Config  

<details><summary>Answer</summary>
**B) Create a trail that stores logs in S3** - Trails store logs in S3 indefinitely for long-term retention.
</details>

---

### Question 4
**Which CloudTrail event type is logged by DEFAULT?**

A) Data Events  
B) Insights Events  
C) Management Events  
D) All events  

<details><summary>Answer</summary>
**C) Management Events** - Management events are logged by default. Data and Insights events require explicit configuration.
</details>

---

### Question 5
**What is the PRIMARY difference between CloudTrail and CloudWatch?**

A) CloudTrail monitors CPU usage, CloudWatch logs API calls  
B) CloudTrail logs API calls, CloudWatch monitors metrics  
C) CloudTrail is free, CloudWatch is paid  
D) CloudTrail is regional, CloudWatch is global  

<details><summary>Answer</summary>
**B) CloudTrail logs API calls, CloudWatch monitors metrics** - CloudTrail tracks who did what; CloudWatch tracks how things are performing.
</details>

---

## Memory Summary

| Question | Answer |
|----------|--------|
| "Who deleted the bucket?" | **CloudTrail** |
| "When was the instance terminated?" | **CloudTrail** |
| "Is CPU above 80%?" | CloudWatch |
| "Is encryption enabled?" | Config |

---

## Quick Decision Guide

| Exam Keyword | Answer |
|--------------|--------|
| "Who did what" | **CloudTrail** |
| "API activity" | **CloudTrail** |
| "Audit trail" | **CloudTrail** |
| "Compliance logging" | **CloudTrail** |
| "Deleted by whom" | **CloudTrail** |
| "Performance metrics" | CloudWatch |
| "Resource compliance" | Config |
