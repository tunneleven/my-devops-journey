# Elastic Load Balancing (ELB)

> "The traffic cop of the cloud — distributes requests so no single server gets overwhelmed."

## What ELB Does

```
✅ Distributes incoming traffic across multiple targets
✅ Increases availability by spreading load across AZs
✅ Automatically routes around unhealthy instances
✅ Scales automatically to handle traffic changes
```

---

## How ELB Works

```
                            INTERNET
                               │
                               ▼
                    ┌─────────────────────┐
                    │   ELASTIC LOAD      │
                    │     BALANCER        │
                    │                     │
                    │ ┌─────────────────┐ │
                    │ │    Listener     │ │  ← Checks protocol/port
                    │ │   (Port 443)    │ │
                    │ └────────┬────────┘ │
                    │          │          │
                    │ ┌────────▼────────┐ │
                    │ │  Listener Rules │ │  ← Routes based on path/host
                    │ │  /api → TG1     │ │
                    │ │  /web → TG2     │ │
                    │ └────────┬────────┘ │
                    └──────────┼──────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
    ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
    │ Target Group │  │ Target Group │  │ Target Group │
    │   (TG1)      │  │   (TG2)      │  │   (TG3)      │
    │              │  │              │  │              │
    │ ┌────┐┌────┐ │  │ ┌────┐┌────┐ │  │ ┌────┐       │
    │ │EC2 ││EC2 │ │  │ │EC2 ││EC2 │ │  │ │Lambda      │
    │ └────┘└────┘ │  │ └────┘└────┘ │  │ └────┘       │
    └──────────────┘  └──────────────┘  └──────────────┘
```

---

## The 4 Types of Load Balancers

```
ELB TYPES BY OSI LAYER

Layer 7 (Application)    Layer 4 (Transport)    Layer 3/4 (Network)
        │                        │                      │
        ▼                        ▼                      ▼
    ┌───────┐                ┌───────┐              ┌───────┐
    │  ALB  │                │  NLB  │              │  GLB  │
    │       │                │       │              │       │
    │HTTP/S │                │TCP/UDP│              │  IP   │
    │ gRPC  │                │  TLS  │              │Packets│
    └───────┘                └───────┘              └───────┘
        │                        │                      │
   Web apps,              Gaming,                 Firewalls,
   Microservices          IoT, Low latency        IDS/IPS

                    ┌───────┐
                    │  CLB  │  ← LEGACY (Don't use for new apps!)
                    │       │
                    │L4 + L7│
                    └───────┘
```

---

### What is ALB (Application Load Balancer)?

> **Memory Hook**: "ALB = **A**pplication layer = **Smart** routing by URL, headers, host"

**ALB** operates at Layer 7 (HTTP/HTTPS) and makes routing decisions based on request content.

- **Why it exists:** Web apps need to route `/api` to one server, `/images` to another
- **Key features:** Path routing, host routing, Lambda targets, WebSocket, gRPC
- **Limitation:** No static IP, slightly higher latency than NLB

---

### What is NLB (Network Load Balancer)?

> **Memory Hook**: "NLB = **N**etwork layer = **Fastest** raw TCP/UDP"

**NLB** operates at Layer 4 (TCP/UDP) for ultra-low latency and high throughput.

- **Why it exists:** Gaming, IoT, financial apps need microsecond latency
- **Key features:** Static IP/Elastic IP, millions of requests/second, preserves source IP
- **Limitation:** No content-based routing (can't read HTTP headers)

---

### What is GLB (Gateway Load Balancer)?

> **Memory Hook**: "GLB = **G**ateway for security = Traffic **inspection** pipeline"

**GLB** routes traffic through third-party virtual appliances (firewalls, IDS/IPS).

- **Why it exists:** Enterprises need all traffic inspected before reaching apps
- **Key features:** GENEVE protocol encapsulation, transparent to apps
- **Limitation:** Only for security/inspection use cases

---

### What is CLB (Classic Load Balancer)?

> **Memory Hook**: "CLB = **C**lassic = **Legacy** = Avoid for new projects"

**CLB** is the original AWS load balancer — supports both L4 and L7 but with limited features.

- **Why it exists:** Backward compatibility for old applications
- **Key point:** Use ALB or NLB instead for new deployments
- **Limitation:** No path routing, no Lambda, no containers

---

### Comparison Table

| Feature | ALB | NLB | GLB | CLB |
|---------|-----|-----|-----|-----|
| **Layer** | 7 | 4 | 3/4 | 4/7 |
| **Protocols** | HTTP, HTTPS, gRPC | TCP, UDP, TLS | IP | TCP, HTTP |
| **Latency** | Low | Ultra-low (~100μs) | Low | Low |
| **Path routing** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **Host routing** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **Static IP** | ❌ No | ✅ Yes | ✅ Yes | ❌ No |
| **Lambda target** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **WebSocket** | ✅ Yes | ✅ Yes | ❌ No | ❌ No |
| **Use case** | Web apps | Gaming, IoT | Security appliances | Legacy |

---

## 🆕 Recent Updates (2024-2025)

| Feature | ELB Type | What's New | Exam Relevance |
|---------|----------|------------|----------------|
| **Weighted Target Groups** | NLB | Blue/green deployments without multiple NLBs | ⚠️ May appear |
| **Zonal Shift** | ALB | Amazon ARC integration for AZ failover | Low |
| **IPv6 Support** | ALB | Full dual-stack support (May 2024) | Low |
| **LCU Reservation** | ALB/NLB | Pre-reserve capacity for traffic spikes | Low |

> [!TIP]
> For CLF-C02, focus on the 4 ELB types and when to use each. These updates are good-to-know but unlikely to be heavily tested.

---

## 🧭 Which ELB Should I Use?

```
DECISION TREE: CHOOSING THE RIGHT ELB

    START: What's your use case?
              │
              ▼
    Need URL path/host routing?
    (e.g., /api → servers, /images → CDN)
              │
         ┌────┴────┐
         │         │
        YES        NO
         │         │
         ▼         ▼
       ┌───┐   Need ultra-low latency or static IP?
       │ALB│   (e.g., gaming, IoT, financial)
       └───┘         │
                ┌────┴────┐
                │         │
               YES        NO
                │         │
                ▼         ▼
              ┌───┐   Need to route through security appliances?
              │NLB│   (e.g., firewalls, IDS/IPS)
              └───┘         │
                       ┌────┴────┐
                       │         │
                      YES        NO
                       │         │
                       ▼         ▼
                     ┌───┐   HTTP traffic? → ALB
                     │GLB│   TCP/UDP? → NLB
                     └───┘   Legacy app? → CLB (avoid!)
```

---

## 🌐 Application Load Balancer (ALB)

> **Memory Hook**: "**A**pplication = Layer **7** = HTTP intelligence"

### Key Features

```
ALB ROUTING CAPABILITIES

┌─────────────────────────────────────────────────────────────────┐
│                         ALB                                     │
│                                                                 │
│  LISTENER RULES (evaluated by priority):                        │
│                                                                 │
│  Rule 1: IF path = /api/*        → Target Group: API-servers   │
│  Rule 2: IF path = /images/*     → Target Group: CDN-cache     │
│  Rule 3: IF host = admin.site.com → Target Group: Admin-panel  │
│  Rule 4: IF header = mobile      → Target Group: Mobile-app    │
│  Default: Send to → Target Group: Web-servers                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Real-World Example: E-commerce Site

```
                    ┌─────────────────────┐
                    │        ALB          │
                    │  shop.example.com   │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
   /api/*                 /checkout/*            /images/*
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│ API Servers   │    │ Payment       │    │ S3 + Lambda   │
│ (ECS Fargate) │    │ (EC2 + WAF)   │    │ (Image resize)│
└───────────────┘    └───────────────┘    └───────────────┘
```

---

## ⚡ Network Load Balancer (NLB)

> **Memory Hook**: "**N**etwork = Layer **4** = Ultra-fast TCP/UDP"

### Key Features

```
NLB CHARACTERISTICS

    ┌─────────────────────────────────────────────────────┐
    │                       NLB                           │
    │                                                     │
    │  ✅ Static IP address (or Elastic IP)               │
    │  ✅ Millions of requests per second                 │
    │  ✅ Ultra-low latency (~100 microseconds)           │
    │  ✅ Preserves source IP address                     │
    │  ✅ TCP/UDP/TLS protocols                           │
    │  ✅ Zonal isolation                                 │
    │                                                     │
    └─────────────────────────────────────────────────────┘
```

### Real-World Example: Gaming Server

```
                Players (UDP traffic)
                        │
                        ▼
              ┌─────────────────┐
              │       NLB       │
              │  (Static IP)    │  ← Whitelisted by players
              │  52.1.2.3       │
              └────────┬────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
   ┌─────────┐    ┌─────────┐    ┌─────────┐
   │ Game    │    │ Game    │    │ Game    │
   │ Server 1│    │ Server 2│    │ Server 3│
   │ (UDP)   │    │ (UDP)   │    │ (UDP)   │
   └─────────┘    └─────────┘    └─────────┘
   
   Ultra-low latency for real-time gameplay!
```

---

## 🔐 Gateway Load Balancer (GLB)

> **Memory Hook**: "**G**ateway = Security **G**ate for network appliances"

### How GLB Works

```
GLB: SECURITY INSPECTION PIPELINE

    Traffic In          Traffic Out (inspected)
        │                       ▲
        ▼                       │
┌───────────────┐        ┌──────┴──────┐
│     GLB       │───────►│  Your App   │
│               │        │  (EC2, ECS) │
└───────┬───────┘        └─────────────┘
        │
        ▼ (GENEVE tunnel)
┌─────────────────────────────────────────┐
│          SECURITY APPLIANCES            │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ │
│  │ Firewall │ │ IDS/IPS  │ │ Packet   │ │
│  │(Palo Alto│ │(Snort)   │ │Inspector │ │
│  └──────────┘ └──────────┘ └──────────┘ │
└─────────────────────────────────────────┘

All traffic inspected BEFORE reaching your app!
```

---

## 🏚️ Classic Load Balancer (CLB)

> **Memory Hook**: "**C**lassic = **Old** = Don't use for new apps!"

```
CLB: LEGACY LOAD BALANCER

    ⚠️ WARNING: Legacy service!
    
    ├── Limited features (no path routing)
    ├── No Lambda support
    ├── No container support
    ├── One SSL cert per listener
    └── Use ALB or NLB instead!
```

---

## Key Concepts

### Target Groups

```
TARGET GROUP = Collection of targets receiving traffic

┌─────────────────────────────────────────────────────────┐
│                    TARGET GROUP                         │
│                                                         │
│  Target Type: Instance | IP | Lambda                    │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │  Target  │  │  Target  │  │  Target  │              │
│  │(Healthy) │  │(Healthy) │  │(Unhealthy)│ ← No traffic│
│  └──────────┘  └──────────┘  └──────────┘              │
│                                                         │
│  Health Check: GET /health → HTTP 200                   │
│  Interval: 30 seconds                                   │
└─────────────────────────────────────────────────────────┘
```

### Health Checks

```
HEALTH CHECK FLOW

    ELB sends probe every 30 seconds
              │
              ▼
    ┌─────────────────────┐
    │ GET /health HTTP/1.1 │
    └──────────┬──────────┘
               │
         ┌─────┴─────┐
         │           │
         ▼           ▼
   HTTP 200      HTTP 500
   (Healthy)    (Unhealthy)
         │           │
         ▼           ▼
   ✅ Receives    ❌ No traffic
      traffic       until healthy
```

### Cross-Zone Load Balancing

```
WITHOUT Cross-Zone:              WITH Cross-Zone (default):
                                 
AZ-a: 2 instances               AZ-a: 2 instances
  50% traffic ÷ 2 = 25% each      50% traffic ÷ 4 = 12.5% each
                                 
AZ-b: 2 instances               AZ-b: 2 instances  
  50% traffic ÷ 2 = 25% each      50% traffic ÷ 4 = 12.5% each

Uneven if AZ has different      Even distribution across ALL
number of healthy targets!      targets regardless of AZ!
```

### Sticky Sessions

```
STICKY SESSIONS (Session Affinity)

Without Sticky:                  With Sticky:
User → Any server               User → Same server (cookie)

Request 1 → Server A            Request 1 → Server A (set cookie)
Request 2 → Server B            Request 2 → Server A (has cookie)
Request 3 → Server C            Request 3 → Server A (has cookie)
  │                               │
  ▼                               ▼
Shopping cart lost! 😱          Shopping cart preserved! 😊
```

---

## 🏢 Real-World Example: Odoo ERP Deployment

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     ODOO PRODUCTION ARCHITECTURE                         │
│                                                                          │
│   Users                                                                  │
│     │                                                                    │
│     ▼                                                                    │
│ ┌───────────────┐                                                        │
│ │   Route 53    │  odoo.company.com                                      │
│ └───────┬───────┘                                                        │
│         │                                                                │
│         ▼                                                                │
│ ┌───────────────┐                                                        │
│ │     ALB       │  ← SSL termination (ACM certificate)                   │
│ │  Port 443     │  ← Sticky sessions (for long-polling)                  │
│ └───────┬───────┘                                                        │
│         │                                                                │
│         ├─────────────────────────────────────────┐                      │
│         │                                         │                      │
│    Port 8069                                 Port 8072                   │
│    (Web/API)                                (Long-polling)               │
│         │                                         │                      │
│         ▼                                         ▼                      │
│ ┌───────────────────────────────┐    ┌───────────────────────────────┐  │
│ │      Target Group: Web        │    │   Target Group: Longpoll      │  │
│ │  ┌──────┐ ┌──────┐ ┌──────┐   │    │  ┌──────┐ ┌──────┐            │  │
│ │  │Odoo 1│ │Odoo 2│ │Odoo 3│   │    │  │Odoo 1│ │Odoo 2│            │  │
│ │  └──────┘ └──────┘ └──────┘   │    │  └──────┘ └──────┘            │  │
│ └───────────────────────────────┘    └───────────────────────────────┘  │
│                                                                          │
│ Health Check: GET /web/health → HTTP 200                                │
│ Sticky Sessions: Enabled (1 hour duration)                              │
│ Cross-Zone: Enabled                                                      │
│ Auto Scaling: Min 2, Max 6                                              │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🔥 Integration with Auto Scaling

```
ELB + AUTO SCALING = HIGH AVAILABILITY

    ┌─────────────────────────────────────────┐
    │              AUTO SCALING               │
    │                                         │
    │  1. Traffic increases                   │
    │  2. CloudWatch alarm triggers           │
    │  3. Auto Scaling launches new EC2       │
    │  4. EC2 registers with Target Group     │
    │  5. ELB health check passes             │
    │  6. ELB starts sending traffic          │
    │                                         │
    │  If instance fails:                     │
    │  1. Health check fails                  │
    │  2. ELB stops traffic to instance       │
    │  3. Auto Scaling terminates instance    │
    │  4. Auto Scaling launches replacement   │
    │                                         │
    └─────────────────────────────────────────┘
```

---

## ⚠️ Common Mistakes

| Misconception | Reality | Exam Trap? |
|---------------|---------|------------|
| "ALB has a static IP" | **NO!** ALB uses dynamic IPs. Use NLB if you need static IP. | ⚠️ Yes |
| "NLB can route by URL path" | **NO!** NLB is Layer 4 — it sees TCP/UDP, not HTTP content. Only ALB does path routing. | ⚠️ Yes |
| "CLB is good for new applications" | **NO!** CLB is legacy. Always use ALB or NLB for new apps. | ⚠️ Yes |
| "ELB only works with EC2" | **NO!** ALB can target Lambda functions, and all ELBs can target IP addresses. | ⚠️ Yes |
| "GLB is for general load balancing" | **NO!** GLB is specifically for security appliances (firewalls, IDS). Use ALB/NLB otherwise. | ⚠️ Yes |
| "Health checks are optional" | **NO!** Health checks are always active. You can configure them but can't disable entirely. | ⚠️ Sometimes |
| "Sticky sessions store data on ELB" | **NO!** Sticky sessions use cookies to route to same target. Session data is on the target server. | ⚠️ Yes |

---

## 🎯 Decision Scenarios

**Scenario 1: E-commerce with microservices**
> "Our shop has /api for backend, /images for CDN, and /checkout for payment service."

**Answer:** ALB (Application Load Balancer)
**Why:** Need path-based routing to different target groups. Only ALB supports this at Layer 7.

---

**Scenario 2: Mobile game with real-time multiplayer**
> "UDP-based game needs <10ms latency. Firewall requires static IP whitelist."

**Answer:** NLB (Network Load Balancer)
**Why:** UDP support, ultra-low latency (~100μs), and static IP/Elastic IP for whitelisting.

---

**Scenario 3: Enterprise compliance with traffic inspection**
> "All traffic must pass through Palo Alto firewall before reaching our applications."

**Answer:** GLB (Gateway Load Balancer)
**Why:** Routes traffic through security appliances (firewalls, IDS/IPS) transparently.

---

**Scenario 4: Serverless API with Lambda**
> "We want our API Gateway alternative using Lambda functions behind a load balancer."

**Answer:** ALB (with Lambda target)
**Why:** Only ALB can invoke Lambda functions directly. NLB and GLB cannot.

---

**Scenario 5: Migrating from Classic Load Balancer**
> "Our legacy app uses CLB. What should we migrate to?"

**Answer:** ALB (if HTTP/HTTPS) or NLB (if TCP/UDP)
**Why:** CLB is deprecated. ALB for web apps, NLB for non-HTTP protocols.

---

**Scenario 6: Shopping cart keeps losing items**
> "Users add items to cart, but when they refresh, items disappear."

**Answer:** Enable Sticky Sessions on ALB
**Why:** Without sticky sessions, requests go to random servers. Cart data is on one server only.

---

## Common Exam/Interview Questions

**Q1**: A company needs to route traffic based on URL paths (/api vs /web). Which ELB type should they use?
> **ALB (Application Load Balancer)** - Only ALB supports path-based routing at Layer 7

**Q2**: A gaming company needs ultra-low latency for their UDP-based game servers and requires a static IP address. Which ELB type is best?
> **NLB (Network Load Balancer)** - Layer 4, supports UDP, ultra-low latency, static IP

**Q3**: A company wants to inspect all incoming traffic through third-party firewalls before it reaches their application. Which ELB should they use?
> **GLB (Gateway Load Balancer)** - Designed for routing traffic through virtual appliances

**Q4**: What happens when an EC2 instance fails the ELB health check?
> **ELB stops sending traffic to the instance** - Traffic is automatically routed to healthy instances

**Q5**: A shopping cart application loses user data when requests go to different servers. How can this be solved with ELB?
> **Enable sticky sessions** - Binds user to same target for session duration using cookies

**Q6**: Which ELB type can target AWS Lambda functions?
> **ALB only** - NLB, GLB, and CLB cannot invoke Lambda functions

**Q7**: A company is migrating from Classic Load Balancer. Which ELB type should replace it for a web application that uses HTTP/HTTPS?
> **ALB** - Modern replacement for CLB, supports all Layer 7 features plus path/host routing

**Q8**: Which ELB feature allows NLB to perform blue/green deployments by gradually shifting traffic?
> **Weighted Target Groups** - Assign static weights to target groups (e.g., 90% to blue, 10% to green)

**Q9**: A company wants to ensure their ELB can handle a planned traffic spike from a product launch. What should they do?
> **Use LCU Reservation** - Pre-reserves capacity units to handle expected traffic without cold start delays

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **ELB** | "Traffic cop for the cloud" |
| **ALB** | "**A**pplication = Layer 7 = Smart routing" |
| **NLB** | "**N**etwork = Layer 4 = Ultra-fast" |
| **GLB** | "**G**ateway = Security appliances" |
| **CLB** | "**C**lassic = Legacy, don't use" |
| **Target Group** | "Container of targets" |
| **Health Check** | "Is the server alive?" |
| **Sticky Session** | "Keep user on same server" |
| **Cross-Zone** | "Even distribution across AZs" |

---

## 🔗 Related Topics

- [Auto Scaling](auto-scaling.md) - Works with ELB for high availability
- [EC2 Fundamentals](ec2.md) - Common target for ELB
- [VPC Fundamentals](vpc-fundamentals.md) - ELB lives in your VPC
