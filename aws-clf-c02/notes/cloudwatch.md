# Amazon CloudWatch

> "The eyes and ears of your AWS infrastructure — watch everything, alert on anything."

## What CloudWatch Does

```
✅ Collect metrics from AWS services (CPU, Network, Disk)
✅ Create alarms to trigger actions (Auto Scaling, SNS)
✅ Store and search log files (EC2, Lambda, applications)
✅ React to events and schedule tasks (EventBridge)
✅ Visualize everything on dashboards
```

---

## CloudWatch Components Overview

```
CLOUDWATCH ARCHITECTURE

    ┌─────────────────────────────────────────────────────────────────────────┐
    │                        AMAZON CLOUDWATCH                                 │
    │                                                                          │
    │   ┌──────────────────────────────────────────────────────────────────┐  │
    │   │                        DASHBOARDS                                 │  │
    │   │    📊 Visualize metrics, alarms, and logs in one place           │  │
    │   └──────────────────────────────────────────────────────────────────┘  │
    │                                    ▲                                     │
    │            ┌───────────────────────┼───────────────────────┐            │
    │            │                       │                       │            │
    │   ┌────────┴────────┐   ┌──────────┴──────────┐   ┌───────┴────────┐   │
    │   │    METRICS      │   │      ALARMS         │   │     LOGS       │   │
    │   │                 │   │                     │   │                │   │
    │   │  • CPU (%)      │   │  CPU > 80%? →       │   │  • App logs    │   │
    │   │  • Network I/O  │   │  → Scale Out!       │   │  • Error logs  │   │
    │   │  • Disk I/O     │   │  → Send SNS!        │   │  • API logs    │   │
    │   │  • Custom       │   │                     │   │                │   │
    │   └────────┬────────┘   └──────────┬──────────┘   └───────┬────────┘   │
    │            │                       │                       │            │
    │            └───────────────────────┼───────────────────────┘            │
    │                                    │                                     │
    │   ┌──────────────────────────────────────────────────────────────────┐  │
    │   │                    EVENTBRIDGE (Events)                          │  │
    │   │         React to changes • Schedule tasks • Route events         │  │
    │   └──────────────────────────────────────────────────────────────────┘  │
    │                                                                          │
    └─────────────────────────────────────────────────────────────────────────┘

                                    ▲
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
    ┌───┴───┐                   ┌───┴───┐                   ┌───┴───┐
    │  EC2  │                   │Lambda │                   │  RDS  │
    └───────┘                   └───────┘                   └───────┘
```

---

## 📊 CloudWatch Metrics

> **Memory Hook**: "**Metrics** = **Measurements** — numbers over time"

### What Are Metrics?

Metrics are time-series data points tracking resource performance.

```
METRIC EXAMPLE: EC2 CPU Utilization

    100% │                    ╭───╮
         │                   ╱     ╲
     75% │            ╭─────╯       ╰──────
         │           ╱
     50% │      ╭───╯
         │     ╱
     25% │ ───╯
         │
      0% └────────────────────────────────────►
           9AM    10AM    11AM    12PM    1PM
                         Time
```

### Default vs Custom Metrics

| Type | What It Is | Examples | Cost |
|------|------------|----------|------|
| **Default** | Auto-collected by AWS | CPU, Network, Disk I/O | Free |
| **Custom** | You push via SDK/Agent | Memory, App transactions | Paid |

> [!IMPORTANT]
> **Memory (RAM) is NOT a default metric!** You must use the CloudWatch Agent to collect memory usage.

### Common Default Metrics

| Service | Built-in Metrics |
|---------|------------------|
| **EC2** | CPUUtilization, NetworkIn, NetworkOut, DiskReadOps |
| **ELB** | RequestCount, TargetResponseTime, HealthyHostCount |
| **RDS** | CPUUtilization, FreeStorageSpace, DatabaseConnections |
| **Lambda** | Invocations, Duration, Errors, Throttles |
| **S3** | BucketSizeBytes, NumberOfObjects |

---

## 🔧 CloudWatch Agent

> **Memory Hook**: "**Agent** = **Custom collector** — gets memory, disk, and app metrics"

### Why Use CloudWatch Agent?

```
WITHOUT AGENT                    WITH AGENT
──────────────                   ──────────

┌─────────────┐                  ┌─────────────┐
│     EC2     │                  │     EC2     │
│             │                  │ ┌─────────┐ │
│  CPU ✅     │                  │ │  Agent  │ │
│  Network ✅ │                  │ └────┬────┘ │
│  Disk I/O ✅│                  │      │      │
│             │                  │  CPU ✅     │
│  Memory ❌  │                  │  Network ✅ │
│  Disk % ❌  │                  │  Disk I/O ✅│
│  App logs ❌│                  │  Memory ✅  │  ← NEW!
│             │                  │  Disk % ✅  │  ← NEW!
└─────────────┘                  │  App logs ✅│  ← NEW!
                                 └─────────────┘
```

### What CloudWatch Agent Collects

| Metric Type | Examples | Default? |
|-------------|----------|----------|
| **Memory** | MemoryUtilization, MemoryUsed | ❌ Agent required |
| **Disk Space** | DiskSpaceUtilization, DiskUsed | ❌ Agent required |
| **Custom Logs** | Application logs, error logs | ❌ Agent required |
| **StatsD** | Application metrics | ❌ Agent required |

### Agent Installation

```
INSTALLATION FLOW

    1. Download Agent        2. Configure JSON       3. Start Agent
       ─────────────           ──────────────          ────────────
    
    ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
    │  SSM or     │  ───►   │  Specify    │  ───►   │  Agent      │
    │  Manual     │         │  metrics to │         │  sends to   │
    │  Download   │         │  collect    │         │  CloudWatch │
    └─────────────┘         └─────────────┘         └─────────────┘
```

> [!IMPORTANT]
> **Memory is NOT a default metric!** This is a common exam question. You need the CloudWatch Agent to collect memory/RAM usage.

---

## 🔔 CloudWatch Alarms

> **Memory Hook**: "**Alarm** = **If-Then action** — when X happens, do Y"

### Alarm States

```
ALARM STATES

    ┌────────────────┐
    │      OK        │ ← Metric is within threshold
    └───────┬────────┘
            │ Metric crosses threshold
            ▼
    ┌────────────────┐
    │     ALARM      │ ← Threshold breached! Actions triggered!
    └───────┬────────┘
            │  OR
            ▼
    ┌────────────────┐
    │INSUFFICIENT_DATA│ ← Not enough data to evaluate
    └────────────────┘
```

### Alarm Actions

| Action | What Happens | Use Case |
|--------|--------------|----------|
| **SNS Notification** | Send email/SMS | Alert admins |
| **Auto Scaling** | Add/remove instances | Handle load |
| **EC2 Action** | Stop, terminate, reboot | Cost savings |

### Alarm Example

```
ALARM: HIGH CPU → AUTO SCALE

    CloudWatch Metric: CPUUtilization
              │
              ▼
    ┌─────────────────────┐
    │   Is CPU > 80%?     │
    └─────────┬───────────┘
              │
         ┌────┴────┐
        YES       NO
         │         │
         ▼         ▼
    ┌─────────┐  ┌─────────┐
    │ ALARM!  │  │   OK    │
    └────┬────┘  └─────────┘
         │
         ├──────► SNS: "Email admin"
         │
         └──────► Auto Scaling: "Add 2 instances"
```

---

### How Alarm Evaluation Works

```
ALARM EVALUATION PROCESS

    1. Metric data comes in (every 1 minute by default)
       │
       ▼
    2. CloudWatch aggregates over "Period" (e.g., 5 minutes)
       │
       ▼
    3. Compares aggregated value to threshold
       │
       ▼
    4. Counts consecutive breaches ("Evaluation Periods")
       │
       ▼
    5. If breaches >= required → State changes to ALARM
       │
       ▼
    6. Actions trigger (SNS, Auto Scaling, EC2)
```

**Example Configuration:**
```
Threshold: CPU > 80%
Period: 5 minutes
Evaluation Periods: 3 (consecutive)

Timeline:
─────────────────────────────────────────────────────────
Min 0-5:   CPU = 85%  → Breach #1 ⚠️
Min 5-10:  CPU = 90%  → Breach #2 ⚠️
Min 10-15: CPU = 82%  → Breach #3 ⚠️ → ALARM! 🔔
─────────────────────────────────────────────────────────

Why 3 periods? To avoid false alarms from temporary spikes!
```

---

### Why Evaluation Periods Matter

| Setting | Behavior | Trade-off |
|---------|----------|-----------|
| **1 period** | Alarm triggers immediately | May false-alarm on spikes |
| **3 periods** | Waits for sustained issue | Slower response, fewer false alarms |
| **5+ periods** | Very conservative | May miss real issues |

> **Best Practice**: Use 2-3 evaluation periods for production to balance speed and accuracy.

---

## 📝 CloudWatch Logs

> **Memory Hook**: "**Logs** = **Text records** — what happened inside your apps"

### Log Hierarchy

```
CLOUDWATCH LOGS STRUCTURE

    ┌─────────────────────────────────────────────────────────────┐
    │                    CLOUDWATCH LOGS                          │
    │                                                             │
    │   ┌──────────────────────────────────────────────────┐     │
    │   │              LOG GROUP                            │     │
    │   │         (e.g., /aws/lambda/my-function)          │     │
    │   │                                                   │     │
    │   │   ┌───────────────────────────────────────────┐  │     │
    │   │   │          LOG STREAM #1                     │  │     │
    │   │   │    (Instance: i-abc123, Feb 9 2025)       │  │     │
    │   │   │                                            │  │     │
    │   │   │   [2025-02-09 10:00:01] INFO: Started      │  │     │
    │   │   │   [2025-02-09 10:00:02] ERROR: Failed DB   │  │     │
    │   │   │   [2025-02-09 10:00:03] INFO: Retrying...  │  │     │
    │   │   └───────────────────────────────────────────┘  │     │
    │   │                                                   │     │
    │   │   ┌───────────────────────────────────────────┐  │     │
    │   │   │          LOG STREAM #2                     │  │     │
    │   │   │    (Instance: i-xyz789, Feb 9 2025)       │  │     │
    │   │   └───────────────────────────────────────────┘  │     │
    │   └──────────────────────────────────────────────────┘     │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
```

### Log Sources

| Source | What Logs |
|--------|-----------|
| **EC2** | System logs, application logs (via Agent) |
| **Lambda** | Function output, errors |
| **API Gateway** | Request/response logs |
| **RDS** | Query logs, error logs |
| **CloudTrail** | API audit logs |

### CloudWatch Logs Insights

Query and analyze logs with SQL-like syntax:

```sql
-- Find errors in the last hour
fields @timestamp, @message
| filter @message like /ERROR/
| sort @timestamp desc
| limit 20
```

---

## ⚡ Amazon EventBridge (CloudWatch Events)

> **Memory Hook**: "**EventBridge** = **Event Router** — when something happens, trigger something else"

```
EVENTBRIDGE PATTERN

    ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
    │   EVENT     │         │ EVENTBRIDGE │         │   TARGET    │
    │   SOURCE    │ ──────► │    (Rules)  │ ──────► │   ACTION    │
    └─────────────┘         └─────────────┘         └─────────────┘

    Examples:
    ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
    │EC2 Stopped  │ ───────►│ "If EC2 stop│ ───────►│ SNS: Email  │
    └─────────────┘         │  send alert"│         │ admin       │
                            └─────────────┘         └─────────────┘

    ┌─────────────┐         ┌─────────────┐         ┌─────────────┐
    │Every 5 min  │ ───────►│ Schedule    │ ───────►│Lambda: Run  │
    │(cron)       │         │ rule        │         │cleanup      │
    └─────────────┘         └─────────────┘         └─────────────┘
```

### EventBridge Use Cases

| Event Type | Example | Target |
|------------|---------|--------|
| **AWS Events** | EC2 state change | SNS, Lambda |
| **Schedule** | Every 5 minutes (cron) | Lambda |
| **Custom Events** | Order placed in app | Step Functions |

---

## 📈 CloudWatch Dashboards

> **Memory Hook**: "**Dashboard** = **Single pane of glass** — see everything at once"

```
DASHBOARD EXAMPLE

    ┌─────────────────────────────────────────────────────────────────┐
    │                    MY APPLICATION DASHBOARD                      │
    ├────────────────────┬────────────────────┬────────────────────────┤
    │   EC2 CPU (%)      │   RDS Connections  │   Lambda Errors        │
    │                    │                    │                        │
    │   ╭────────╮       │        150 ▓▓▓▓▓   │   Errors: 3            │
    │  ╱          ╲      │        100 ▓▓▓     │   Throttles: 0         │
    │ ────────────────   │         50 ▓       │   Invocations: 1.2K    │
    │     45% avg        │                    │                        │
    ├────────────────────┴────────────────────┴────────────────────────┤
    │                         ALARMS                                   │
    │   🟢 CPU OK    🟢 Memory OK    🔴 Disk 95%    🟡 Pending...      │
    └─────────────────────────────────────────────────────────────────┘
```

### Dashboard Features

- **Widgets**: Graphs, numbers, text, alarms
- **Cross-Account**: View metrics from multiple accounts
- **Cross-Region**: View metrics from multiple regions
- **Free**: No additional charge for dashboards

---

## 🔄 CloudWatch vs CloudTrail

| Aspect | CloudWatch | CloudTrail |
|--------|------------|------------|
| **Purpose** | Performance & Health | Audit & Compliance |
| **Data Type** | Metrics (numbers) | API Calls (who/what/when) |
| **Question** | "Is my server slow?" | "Who deleted my bucket?" |
| **Focus** | **What's happening now** | **What happened before** |
| **Example** | CPU 85%, 500 errors | User X called DeleteBucket |

> [!TIP]
> **Exam Tip**: "Metrics/Performance" → CloudWatch. "Audit/Who did what" → CloudTrail.

---

## CloudWatch Integrations

```
CLOUDWATCH INTEGRATION MAP

                         ┌───────────────────┐
                         │    CLOUDWATCH     │
                         │                   │
                         │  Metrics + Alarms │
                         └─────────┬─────────┘
                                   │
        ┌──────────────────────────┼──────────────────────────┐
        │                          │                          │
        ▼                          ▼                          ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│  AUTO SCALING │         │     SNS       │         │    LAMBDA     │
│               │         │               │         │               │
│ Scale EC2 on  │         │ Email alerts  │         │ Trigger on    │
│ CPU alarm     │         │ when alarm    │         │ log pattern   │
└───────────────┘         └───────────────┘         └───────────────┘
```

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "Memory (RAM) is a default EC2 metric" | **NO!** Memory requires CloudWatch Agent. CPU is default, memory is NOT. | ⚠️ Yes (very common!) |
| "CloudWatch shows who deleted my S3 bucket" | **NO!** That's CloudTrail (audit). CloudWatch is for metrics/performance. | ⚠️ Yes |
| "CloudWatch Logs = CloudWatch Metrics" | **NO!** Logs = text records. Metrics = numerical data points. Different! | ⚠️ Yes |
| "Alarms trigger immediately when threshold is crossed" | **NO!** Depends on evaluation periods. May need 2-3 consecutive breaches. | ⚠️ Yes |
| "EventBridge is separate from CloudWatch" | **Partially true.** EventBridge evolved from CloudWatch Events, now its own service but integrated. | ⚠️ Sometimes |

---

## 🎯 Decision Scenarios

**Scenario 1: Alert when server is overwhelmed**
> "We need an email when EC2 CPU stays above 80% for more than 10 minutes."

**Answer:** CloudWatch Alarm + SNS
**Why:** Create an alarm on CPUUtilization metric with threshold 80%, period 5 min, 2 evaluation periods. Attach SNS action for email.

---

**Scenario 2: Automatically scale when traffic spikes**
> "Add more servers when request count is high, remove when low."

**Answer:** CloudWatch Alarms + Auto Scaling
**Why:** Create scale-out alarm (requests > threshold) and scale-in alarm (requests < threshold). Attach to Auto Scaling Group policies.

---

**Scenario 3: Find errors across all Lambda functions**
> "Our app has 20 Lambda functions. We need to search for ERROR messages across all of them."

**Answer:** CloudWatch Logs + Logs Insights
**Why:** All Lambda logs go to CloudWatch Logs automatically. Use Logs Insights to query across log groups with SQL-like syntax.

---

**Scenario 4: Run cleanup job every night at 2 AM**
> "We need to trigger a Lambda function at 2 AM daily to clean up old data."

**Answer:** Amazon EventBridge (scheduled rule)
**Why:** EventBridge supports cron expressions. Create a rule with `cron(0 2 * * ? *)` targeting your Lambda function.

---

**Scenario 5: Track memory usage on EC2**
> "We need to monitor RAM usage on our EC2 instances."

**Answer:** Install CloudWatch Agent
**Why:** Memory is NOT a default metric. The Agent collects memory, disk space %, and custom logs from inside the instance.

---

## Common Exam Questions

**Q1**: A company wants to be notified when EC2 CPU utilization exceeds 80%. Which service should they use?
> **CloudWatch Alarms with SNS** - Create an alarm on CPUUtilization metric that sends to an SNS topic for email notification.

**Q2**: How can a company automatically add EC2 instances when traffic increases?
> **CloudWatch Alarms + Auto Scaling** - Create an alarm that triggers an Auto Scaling policy when metrics like CPU or request count exceed thresholds.

**Q3**: Which CloudWatch component should be used to centralize and search application log files?
> **CloudWatch Logs** - Stores, monitors, and allows searching/filtering of log data from applications and AWS services.

**Q4**: A company wants to trigger a Lambda function every 5 minutes to perform cleanup tasks. Which service should they use?
> **Amazon EventBridge (CloudWatch Events)** - Use a scheduled rule (cron expression) to trigger Lambda on a schedule.

**Q5**: Is EC2 memory (RAM) usage a default CloudWatch metric?
> **No!** Memory is a custom metric. You need to install the CloudWatch Agent on EC2 to collect memory usage.

**Q6**: Which service shows "who did what" for API calls - CloudWatch or CloudTrail?
> **CloudTrail** - Logs all API calls for auditing. CloudWatch is for metrics/performance, not API auditing.

**Q7**: What is the difference between CloudWatch Logs and CloudWatch Metrics?
> **Logs** = Text records (error messages, application output). **Metrics** = Numerical data points (CPU %, request count).

---

## Summary

| Component | Memory Hook | Purpose |
|-----------|-------------|---------|
| **Metrics** | "Numbers over time" | Track CPU, Network, Disk |
| **Alarms** | "If-Then actions" | Trigger SNS, Auto Scaling |
| **Logs** | "Text records" | Store and search log files |
| **EventBridge** | "Event router" | React to changes, schedule tasks |
| **Dashboards** | "Single pane of glass" | Visualize everything |
| **Memory ≠ Default** | Must use Agent | RAM is NOT auto-collected! |

---

## 🔗 Related Topics

- [CloudTrail](cloudtrail.md) - API auditing (who did what)
- [Auto Scaling](auto-scaling.md) - Scales based on CloudWatch alarms
- [SNS](sns.md) - Receives alarm notifications
- [Lambda](lambda.md) - Logs go to CloudWatch Logs
