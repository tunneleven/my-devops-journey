# AWS WAF (Web Application Firewall)

> AWS WAF = Your web app's bouncer at the door, checking every HTTP request for trouble

## What WAF Does

```
✅ Inspects HTTP/HTTPS requests
✅ Blocks SQL injection attacks
✅ Blocks Cross-Site Scripting (XSS)
✅ Rate-limits abusive IPs
✅ Filters by country/region
✅ Blocks malicious bots
```

---

## Where WAF Sits

```
Internet Traffic
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                        AWS WAF                               │
│                  (Layer 7 Inspector)                         │
│                                                              │
│   Checks every request:                                      │
│   ├── Is this SQL injection? → BLOCK                        │
│   ├── Is this XSS attack? → BLOCK                           │
│   ├── Too many requests from this IP? → BLOCK               │
│   └── Looks normal? → ALLOW                                  │
└─────────────────────────────────────────────────────────────┘
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│   Your Application (CloudFront / ALB / API Gateway)         │
└─────────────────────────────────────────────────────────────┘
```

---

## Core Concept: Layer 7

```
OSI Model:
├── Layer 7: Application ← WAF works HERE! (HTTP/HTTPS)
├── Layer 6: Presentation
├── Layer 5: Session
├── Layer 4: Transport  ← Security Groups, NACLs, Shield
├── Layer 3: Network    ← Shield
├── Layer 2: Data Link
└── Layer 1: Physical
```

**Why Layer 7 matters:**
- Can see **what** the request contains (SQL, scripts)
- Not just **where** it's going (IP, port)

---

## What WAF Protects

```
AWS WAF protects LAYER 7 services only:
├── ✅ Amazon CloudFront (CDN)
├── ✅ Application Load Balancer (ALB)
├── ✅ Amazon API Gateway (REST APIs)
├── ✅ AWS AppSync (GraphQL)
├── ✅ Amazon Cognito User Pools
│
├── ❌ EC2 directly (use Security Groups)
├── ❌ Network Load Balancer (Layer 4)
└── ❌ RDS directly (use Security Groups)
```

---

## 🔍 WHY Layer 7 Only?

> WAF reads HTTP requests like a security guard reading mail - it needs to open the envelope!

### The Technical Reason

```
What WAF needs to do its job:
┌─────────────────────────────────────────────────────────────┐
│   HTTP REQUEST (Layer 7 data)                                │
│                                                              │
│   Headers:                                                   │
│   ├── User-Agent: Mozilla/5.0...                            │
│   ├── Cookie: sessionId=abc123                              │
│   └── Content-Type: application/json                        │
│                                                              │
│   Body:                                                      │
│   └── {"query": "SELECT * FROM users WHERE id='1' OR 1=1"} │
│                    ▲                                         │
│                    └── WAF catches this SQL injection!       │
└─────────────────────────────────────────────────────────────┘
```

**WAF inspects the REQUEST CONTENT** - headers, body, query strings, cookies. This data **only exists at Layer 7**.

### What Lower Layers See

```
LAYER 4 (Transport - TCP/UDP)
┌─────────────────────────────────────────────┐
│   Source IP: 192.168.1.100                  │
│   Dest IP: 10.0.0.50                        │
│   Source Port: 54321                        │
│   Dest Port: 443                            │
│   Protocol: TCP                             │
│                                              │
│   Payload: ????????????????????             │
│            (encrypted blob - can't read!)    │
└─────────────────────────────────────────────┘

NLB sees: "Traffic going to port 443"
NLB does NOT see: "This request contains SQL injection"
```

### Analogy: Mail Delivery

```
LAYER 4 = Post Office
├── Sees: "Package going from Address A to Address B"
├── Doesn't open the package
└── Can only block by: sender address, size, destination

LAYER 7 = Security Checkpoint  
├── Opens and reads the letter contents
├── Scans for threats (SQL, XSS, malware)
└── Can block: specific words, patterns, suspicious content
```

### Why Each Service Works (or Doesn't)

| Service | Layer | Why WAF Works/Doesn't |
|---------|-------|----------------------|
| **CloudFront** | 7 | ✅ Terminates HTTPS, reads full HTTP request |
| **ALB** | 7 | ✅ Application-aware, inspects request content |
| **API Gateway** | 7 | ✅ Parses HTTP, understands REST/WebSocket |
| **AppSync** | 7 | ✅ GraphQL processor, sees query content |
| **Cognito Pools** | 7 | ✅ Auth endpoint, handles HTTP requests |
| **NLB** | 4 | ❌ Just routes TCP, never opens the packet |
| **EC2** | 3-4 | ❌ WAF can't sit in front of raw instance |

### What to Use Instead

```
PROTECTION BY LAYER
├── Layer 7 attacks (SQL, XSS, bad bots)
│   └── AWS WAF ← Only for Layer 7 services
│
├── Layer 4 attacks (port scanning, SYN floods)
│   ├── Security Groups ← Block IPs/ports
│   ├── NACLs ← Subnet-level filtering
│   └── AWS Shield ← DDoS protection
│
└── Layer 3 attacks (IP spoofing, volumetric DDoS)
    └── AWS Shield Standard (free, automatic)
```

---

## Key Components

```
WAF STRUCTURE
├── 📋 Web ACL (Access Control List)
│   └── Container for all your rules
│
├── 📜 Rules
│   ├── Match Condition (what to look for)
│   └── Action (what to do when matched)
│
├── 📦 Rule Groups
│   └── Reusable collections of rules
│
└── 🛡️ Managed Rules
    └── Pre-built by AWS or AWS Marketplace
```

---

## How Rules Work

```
INCOMING REQUEST
       │
       ▼
┌─────────────────────────────────────────┐
│              WEB ACL                     │
│                                          │
│ Rule 1: Block if contains SQL injection │
│         ├── Match: "DROP TABLE", "1=1"   │
│         └── Action: BLOCK                │
│                                          │
│ Rule 2: Rate limit (1000 req/5 min)     │
│         ├── Match: Same IP > 1000        │
│         └── Action: BLOCK                │
│                                          │
│ Rule 3: Block specific countries        │
│         ├── Match: Country = X           │
│         └── Action: BLOCK                │
│                                          │
│ Default Action: ALLOW                    │
└─────────────────────────────────────────┘
```

---

## Rule Actions

| Action | What Happens |
|--------|--------------|
| **ALLOW** | Request passes through |
| **BLOCK** | Request rejected (403 error) |
| **COUNT** | Request counted but allowed (for testing) |
| **CAPTCHA** | Show CAPTCHA challenge |
| **Challenge** | Silent browser challenge |

---

## Managed Rules (Time Saver!)

Instead of writing all rules yourself:

```
AWS MANAGED RULES
├── AWSManagedRulesCommonRuleSet
│   └── OWASP Top 10 vulnerabilities
│
├── AWSManagedRulesSQLiRuleSet
│   └── SQL Injection protection
│
├── AWSManagedRulesKnownBadInputsRuleSet
│   └── Known malicious patterns
│
└── AWS Marketplace Rules
    └── F5, Fortinet, Imperva, etc.
```

**Benefit:** Turn on protection instantly without security expertise!

---

## WAF vs Shield

```
┌─────────────────────────────────────────────────────────────┐
│                       ATTACK TYPES                           │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   SQL Injection ─────────────► AWS WAF                      │
│   XSS Attacks ───────────────► AWS WAF                      │
│   Bad Bots ──────────────────► AWS WAF                      │
│   Rate Abuse ────────────────► AWS WAF                      │
│                                                              │
│   DDoS (L3/L4) ──────────────► AWS Shield                   │
│   DDoS (L7) ─────────────────► Shield Advanced + WAF        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

| Aspect | AWS WAF | AWS Shield |
|--------|---------|------------|
| **Attack type** | Web exploits | DDoS attacks |
| **Layer** | Layer 7 only | L3/L4 (L7 with Advanced) |
| **Cost** | Pay per use | Standard = Free |
| **Examples** | SQL injection, XSS | Volumetric floods |

---

## Pricing Model

```
PAY-AS-YOU-GO
├── $5.00 / month per Web ACL
├── $1.00 / month per rule
└── $0.60 / million requests inspected

MANAGED RULES
└── Varies by publisher (some free, some $20+/month)
```

---

## Real-World Example

**Your e-commerce site under attack:**

```
Attacker tries: www.shop.com/search?q=' DROP TABLE users;--
                                      ▲
                                      │ SQL Injection!

Without WAF:
─────────────────────────────────────────────────
Request ──► ALB ──► Application ──► Database DELETED! 💀

With WAF:
─────────────────────────────────────────────────
Request ──► WAF ──► BLOCKED! 🛡️
                    "403 Forbidden"
```

---

## Common Exam Questions

**Q1**: Protect web app from SQL injection attacks?
> **AWS WAF** - Layer 7, inspects request content

**Q2**: Which services does WAF integrate with?
> **CloudFront, ALB, API Gateway, AppSync, Cognito**
> NOT: EC2, NLB, RDS

**Q3**: Difference between WAF and Shield?
> - WAF = Web exploits (SQL injection, XSS)
> - Shield = DDoS attacks

**Q4**: How to quickly protect against OWASP Top 10?
> **AWS Managed Rules** - pre-built, turn on instantly

**Q5**: Rate-limit API requests per IP?
> **WAF Rate-based rules** - block IPs exceeding threshold

**Q6**: Why can't WAF protect NLB or EC2 directly?
> **WAF inspects HTTP request content** (headers, body, cookies)
> NLB operates at Layer 4 - only sees IP addresses and ports, never opens the packet
> EC2 receives raw traffic - WAF has no insertion point without a Layer 7 service in front

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **WAF** | Web app bouncer (Layer 7) |
| **Web ACL** | Container for rules |
| **Rules** | Match condition + action |
| **Managed Rules** | Pre-built protection |
| **Rate-based** | Block abusive IPs |
| **vs Shield** | WAF = exploits, Shield = DDoS |
| **Works with** | CloudFront, ALB, API Gateway |
