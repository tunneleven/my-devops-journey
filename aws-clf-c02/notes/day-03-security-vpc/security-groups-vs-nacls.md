# Security Groups vs NACLs

> Security Groups = Bodyguard for each instance | NACLs = Security gate for the entire subnet

---

## The Big Picture (EXAM FAVORITE!)

```
                    INTERNET
                        │
                        ▼
               ┌────────────────┐
               │     NACL       │  ← Subnet-level (gate)
               │  (Stateless)   │
               └───────┬────────┘
                       │
    ┌──────────────────┼──────────────────┐
    │              SUBNET                 │
    │                                     │
    │   ┌─────────┐       ┌─────────┐    │
    │   │Security │       │Security │    │
    │   │ Group   │       │ Group   │    │ ← Instance-level
    │   │(Stateful)│      │(Stateful)│   │   (bodyguard)
    │   └────┬────┘       └────┬────┘    │
    │        │                 │         │
    │   ┌────▼────┐       ┌────▼────┐    │
    │   │   EC2   │       │   EC2   │    │
    │   │Instance │       │Instance │    │
    │   └─────────┘       └─────────┘    │
    │                                     │
    └─────────────────────────────────────┘
```

---

## Comparison Table (MEMORIZE THIS!)

| Feature | Security Group | NACL |
|---------|----------------|------|
| **Level** | **Instance** | **Subnet** |
| **Statefulness** | **Stateful** | **Stateless** |
| **Rules** | **Allow only** | **Allow + Deny** |
| **Default Inbound** | Deny all | Allow all (default NACL) |
| **Rule Evaluation** | All rules checked | Number order (lowest first) |
| **Multiple per resource** | Yes (many per EC2) | No (one per subnet) |

---

## Stateful vs Stateless (KEY CONCEPT!)

### Security Groups (Stateful)
```
Request:  EC2 → Internet (allowed by outbound rule)
Response: Internet → EC2 (AUTO-ALLOWED! ✅)

No need to configure return traffic!
```

### NACLs (Stateless)
```
Request:  EC2 → Internet (need outbound allow)
Response: Internet → EC2 (NEED SEPARATE inbound rule! ⚠️)

Must configure BOTH directions explicitly!
```

**Memory Hook:** 
- **State**ful = Remembers the **state** (return traffic auto-allowed)
- **State**less = Forgets immediately (must specify both ways)

---

## Allow vs Deny Rules

| Action | Security Group | NACL |
|--------|----------------|------|
| Allow traffic from IP | ✅ Yes | ✅ Yes |
| **Block** specific IP | ❌ **Cannot** | ✅ **Can** |

```
Need to block an attacker's IP?
└── Use NACL (Security Groups CANNOT deny!)
```

---

## Default Behavior

| Component | Default Inbound | Default Outbound |
|-----------|-----------------|------------------|
| **Security Group** | ❌ Deny all | ✅ Allow all |
| **Default NACL** | ✅ Allow all | ✅ Allow all |
| **Custom NACL** | ❌ Deny all | ❌ Deny all |

---

## 📝 Exam Practice Questions

### Question 1
**What is the KEY difference between Security Groups and NACLs?**

A) Security Groups are free, NACLs are paid  
B) Security Groups are stateful, NACLs are stateless  
C) Security Groups work at VPC level, NACLs at region level  
D) Security Groups can deny traffic, NACLs cannot  

<details><summary>Answer</summary>
**B) Security Groups are stateful, NACLs are stateless** - This is the fundamental difference that affects how return traffic is handled.
</details>

---

### Question 2
**An administrator needs to block traffic from a specific IP address. Which should they use?**

A) Security Group with deny rule  
B) Network ACL with deny rule  
C) Route table  
D) Internet Gateway  

<details><summary>Answer</summary>
**B) Network ACL with deny rule** - Security Groups cannot explicitly deny; they can only allow. NACLs support both allow AND deny rules.
</details>

---

### Question 3
**If a Security Group allows outbound HTTPS, what happens to the response traffic?**

A) It's automatically blocked  
B) It requires a separate inbound rule  
C) It's automatically allowed due to stateful behavior  
D) It requires a NACL rule  

<details><summary>Answer</summary>
**C) It's automatically allowed due to stateful behavior** - Security Groups are stateful, so return traffic is automatically permitted.
</details>

---

### Question 4
**At what level do Security Groups operate?**

A) VPC level  
B) Subnet level  
C) Instance level  
D) Region level  

<details><summary>Answer</summary>
**C) Instance level** - Security Groups are attached to instances (EC2, RDS, ENIs), not subnets.
</details>

---

### Question 5
**What is the default inbound rule for a new Security Group?**

A) Allow all traffic  
B) Deny all traffic  
C) Allow HTTP/HTTPS only  
D) Allow SSH only  

<details><summary>Answer</summary>
**B) Deny all traffic** - New Security Groups deny all inbound traffic by default. You must add allow rules.
</details>

---

## Memory Summary

| Concept | Security Group | NACL |
|---------|----------------|------|
| **Level** | 👤 Instance | 🏘️ Subnet |
| **State** | 🧠 Remembers (stateful) | 🤷 Forgets (stateless) |
| **Rules** | ✅ Allow only | ✅❌ Allow + Deny |
| **Analogy** | Bodyguard | Gate |

---

## Quick Decision Guide

| Scenario | Answer |
|----------|--------|
| "Block specific IP" | **NACL** (can deny) |
| "Control per-instance traffic" | **Security Group** |
| "Don't want to configure return traffic" | **Security Group** (stateful) |
| "Control entire subnet" | **NACL** |
| "Multiple firewalls per instance" | **Security Group** (many per EC2) |
