# 🚀 Container-Native DevOps Roadmap V2: Jan - March 2026

**Status:** `REFINED` (Optimized for Terraform 004 & Realistic Pacing)
**Role:** Developer ➡️ DevOps Engineer
**Core Stack:** Git + Terraform + Docker + AWS (ECS/Serverless)
**Schedule:**
*   **Mon-Fri:** 2 hours/day (10h)
*   **Sat-Sun:** 3 hours/day (6h)
*   **Total:** 16 hours/week (Intense but Effective)

---

## 🏆 The "Corrected" Certification Goals
1.  **HashiCorp Certified: Terraform Associate (004)**
    *   *Note:* Version 003 is retired. You MUST study for 004.
    *   *Target Exam Window:* **Feb 19 – Feb 22, 2026** (Shifted +1 week for complete 004 coverage)
2.  **AWS Certified Developer - Associate (DVA-C02)**
    *   *Target Exam Window:* **March 23 – March 27, 2026**

---

## � Selected Resources (Verified)
*   **Video Course:** [Udemy] **Zeal Vora** - "HashiCorp Certified: Terraform Associate 2026" (Best for "Code-First" learning).
*   **Practice Exams:** [Udemy] **Bryan Krausen** - "Terraform Associate 004 Practice Exams" (Essential for Feb 12 milestone).
*   **Sprint 1 Manual:** [HashiCorp Docs] **"Get Started - Docker"** (Your Task for Today).

---

## �📅 The 9-Week Sprint Schedule

### **Phase 1: The Protocol (Infrastructure & Basics)**

**Sprint 1: The Trinity - Git, Docker, Terraform (Jan 22 - Feb 1)**
*   **Focus:** Managing local containers with Code AND Version Control.
*   **Weekend Deep Dive (6h):** Build a "Lab Environment" entirely in code. Destroy it. Rebuild it.
*   **Key Lab:**
    1.  Create a `docker-compose.yml` for Nginx.
    2.  Translate it to a Terraform `docker_container` resource.
    3.  Commit every step to GitHub (Public Repo).
*   **Concepts:** Terraform Providers, State, Variables, **Git Workflow (Add/Commit/Push)**.

**Sprint 2: Modules & The Cloud Backend (Feb 2 - Feb 11)**
*   **Focus:** Reusable Infrastructure & Remote State.
*   **Weekend Deep Dive (6h):** Terraform 004 Practice Exams & "Refactor Day" (Turn your Sprint 1 code into a Module).
*   **Concepts:** `ephemeral` resources (004 specific), Modules, remote backends (S3 + DynamoDB locking).
*   **Action:** Take Tutorials Dojo Practice Exams for **Version 004**.

**🛑 MILESTONE 1: Sit Terraform Associate 004 (Feb 12 - Feb 15)**

---

### **Phase 2: The AWS Container Layer**

**Sprint 3: ECS Fargate "The Hard Way" (Feb 16 - Mar 1)**
*   **Focus:** Running Containers in the Cloud (No Wizards).
*   **Weekend Deep Dive (6h):** Debugging IAM Permissions. (You *will* get AccessDenied errors. This is the learning).
*   **Key Lab:**
    1.  Push Docker image to ECR.
    2.  Deploy ALB (Load Balancer) + ECS Service + Task Definition.
    3.  **Strict Rule:** Write Terraform for *everything*. No Console clicks.
*   **Concepts:** IAM Roles (Task vs Execution), Target Groups, Security Groups.

**Sprint 4: Data & Integration (Mar 2 - Mar 15)**
*   **Focus:** Connecting Apps to Data securely.
*   **Weekend Deep Dive (6h):** Secrets Management Rotation logic.
*   **Key Lab:** Connect ECS to DynamoDB. Inject credentials via **AWS Secrets Manager** (Not environment variables!).
*   **Concepts:** DynamoDB design, Secrets Manager, VPC Endpoints (Advanced but critical).

---

### **Phase 3: Automation**

**Sprint 5: The Pipeline (Mar 16 - Mar 22)**
*   **Focus:** CI/CD.
*   **Key Lab:** GitHub Actions Pipeline:
    1.  Lint Terraform (`terraform fmt`).
    2.  Build Docker Image -> ECR.
    3.  Updates ECS Service (`terraform apply -auto-approve`).
*   **Concepts:** "GitOps" basics, rolling updates.

**🛑 MILESTONE 2: Sit AWS Developer Associate Exam (Mar 23 - Mar 27)**

---

## 💰 The Financial Estimate
*   **Exams:** ~$265.00
    *   Terraform: ~$70.50 USD
    *   AWS DVA-C02: ~$150.00 USD
*   **Practice Tests:** ~$30.00 (Tutorials Dojo recommended)
*   **Cloud Budget:** ~$20.00 (Slightly higher buffer for ECS NAT Gateways)

---

## 🧠 New "Code-First" Rules
1.  **Git or It Didn't Happen:** If code isn't committed, you didn't write it.
2.  **Destroy Daily:** ECS & NAT Gateways cost money even when idle. Run `terraform destroy` every night before bed.
3.  **Read the Plan:** Never run `terraform apply` without reading the `plan` output line-by-line.
