# 01: Cloud Concepts & Managed Services

**Focus:** Understanding the "Why" of Cloud and the "Who does What" (Shared Responsibility).
**Time:** 90 Minutes
**Resource File:** [01-cloud-concepts.md](../../../learn/aws-clf-c02/01-cloud-concepts.md)
**Official Guide Alignment:**
*   [Domain 1: Cloud Concepts](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain1.html) (Full)
*   [Domain 2.1: Shared Responsibility](https://docs.aws.amazon.com/aws-certification/latest/examguides/cloud-practitioner-02-domain2.html)

## 🎯 Objectives
1.  Explain the difference between **CAPEX** (Hardware) and **OPEX** (Cloud).
2.  Identify who is responsible for what in the **Shared Responsibility Model**.
3.  **Lab Goal:** Use Terraform to prove that Managed Services (RDS) require less configuration than Unmanaged Services (EC2).

## 📚 Study (60 min)
**Read These Sections:**
1.  [The Value of Cloud](../../../learn/aws-clf-c02/01-cloud-concepts.md#1-the-value-of-cloud-buzzwords) - Distinguish Agility vs Elasticity.
2.  [Cloud Economics](../../../learn/aws-clf-c02/01-cloud-concepts.md#2-cloud-economics) - CAPEX/OPEX & TCO.
3.  [Well-Architected Framework](../../../learn/aws-clf-c02/01-cloud-concepts.md#3-the-aws-well-architected-framework-6-pillars) - **Memorize the 6 Pillars**.
4.  [Shared Responsibility](../../../learn/aws-clf-c02/01-cloud-concepts.md#4-the-shared-responsibility-model) - "OF" vs "IN".
5.  [Migration & Adoption](../../../learn/aws-clf-c02/01-cloud-concepts.md#5-migration--adoption) - The 7 Rs & CAF.

## 💻 Lab: The Responsibility Visualizer (30 min)
**Path:** `certifications/aws-clf-c02/labs/day01-cloud-concepts`

### Step 1: Initialize Project
Create a `main.tf` file. Define the `aws` provider.

### Step 2: Define an "Unmanaged" Resource
Define an `aws_instance` (EC2).
*   **Requirement:** Notice you MUST specify the `ami` (Operating System).
*   **Why?** Because **YOU** are responsible for patching the OS (Security *IN* the cloud).

### Step 3: Define a "Managed" Resource
Define an `aws_db_instance` (RDS).
*   **Requirement:** Notice you DO NOT specify an AMI or OS. You only specify the `engine_version`.
*   **Why?** Because **AWS** is responsible for patching the OS (Security *OF* the cloud).

**Cheat Code (Copy this to avoid syntax errors):**
```hcl
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
```

### Step 4: Verify via Plan
Run `terraform init` and `terraform plan`.
*   Scan the output. Confirm that `aws_db_instance` has no parameters for "Kernel" or "Ramdisk" or "Root Volume Patching".

## 🔬 Verification
*   **Question:** If the RDS database gets hacked because the *OS* was outdated, whose fault is it? (Answer: AWS).
*   **Question:** If the EC2 instance gets hacked because the *OS* was outdated, whose fault is it? (Answer: YOU).

## 📝 Exam Simulation (Trust Source: Tutorials Dojo / Whizlabs style)

### Question 1: Shared Responsibility
A startup is migrating its web application to AWS EC2 instances and S3. They configure security groups and enable server-side encryption. Under the AWS Shared Responsibility Model, which of the following is **AWS** directly responsible for?

*   A. Patching the guest OS on EC2 instances.
*   B. Configuring security groups and network ACLs.
*   C. Ensuring the physical hardware and facilities in the Availability Zone are secure.
*   D. Encrypting customer data at the server level in S3.

<details>
<summary>Click to reveal Answer</summary>

**Correct Answer: C**
*   **Explanation:** AWS is responsible for the Security **OF** the cloud (Hardware, Concrete, Cabling).
*   **Why wrong:** A, B, D are all "Security **IN** the cloud" (Customer responsibility).
</details>

### Question 2: Cloud Economics
A manufacturing company maintains an on-premises data center with significant upfront hardware purchases. They want to switch to a model where they only pay for what they use. Which benefit of cloud computing aligns with this?

*   A. Replacing operational expenses (OPEX) with capital expenses (CAPEX).
*   B. Replacing upfront capital expenses (CAPEX) with low variable operational expenses (OPEX).
*   C. Increasing fixed operational expenses for better predictability.
*   D. Converting all costs to high upfront capital investments.

<details>
<summary>Click to reveal Answer</summary>

**Correct Answer: B**
*   **Explanation:** This is the classic definition of Cloud Economics. You trade **CAPEX** (Upfront/Fixed) for **OPEX** (Variable/Pay-as-you-go).
</details>

### Question 3: Well-Architected Framework
A retail company notices their e-commerce app crashes during peak holiday traffic due to over-utilized resources. Which AWS Well-Architected Pillar should they prioritize to fix this **failure**?

*   A. Operational Excellence
*   B. Security
*   C. Reliability
*   D. Cost Optimization

<details>
<summary>Click to reveal Answer</summary>

**Correct Answer: C**
*   **Explanation:** The **Reliability** pillar focuses on "Recovering from failure" and "Scaling to meet demand" (to prevent failure).
</details>

### Question 4: Agility vs Elasticity
A developer needs to experiment with a new feature and is able to launch a server in minutes, then shut it down after testing. This speed of implementation refers to:

*   A. Elasticity
*   B. Agility
*   C. High Availability
*   D. Scalability

<details>
<summary>Click to reveal Answer</summary>

**Correct Answer: B**
*   **Explanation:** **Agility** is the speed at which *humans/businesses* can move (launching resources quickly).
*   **Distractor:** **Elasticity** (A) is the ability of *machines* to scale up/down automatically based on demand.
</details>

### Question 5: Migration Strategies (The 7 Rs)
A company wants to move their legacy application to the AWS Cloud exactly as it is, without making any code changes, to exit their data center quickly. Which strategy should they use?

*   A. Refactor
*   B. Replatform
*   C. Rehost
*   D. Repurchase

<details>
<summary>Click to reveal Answer</summary>

**Correct Answer: C**
*   **Explanation:** **Rehost** is "Lift and Shift". You move it exactly as it is. Fastest method.
*   **Distractor:** **Replatform** (B) involves "Tinkering" (e.g., changing the OS or DB engine) but not the core code.
</details>
