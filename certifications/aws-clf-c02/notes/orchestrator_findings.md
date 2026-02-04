# 🚨 CLF-C02 Critical Concepts (Orchestrator Findings)

> **Source:** Findings from the Multi-Agent Review on Jan 26, 2026.
> **Purpose:** These are the specific "Gotchas" identified by the Security Auditor and DevOps agents. Master these first.

---

## 🛡️ Security: The "Confusion Matrix"

### 1. Threat Detection vs. Vulnerability Scanning
*   **GuardDuty** (Intelligent Threat Detection)
    *   **What it does:** Monitors **Logs** (CloudTrail, VPC Flow Logs, DNS Logs). Uses ML to find *anomalies*.
    *   **Keywords:** "Intelligent", "Malicious IP", "Crypto mining", "Account compromise".
    *   **Analogy:** A security camera watching for burglars.
*   **Inspector** (Vulnerability Management)
    *   **What it does:** Scans **EC2 Instances** and **ECR Images** for software vulnerabilities (CVEs).
    *   **Keywords:** "CVE", "Network Reachability", "Package vulnerability", "Assessment".
    *   **Analogy:** A building inspector checking for weak locks or broken windows.

### 2. DDoS vs. Web Exploits
*   **AWS WAF** (Web Application Firewall)
    *   **Layer:** Layer 7 (Application).
    *   **Protects Against:** SQL Injection, Cross-Site Scripting (XSS), Bad Bots.
    *   **Attaches to:** CloudFront, ALB, API Gateway.
*   **AWS Shield** (DDoS Protection)
    *   **Layer:** Layer 3/4 (Network/Transport).
    *   **Protects Against:** Volumetric Attacks (UDP Floods).
    *   **Shield Standard:** Free, automatic.
    *   **Shield Advanced:** Paid ($3k/mo), includes DDOS Response Team (DRT).

### 3. Data Privacy
*   **Macie**
    *   **Function:** Discovers sensitive data (PII, Credit Cards) in **S3 Buckets**.
    *   **Method:** Uses Machine Learning validation.

---

## 💰 Billing: Implementation vs. Analysis

### 1. Budgets vs. Cost Explorer
*   **AWS Budgets**
    *   **Action:** **ALERTS** & **ACTIONS**.
    *   **Use Case:** "Email me if I spend > $10." / "Stop the EC2 instance if I exceed budget."
    *   **Tense:** Future/Present monitoring.
*   **Cost Explorer**
    *   **Action:** **VISUALIZE** & **ANALYZE**.
    *   **Use Case:** "Show me a graph of my EC2 spend last month." / "Why is my bill high?"
    *   **Tense:** Past analysis.

---

## 🆘 Support Plans (The Core 4)

| Plan | Response Time (Critical System Down) | Key Feature |
| :--- | :--- | :--- |
| **Basic** | N/A | Customer Service & Docs only. No Tech Support. |
| **Developer** | < 12 hours (Business hours) | Email access to Cloud Support Associates. |
| **Business** | < 1 hour (24/7) | Chat/Phone/Email. Full Trusted Advisor checks. |
| **Enterprise** | < 15 minutes (24/7) | **TAM (Technical Account Manager)**. Review. |

> **Note on Enterprise On-Ramp:** It exists (30 min response), but for the exam, usually distinguish between Business (1hr) and Enterprise (15min + TAM).

---

## 📜 Compliance

### AWS Artifact
*   **Definition:** The central resource for compliance-related information.
*   **Downloads:** ISO certifications, PCI-DSS reports, SOC reports.
*   **Use Case:** "An auditor needs proof that AWS is PCI compliant." -> Go to Artifact.
