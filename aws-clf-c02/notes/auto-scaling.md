# AWS Auto Scaling

> "The rubber band of cloud computing — stretches with demand, snaps back to save costs."

## What Auto Scaling Does

```
✅ Automatically adds EC2 instances when demand increases
✅ Removes instances when demand decreases (cost savings)
✅ Maintains application availability and performance
✅ Replaces unhealthy instances automatically
```

---

## Vertical vs Horizontal Scaling

```
VERTICAL SCALING (Scale UP/DOWN)
"Make the server bigger"

Before:           After:
┌─────────┐       ┌─────────────────┐
│  EC2    │  ──►  │      EC2        │
│ t3.small│       │   t3.2xlarge    │
│ 2 vCPU  │       │    8 vCPU       │
│ 2GB RAM │       │   32GB RAM      │
└─────────┘       └─────────────────┘
    ⚠️ Downtime required to resize


HORIZONTAL SCALING (Scale OUT/IN)
"Add more servers"

Before:           After:
┌─────────┐       ┌─────────┐ ┌─────────┐ ┌─────────┐
│  EC2    │  ──►  │  EC2    │ │  EC2    │ │  EC2    │
└─────────┘       └─────────┘ └─────────┘ └─────────┘
    ✅ No downtime, just add/remove instances
```

| Aspect | Vertical (Scale Up) | Horizontal (Scale Out) |
|--------|---------------------|------------------------|
| **How** | Bigger instance | More instances |
| **Downtime** | ⚠️ Yes (stop & resize) | ✅ No |
| **Limit** | Hardware max exists | Virtually unlimited |
| **Cost** | Expensive at top tier | Cost-effective |
| **Complexity** | Simple | Requires load balancer |
| **AWS Service** | Manual EC2 resize | **Auto Scaling** |

> **Memory Hook**: Vertical = "Pumping iron" 💪 | Horizontal = "Hiring more workers" 👥

> [!TIP]
> AWS recommends **horizontal scaling** for high availability and fault tolerance. Auto Scaling + ELB = horizontal scaling!

---

## How Auto Scaling Works

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         AUTO SCALING ARCHITECTURE                            │
│                                                                              │
│   ┌──────────────────┐      ┌──────────────────┐      ┌──────────────────┐  │
│   │   CloudWatch     │      │  Auto Scaling    │      │  Launch          │  │
│   │   Metrics        │─────►│  Group (ASG)     │◄─────│  Template        │  │
│   │                  │      │                  │      │                  │  │
│   │  • CPU > 80%     │      │  Min: 2          │      │  • AMI           │  │
│   │  • Memory        │      │  Desired: 4      │      │  • Instance type │  │
│   │  • Request count │      │  Max: 10         │      │  • Security group│  │
│   └──────────────────┘      └────────┬─────────┘      └──────────────────┘  │
│                                      │                                       │
│                                      ▼                                       │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │                     EC2 INSTANCES (Multi-AZ)                          │  │
│   │                                                                       │  │
│   │   AZ-a              AZ-b              AZ-c                           │  │
│   │   ┌─────┐           ┌─────┐           ┌─────┐                        │  │
│   │   │ EC2 │           │ EC2 │           │ EC2 │  ← Healthy             │  │
│   │   └─────┘           └─────┘           └─────┘                        │  │
│   │   ┌─────┐           ┌─────┐                                          │  │
│   │   │ EC2 │           │ EC2 │           [New EC2] ← Scale OUT          │  │
│   │   └─────┘           └─────┘                                          │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Key Components

```
AUTO SCALING COMPONENTS
├── 📋 LAUNCH TEMPLATE (What to launch)
│   ├── AMI ID (OS + software)
│   ├── Instance type (t3.medium, etc.)
│   ├── Key pair (SSH access)
│   ├── Security groups
│   └── User data (startup scripts)
│
├── 🎯 AUTO SCALING GROUP (How many to run)
│   ├── Minimum capacity (never go below)
│   ├── Maximum capacity (never exceed)
│   ├── Desired capacity (target count)
│   └── Availability Zones (multi-AZ)
│
└── 📊 SCALING POLICIES (When to scale)
    ├── Target Tracking (maintain metric)
    ├── Step Scaling (incremental changes)
    ├── Simple Scaling (basic +/-)
    └── Scheduled Scaling (time-based)
```

---

## Capacity Settings

```
CAPACITY SETTINGS VISUALIZATION

                     [Maximum: 10]  ── Never exceed this
                          ▲
                          │
    ┌─────────────────────┼─────────────────────┐
    │                     │                     │
    │  [Desired: 4] ◄─────┼─────► Auto adjusts  │
    │       │             │         based on    │
    │       ▼             │         policies    │
    │  Currently running  │                     │
    └─────────────────────┼─────────────────────┘
                          │
                          ▼
                    [Minimum: 2]  ── Never go below this


EXAMPLE:
  Min = 2   → Always have at least 2 instances (high availability)
  Max = 10  → Cost protection, never exceed 10
  Desired = 4 → Start with 4, adjust based on demand
```

---

## Types of Scaling

| Type | Trigger | How It Works | Use Case |
|------|---------|--------------|----------|
| **Dynamic** | CloudWatch metrics | Reacts to real-time demand | Unpredictable traffic |
| **Predictive** | Historical patterns | ML forecasts and pre-scales | Daily/weekly patterns |
| **Scheduled** | Date/time | Pre-defined schedule | Known events, business hours |
| **Manual** | Admin action | Direct capacity change | Maintenance, testing |

### Visual Comparison

```
DYNAMIC SCALING (Reactive)
Traffic ████████████░░░░  → CPU > 80% → Add 2 instances
Traffic ██████░░░░░░░░░░  → CPU < 30% → Remove 1 instance

PREDICTIVE SCALING (Proactive)
Historical: Peak at 9 AM
Today 8:30 AM → Pre-launch 3 instances → Ready for 9 AM spike

SCHEDULED SCALING (Time-based)
Mon-Fri 9 AM  → Min: 4, Desired: 6
Mon-Fri 6 PM  → Min: 2, Desired: 2
Weekends      → Min: 1, Desired: 1
```

---

## Dynamic Scaling Policies (EXAM CRITICAL!)

| Policy | How It Works | Example | Best For |
|--------|--------------|---------|----------|
| **Target Tracking** | Maintain metric at target value | Keep CPU at 50% | Simple, automatic |
| **Step Scaling** | Different actions for different thresholds | +1 if CPU 60%, +3 if CPU 80% | Granular control |
| **Simple Scaling** | Single adjustment after alarm | Add 1 instance when CPU > 70% | Basic scenarios |

### Target Tracking (Most Common)

```
TARGET TRACKING EXAMPLE

    Target: CPU at 50%
    
    Current CPU: 75%  → Too high! → Scale OUT (add instances)
    ────────────────────────────────────────────►
    [EC2][EC2] → [EC2][EC2][EC2][EC2]
    
    Current CPU: 25%  → Too low! → Scale IN (remove instances)
    ◄────────────────────────────────────────────
    [EC2][EC2][EC2][EC2] → [EC2][EC2]
```

### Step Scaling

```
STEP SCALING THRESHOLDS

    CPU 0-40%   → Scale IN:  Remove 2 instances
    CPU 40-70%  → No action (optimal range)
    CPU 70-85%  → Scale OUT: Add 1 instance
    CPU 85-100% → Scale OUT: Add 3 instances
    
    ┌─────────────────────────────────────────────┐
    │  40%        70%        85%       100%       │
    │   │          │          │          │        │
    │ ◄─┼─ OK ─────┼──────────┼──────────┼─►      │
    │ -2│          │    +1    │    +3    │        │
    └───┴──────────┴──────────┴──────────┴────────┘
```

---

## Integration with ELB

```
COMPLETE HIGH AVAILABILITY ARCHITECTURE

                         Internet
                            │
                            ▼
                  ┌─────────────────┐
                  │  Load Balancer  │
                  │  (ALB or NLB)   │
                  └────────┬────────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
         ▼                 ▼                 ▼
    ┌─────────┐       ┌─────────┐       ┌─────────┐
    │  EC2    │       │  EC2    │       │  EC2    │
    │  AZ-a   │       │  AZ-b   │       │  AZ-c   │
    └─────────┘       └─────────┘       └─────────┘
         │                 │                 │
         └─────────────────┴─────────────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │   Auto Scaling Group    │
              │   (Manages all EC2s)    │
              └─────────────────────────┘

HOW THEY WORK TOGETHER:
1. ELB distributes traffic across healthy instances
2. ELB health checks detect unhealthy instances
3. Auto Scaling replaces unhealthy instances
4. Auto Scaling adds/removes instances based on demand
5. ELB automatically includes new instances
```

---

## Scaling Actions

```
SCALE OUT (Add Instances)
Trigger: High demand, metric threshold breached
┌───┐ ┌───┐           ┌───┐ ┌───┐ ┌───┐ ┌───┐
│EC2│ │EC2│    ───►   │EC2│ │EC2│ │EC2│ │EC2│
└───┘ └───┘           └───┘ └───┘ └───┘ └───┘
   2 instances             4 instances

SCALE IN (Remove Instances)
Trigger: Low demand, save costs
┌───┐ ┌───┐ ┌───┐ ┌───┐           ┌───┐ ┌───┐
│EC2│ │EC2│ │EC2│ │EC2│    ───►   │EC2│ │EC2│
└───┘ └───┘ └───┘ └───┘           └───┘ └───┘
      4 instances                  2 instances
```

---

## Lifecycle Hooks

```
INSTANCE LIFECYCLE WITH HOOKS

    ┌─────────┐     ┌─────────────┐     ┌─────────┐
    │ Pending │────►│ Pending:Wait│────►│InService│
    └─────────┘     └─────────────┘     └─────────┘
                          │
                          ▼
                    Run custom actions:
                    • Install software
                    • Register with monitoring
                    • Pull configuration
    
    ┌─────────────┐     ┌────────────────┐     ┌────────────┐
    │ Terminating │────►│Terminating:Wait│────►│ Terminated │
    └─────────────┘     └────────────────┘     └────────────┘
                              │
                              ▼
                        Run custom actions:
                        • Backup logs
                        • Deregister from DNS
                        • Clean up resources
```

---

## Health Checks

| Check Type | Source | What It Checks |
|------------|--------|----------------|
| **EC2** | AWS | Instance status (running, stopped) |
| **ELB** | Load Balancer | Application health via HTTP endpoint |
| **Custom** | External | Your defined health criteria |

```
HEALTH CHECK FLOW

    Auto Scaling Group monitors health
              │
              ▼
    ┌─────────────────────────────┐
    │ Is instance healthy?        │
    │                             │
    │ EC2 Check: Running? ✅      │
    │ ELB Check: HTTP 200? ✅     │
    └─────────────────────────────┘
              │
         YES  │  NO
              ▼   ▼
    [Keep]    [Terminate & Replace]
```

---

## Common Exam/Interview Questions

**Q1**: What is the primary benefit of using Auto Scaling with an Application Load Balancer?
> **High availability and fault tolerance** - Auto Scaling maintains the desired number of healthy instances, while ALB distributes traffic and performs health checks

**Q2**: Which scaling policy should you use to maintain average CPU utilization at 50%?
> **Target Tracking Scaling Policy** - It automatically adjusts capacity to maintain the target metric value without manual threshold configuration

**Q3**: A company has a predictable traffic spike every day at 9 AM. Which scaling type is most appropriate?
> **Scheduled Scaling** (or Predictive Scaling) - For known patterns, pre-schedule capacity increases before the spike

**Q4**: What happens when an instance fails the health check in an Auto Scaling group?
> **Auto Scaling terminates the unhealthy instance and launches a replacement** - This maintains the desired capacity and application availability

**Q5**: What's the difference between desired capacity and minimum capacity?
> **Minimum** = floor (never go below), **Desired** = target count. Auto Scaling adjusts desired capacity based on policies but never below minimum or above maximum

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **Auto Scaling** | "Rubber band capacity — stretches and shrinks" |
| **Launch Template** | "Blueprint for new instances" |
| **Auto Scaling Group** | "The boss that manages min/max/desired" |
| **Target Tracking** | "Thermostat — maintain at target" |
| **Step Scaling** | "Staircase — bigger steps for bigger problems" |
| **Scale OUT** | "More instances when busy" |
| **Scale IN** | "Fewer instances when quiet" |
| **Min capacity** | "Safety net — never below this" |
| **Max capacity** | "Budget cap — never above this" |
| **ELB + ASG** | "Dream team for high availability" |

---

## 🏢 Practical Example: Odoo ERP Auto Scaling

> Real-world architecture for scaling an Odoo server on AWS

### Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        ODOO AUTO SCALING ARCHITECTURE                            │
│                                                                                  │
│    Users (Vietnam, Singapore, etc.)                                              │
│              │                                                                   │
│              ▼                                                                   │
│    ┌─────────────────┐                                                          │
│    │   Route 53      │  ← DNS: odoo.yourcompany.com                             │
│    └────────┬────────┘                                                          │
│             │                                                                    │
│             ▼                                                                    │
│    ┌─────────────────┐                                                          │
│    │  CloudFront     │  ← CDN: Cache static assets (CSS, JS, images)            │
│    └────────┬────────┘                                                          │
│             │                                                                    │
│             ▼                                                                    │
│    ┌─────────────────┐         ┌─────────────────┐                              │
│    │       ALB       │────────►│   WAF           │  ← Security rules            │
│    │  (Application   │         └─────────────────┘                              │
│    │  Load Balancer) │                                                          │
│    └────────┬────────┘                                                          │
│             │                                                                    │
│    ┌────────┴────────────────────────────────────┐                              │
│    │           AUTO SCALING GROUP                 │                              │
│    │  ┌─────────────────────────────────────────┐ │                              │
│    │  │  AZ-a           AZ-b           AZ-c     │ │                              │
│    │  │  ┌─────────┐   ┌─────────┐   ┌───────┐  │ │                              │
│    │  │  │ Odoo EC2│   │ Odoo EC2│   │Odoo   │  │ │                              │
│    │  │  │ t3.large│   │ t3.large│   │t3.lrg │  │ │                              │
│    │  │  └────┬────┘   └────┬────┘   └───┬───┘  │ │                              │
│    │  └───────┼─────────────┼────────────┼──────┘ │                              │
│    └──────────┼─────────────┼────────────┼────────┘                              │
│               │             │            │                                       │
│    ┌──────────┴─────────────┴────────────┴──────────┐                           │
│    │              SHARED RESOURCES                   │                           │
│    │                                                 │                           │
│    │  ┌───────────────┐    ┌───────────────┐        │                           │
│    │  │   Amazon EFS  │    │  ElastiCache  │        │                           │
│    │  │  (Filestore)  │    │  (Sessions)   │        │                           │
│    │  │  /var/lib/    │    │   Redis       │        │                           │
│    │  │  odoo/files   │    └───────────────┘        │                           │
│    │  └───────────────┘                              │                           │
│    │                                                 │                           │
│    │  ┌─────────────────────────────────────┐       │                           │
│    │  │          Amazon RDS                  │       │                           │
│    │  │     PostgreSQL (Multi-AZ)           │       │                           │
│    │  │   db.r5.large (Primary + Standby)   │       │                           │
│    │  └─────────────────────────────────────┘       │                           │
│    └─────────────────────────────────────────────────┘                           │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Component Breakdown

| Component | AWS Service | Purpose | Config |
|-----------|-------------|---------|--------|
| **DNS** | Route 53 | Domain management | odoo.company.com |
| **CDN** | CloudFront | Cache static files | TTL: 1 day |
| **Load Balancer** | ALB | Distribute traffic | Sticky sessions enabled |
| **Web/App Servers** | EC2 (ASG) | Run Odoo workers | t3.large, 2-6 instances |
| **File Storage** | EFS | Shared attachments | /var/lib/odoo/filestore |
| **Sessions** | ElastiCache Redis | Session storage | cache.t3.medium |
| **Database** | RDS PostgreSQL | Odoo database | db.r5.large, Multi-AZ |

### Launch Template Configuration

```bash
# User Data Script for Odoo EC2
#!/bin/bash
# Mount EFS for shared filestore
mkdir -p /var/lib/odoo/filestore
mount -t efs fs-12345678:/ /var/lib/odoo/filestore

# Configure Redis for sessions (odoo.conf)
cat >> /etc/odoo/odoo.conf << EOF
[options]
db_host = odoo-db.xxx.rds.amazonaws.com
db_port = 5432
db_user = odoo
db_password = ${DB_PASSWORD}

# Worker configuration for horizontal scaling
workers = 4
max_cron_threads = 1

# Redis session store
session_store = redis
redis_host = odoo-redis.xxx.cache.amazonaws.com
redis_port = 6379
EOF

# Start Odoo
systemctl restart odoo
```

### Auto Scaling Configuration

```
ODOO AUTO SCALING GROUP

Launch Template:
├── AMI: Custom Odoo 17 on Ubuntu 22.04
├── Instance Type: t3.large (2 vCPU, 8GB RAM)
├── Security Group: sg-odoo-web
├── Key Pair: odoo-prod-key
└── User Data: (script above)

Capacity:
├── Minimum: 2  (High availability)
├── Desired: 3  (Normal load)
└── Maximum: 6  (Peak handling)

Scaling Policies:
├── Target Tracking: CPU at 60%
├── Scale Out: +1 instance if CPU > 70% for 2 min
└── Scale In: -1 instance if CPU < 30% for 10 min
```

### Sticky Sessions (CRITICAL for Odoo!)

```
ALB TARGET GROUP SETTINGS

┌─────────────────────────────────────────────────────┐
│  Stickiness: ENABLED                                │
│  Type: Application-based cookie                     │
│  Cookie name: AWSALB                                │
│  Duration: 1 hour                                   │
│                                                     │
│  WHY? Odoo uses long-polling for real-time         │
│  features (chat, notifications). User must stay    │
│  connected to same instance during session.        │
└─────────────────────────────────────────────────────┘

ALTERNATIVE: Redis Session Store
├── Store sessions in ElastiCache Redis
├── Any instance can serve any request
└── Better for scaling (no sticky needed)
```

### Health Check Configuration

```
ALB HEALTH CHECK

Path:           /web/health        (Odoo health endpoint)
Protocol:       HTTP
Port:           8069
Healthy:        2 consecutive 200 responses
Unhealthy:      3 consecutive failures
Interval:       30 seconds
Timeout:        5 seconds
```

### Scaling Triggers

| Metric | Threshold | Action | Cooldown |
|--------|-----------|--------|----------|
| **CPU > 70%** | 2 min | Add 1 instance | 300s |
| **CPU > 85%** | 1 min | Add 2 instances | 300s |
| **CPU < 30%** | 10 min | Remove 1 instance | 600s |
| **Request count > 1000/min** | 3 min | Add 1 instance | 300s |

### Cost Estimate (Production)

| Resource | Spec | Monthly Cost (USD) |
|----------|------|-------------------|
| EC2 (3x t3.large) | 3 instances avg | ~$180 |
| RDS PostgreSQL | db.r5.large Multi-AZ | ~$350 |
| EFS | 100 GB | ~$30 |
| ElastiCache Redis | cache.t3.medium | ~$50 |
| ALB | + data transfer | ~$30 |
| **Total** | | **~$640/month** |

> [!TIP]
> Use **Reserved Instances** for RDS and minimum EC2 capacity (2 instances) to save up to 40%!

### Key Considerations for Odoo

| Challenge | Solution |
|-----------|----------|
| **Shared filestore** | Use EFS mounted on all instances |
| **Session management** | Redis (ElastiCache) or ALB sticky sessions |
| **Database bottleneck** | RDS with read replicas for heavy reads |
| **Long-polling (Gevent)** | Separate worker for longpolling on port 8072 |
| **Cron jobs** | Only 1 instance runs cron (`max_cron_threads = 1` on others) |

---

## 🔗 Related Topics

- [EC2 Fundamentals](ec2.md) - The instances that Auto Scaling manages
- [Elastic Load Balancing](elb.md) - Distributes traffic to Auto Scaling instances
- [CloudWatch](cloudwatch.md) - Provides metrics that trigger scaling
