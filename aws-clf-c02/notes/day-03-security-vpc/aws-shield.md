# AWS Shield

> AWS Shield = Your cloud's bodyguard against DDoS attacks - Standard is free armor, Advanced is a full security team

## What Shield Does

```
✅ Protects against DDoS (Distributed Denial of Service) attacks
✅ Always-on detection and automatic mitigation
✅ Protects network (L3) and transport (L4) layers
✅ Standard: Free for all AWS customers
✅ Advanced: 24/7 DDoS Response Team access
✅ Advanced: Cost protection from DDoS scaling charges
```

---

## How Shield Works

```
DDoS Attack Incoming
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│                      AWS SHIELD                              │
│                (DDoS Detection & Mitigation)                 │
│                                                              │
│   Monitors traffic:                                          │
│   ├── Volumetric flood? → ABSORB at edge                    │
│   ├── SYN/UDP flood? → MITIGATE automatically               │
│   ├── Reflection attack? → FILTER malicious packets         │
│   └── Normal traffic? → PASS through                         │
└─────────────────────────────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────────────────────────────┐
│   Your Application (CloudFront/ALB/EC2/Route 53)            │
└─────────────────────────────────────────────────────────────┘
```

---

## Core Concept: DDoS Protection Layers

```
DDOS ATTACK TYPES
├── Layer 3 (Network)
│   ├── IP floods
│   ├── Reflection/amplification attacks
│   └── Shield Standard handles these ✅
│
├── Layer 4 (Transport)
│   ├── SYN floods
│   ├── UDP floods
│   └── Shield Standard handles these ✅
│
└── Layer 7 (Application)
    ├── HTTP floods
    ├── Slow POST/GET attacks
    └── Shield Advanced + WAF needed ⚠️
```

---

## Shield Standard vs Shield Advanced

| Aspect | Shield Standard | Shield Advanced |
|--------|-----------------|-----------------|
| **Cost** | 🆓 FREE (automatic) | $3,000/month + data fees |
| **Protection** | L3/L4 attacks | L3/L4 + L7 attacks |
| **Detection** | Always-on | Advanced real-time metrics |
| **Mitigation** | Automatic | Automatic + manual control |
| **Support** | None dedicated | 24/7 DDoS Response Team (DRT) |
| **Cost Protection** | ❌ None | ✅ Covers DDoS scaling charges |
| **WAF Integration** | Basic (charged separately) | ✅ WAF fees waived |
| **Commitment** | None | 1-year minimum |

---

## What Shield Protects

```
SHIELD PROTECTED SERVICES
├── ✅ Amazon CloudFront (CDN at edge)
├── ✅ Amazon Route 53 (DNS)
├── ✅ AWS Global Accelerator
├── ✅ Elastic Load Balancing (ALB, NLB, CLB)
├── ✅ Amazon EC2 (Elastic IP addresses)
│
└── 💡 Shield Standard = Automatic for all above!
```

---

## Key Components

```
SHIELD STRUCTURE
├── 🛡️ Shield Standard (Always Active)
│   ├── Network flow monitoring
│   ├── Traffic anomaly detection
│   └── Automatic inline mitigation
│
├── 🔐 Shield Advanced (Subscription)
│   ├── All Standard features
│   ├── Enhanced detection algorithms
│   ├── L7 application layer protection
│   ├── DDoS cost protection
│   └── AWS Firewall Manager integration
│
└── 👥 DDoS Response Team (DRT/SRT)
    ├── 24/7 expert support
    ├── Attack analysis and guidance
    └── Custom mitigation rules
```

---

## Shield + WAF Integration

```
COMPLETE WEB PROTECTION
┌─────────────────────────────────────────────────────────────┐
│                    INTERNET (Attackers)                      │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│  AWS SHIELD                                                  │
│  ├── L3 Protection: IP floods, reflection attacks           │
│  └── L4 Protection: SYN/UDP floods                          │
├─────────────────────────────────────────────────────────────┤
│  AWS WAF (with Shield Advanced)                              │
│  └── L7 Protection: HTTP floods, slow attacks               │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│              CloudFront / ALB / API Gateway                  │
└─────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                    YOUR APPLICATION                          │
└─────────────────────────────────────────────────────────────┘
```

**Shield Advanced + WAF Benefit:** WAF fees waived for protected resources!

---

## When to Choose Each Tier

```
DECISION TREE
│
├── "I just want basic DDoS protection"
│   └── ✅ Shield Standard (FREE, automatic)
│
├── "I'm a small business, budget-conscious"
│   └── ✅ Shield Standard + basic WAF rules
│
├── "I expect sophisticated L7 attacks"
│   └── 🔐 Shield Advanced
│
├── "I need 24/7 expert support during attacks"
│   └── 🔐 Shield Advanced (DRT access)
│
├── "DDoS cost spikes would hurt my budget"
│   └── 🔐 Shield Advanced (cost protection)
│
└── "I'm running enterprise/gaming/financial apps"
    └── 🔐 Shield Advanced (full protection)
```

---

## Shield vs WAF vs Security Groups

| Feature | Shield | WAF | Security Groups |
|---------|--------|-----|-----------------|
| **Layer** | L3/L4 (L7 with Advanced) | L7 only | L4 |
| **Attack Type** | DDoS | Web exploits | Port/IP filtering |
| **Scope** | AWS-wide | Per resource | Per instance |
| **Example** | Volumetric floods | SQL injection | Block IP ranges |
| **Cost** | Standard=Free | Pay per use | Free |

---

## Pricing Summary

```
SHIELD PRICING
├── 📗 Standard
│   └── $0 (included with all AWS accounts)
│
└── 📘 Advanced
    ├── $3,000/month base fee
    ├── + Data transfer out charges
    ├── + 1-year commitment required
    └── + WAF fees WAIVED for protected resources
```

---

## Common Exam Questions

**Q1**: Which AWS service provides DDoS protection for free?
> **AWS Shield Standard** - Automatic, always-on, no extra charge

**Q2**: How to get 24/7 expert help during a DDoS attack?
> **AWS Shield Advanced** - Includes DDoS Response Team (DRT) access

**Q3**: What's the main difference between Shield Standard and Advanced?
> - Standard = L3/L4 protection, free, automatic
> - Advanced = L3/L4 + L7, $3k/month, DRT support, cost protection

**Q4**: Which services does Shield Standard automatically protect?
> **CloudFront, Route 53, Global Accelerator, ELB, EC2** (all automatically!)

**Q5**: How to prevent unexpected bills from DDoS attacks?
> **Shield Advanced** - Includes cost protection for DDoS-related scaling

**Q6**: Shield vs WAF - which for SQL injection?
> **WAF** - Shield is for DDoS, WAF is for web application attacks

**Q7**: Minimum commitment for Shield Advanced?
> **1-year subscription** required

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **Shield** | DDoS bodyguard (L3/L4) |
| **Standard** | Free armor for everyone |
| **Advanced** | Premium security team ($3k/mo) |
| **DRT** | 24/7 DDoS experts (Advanced only) |
| **Cost Protection** | Advanced pays your DDoS bills |
| **WAF Integration** | Advanced waives WAF fees |
| **vs WAF** | Shield=DDoS, WAF=exploits |
| **Protected** | CloudFront, Route53, ELB, EC2 |
