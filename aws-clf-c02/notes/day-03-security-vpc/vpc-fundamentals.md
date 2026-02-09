# AWS VPC Fundamentals

> VPC = Your own private network in AWS - like having a private office building in AWS's cloud city

---

## The Big Picture

```
                            INTERNET
                               │
                               ▼
                      ┌────────────────┐
                      │ Internet       │
                      │ Gateway (IGW)  │
                      └────────┬───────┘
                               │
    ┌──────────────────────────┴──────────────────────────┐
    │                       VPC                           │
    │                  (10.0.0.0/16)                      │
    │                                                     │
    │   ┌─────────────────┐     ┌─────────────────┐      │
    │   │  PUBLIC SUBNET  │     │ PRIVATE SUBNET  │      │
    │   │  (10.0.1.0/24)  │     │ (10.0.2.0/24)   │      │
    │   │                 │     │                 │      │
    │   │   ┌─────────┐   │     │   ┌─────────┐   │      │
    │   │   │   EC2   │   │     │   │   RDS   │   │      │
    │   │   │ (Web)   │   │     │   │  (DB)   │   │      │
    │   │   └─────────┘   │     │   └─────────┘   │      │
    │   │                 │     │        │        │      │
    │   │   ┌─────────┐   │     │        │        │      │
    │   │   │   NAT   │◄──┼─────┼────────┘        │      │
    │   │   │ Gateway │   │     │  (outbound)     │      │
    │   │   └─────────┘   │     │                 │      │
    │   └─────────────────┘     └─────────────────┘      │
    │                                                     │
    └─────────────────────────────────────────────────────┘
```

---

## VPC Components

| Component | What It Does | Analogy |
|-----------|--------------|---------|
| **VPC** | Your isolated network | Your office building |
| **Subnet** | Partition within VPC (one AZ) | Floor in building |
| **CIDR Block** | IP address range | Street address range |
| **Internet Gateway** | Connects VPC to internet | Front door |
| **NAT Gateway** | Private → Internet (outbound only) | Back door (exit only) |
| **Route Table** | Traffic direction rules | Hallway signs |

---

## Public vs Private Subnets (EXAM FAVORITE!)

| Feature | Public Subnet | Private Subnet |
|---------|---------------|----------------|
| **Has route to IGW** | ✅ Yes | ❌ No |
| **Public IP** | ✅ Yes | ❌ No |
| **Internet access** | Inbound + Outbound | Outbound only (via NAT) |
| **Use for** | Web servers, load balancers | Databases, app servers |

```
TRAFFIC FLOW:

Internet → IGW → Public Subnet (Web Server)
                         │
                         ▼
                 Private Subnet (Database)
                         │
                         ▼ (needs updates?)
                    NAT Gateway → Internet
```

---

## Key Components Explained

### Internet Gateway (IGW)
```
Internet ←→ IGW ←→ Public Subnet
         (bidirectional)
```
- Allows **inbound AND outbound** traffic
- Attached to VPC (one per VPC)

### NAT Gateway
```
Private Subnet → NAT Gateway → Internet
              (outbound only!)
```
- Allows **outbound only** (for updates, patches)
- **Blocks inbound** traffic from internet
- Deployed in **public subnet**

### Route Tables
```
Public Subnet Route Table:
┌─────────────────────────────────┐
│ Destination    │  Target       │
├─────────────────────────────────┤
│ 10.0.0.0/16    │  local        │ ← Stay in VPC
│ 0.0.0.0/0      │  igw-xxx      │ ← Go to internet
└─────────────────────────────────┘

Private Subnet Route Table:
┌─────────────────────────────────┐
│ Destination    │  Target       │
├─────────────────────────────────┤
│ 10.0.0.0/16    │  local        │ ← Stay in VPC
│ 0.0.0.0/0      │  nat-xxx      │ ← Go via NAT
└─────────────────────────────────┘
```

---

## CIDR Blocks

| CIDR | IP Range | # IPs |
|------|----------|-------|
| 10.0.0.0/**16** | 10.0.0.0 - 10.0.255.255 | 65,536 |
| 10.0.1.0/**24** | 10.0.1.0 - 10.0.1.255 | 256 |
| 10.0.2.0/**24** | 10.0.2.0 - 10.0.2.255 | 256 |

**Memory Hook:** "Smaller CIDR number = **Bigger** network"

---

## 📝 Exam Practice Questions

### Question 1
**What makes a subnet "public"?**

A) It has a public IP address  
B) It has a route to an Internet Gateway  
C) It's in the first Availability Zone  
D) It uses a NAT Gateway  

<details><summary>Answer</summary>
**B) It has a route to an Internet Gateway** - A public subnet has a route table entry pointing to an IGW.
</details>

---

### Question 2
**A company wants their private database to download software updates from the internet. What should they use?**

A) Internet Gateway  
B) NAT Gateway  
C) VPC Peering  
D) VPC Endpoint  

<details><summary>Answer</summary>
**B) NAT Gateway** - NAT Gateway allows private subnet resources to access the internet for outbound traffic.
</details>

---

### Question 3
**How many Internet Gateways can be attached to a VPC?**

A) Unlimited  
B) One per subnet  
C) One per VPC  
D) One per Availability Zone  

<details><summary>Answer</summary>
**C) One per VPC** - Each VPC can have only one Internet Gateway attached.
</details>

---

### Question 4
**Which component determines where network traffic is directed in a VPC?**

A) Security Group  
B) Network ACL  
C) Route Table  
D) NAT Gateway  

<details><summary>Answer</summary>
**C) Route Table** - Route tables contain rules that determine where traffic is directed.
</details>

---

## Memory Summary

| Component | Purpose | Memory Hook |
|-----------|---------|-------------|
| **VPC** | Isolated network | "Virtual Private Castle" |
| **Subnet** | Network partition | "Sub-division of VPC" |
| **IGW** | Internet door | "In-and-out Gateway" |
| **NAT** | Exit-only door | "No incoming Allowed through This" |
| **Route Table** | Traffic directions | "Road map" |

---

## Quick Decision Guide

| Scenario | Answer |
|----------|--------|
| "EC2 needs internet access" | Public subnet + IGW |
| "RDS needs software updates" | Private subnet + NAT Gateway |
| "Web server + database" | Web=Public, DB=Private |
| "Where does 0.0.0.0/0 go?" | Check route table target |
