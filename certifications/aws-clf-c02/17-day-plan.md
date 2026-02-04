# ⚡ AWS DVA-C02: The 17-Day "Code-First" Protocol

**Status:** `ACTIVE`
**Deadline:** Feb 12, 2026
**Strategy:** "Don't just read it. SDK it."

---

## 📅 The Schedule (Jan 26 - Feb 11)

### 🔥 Sprint 1: The Serverless Core (32% of Exam)
*The most critical domain. If you fail this, you fail the exam.*

**Day 1 (Mon, Jan 26): Lambda Mechanics**
*   **Study:** Execution Env, Layers, Versions/Aliases, SnapStart.
*   **Lab (Terraform + Python):**
    *   **Infra (TF):** Define an `aws_lambda_function` resource.
    *   **Code (Py):** Write a handler that reads Env Vars and writes to `stdout`.
    *   **Task:** Use Terraform to deploy the Lambda. Then use AWS CLI to `publish-version`.

**Day 2 (Tue, Jan 27): DynamoDB (The Developer Way)**
*   **Study:** RCUs/WCUs, Partitions, LSI vs GSI, DAX, Streams.
*   **Lab (Terraform + Python):**
    *   **Infra (TF):** Define `aws_dynamodb_table` with a GSI and Stream enabled.
    *   **Code (Py):** Write a `boto3` script to `PutItem` with a ConditionExpression.
    *   **Note:** You *cannot* skip the Python part. The exam asks specifically about `helpers` vs `client` methods.

**Day 3 (Wed, Jan 28): API Gateway**
*   **Study:** Integration Types (Lambda vs HTTP), Stages, Throttling, Caching.
*   **Lab (Terraform):**
    *   **Infra (TF):** specialized `aws_api_gateway_rest_api`, `_resource`, `_method`, and `_integration`.
    *   **Challenge:** It's painful in raw Terraform. Good practice for understanding the *structure* of APIGW.
    *   **Task:** Enable Caching on a Stage via Terraform.

**Day 4 (Thu, Jan 29): Cognito & Auth**
*   **Study:** User Pools vs Identity Pools. JWT Structure.
*   **Lab (Terraform + CLI):**
    *   **Infra (TF):** Deploy `aws_cognito_user_pool` and `aws_cognito_user_pool_client`.
    *   **Task:** Create a user in the console, then use CLI to `initiate-auth` and get a JWT.

**Day 5 (Fri, Jan 30): SQS, SNS & Kinesis (Decoupling)**
*   **Study:** FIFO vs Standard, Visibility Timeout, Fan-out, Shards.
*   **Lab (Terraform):**
    *   **Infra (TF):** Deploy an SQS Queue (`fifo_queue = true`) and an SNS Topic.
    *   **Task:** Subscribe the Queue to the Topic (`aws_sns_topic_subscription`).

**Weekend 1 (Jan 31 - Feb 1): The "Polygltot" Build (Heavy Coding)**
*   **Goal:** Build a Serverless App.
*   **Task:**
    1.  **Terraform:** Provision DynamoDB, S3, SQS.
    2.  **SAM (Required for Exam):** Provision the Lambda & API Gateway part. (Yes, mix them. You NEED to learn SAM syntax for the exam).
    3.  **Python:** The glue code.

---

### 🛡️ Sprint 2: Security & Deployment (26% + 24%)
*Where Developers lose points by guessing.*

**Day 8 (Mon, Feb 2): IAM Policies**
*   **Study:** Resource-based vs Identity-based can allow/deny. `iam:PassRole`.
*   **Lab (Terraform):**
    *   **Infra (TF):** Use `aws_iam_policy_document` data source (Best Practice).
    *   **Task:** Attach a policy to a Role that allows S3 access ONLY if `aws:SourceIp` matches.

**Day 9 (Tue, Feb 3): Encryption (KMS)**
*   **Study:** Envelope Encryption, GenerateDataKey.
*   **Lab (Terraform + CLI):**
    *   **Infra (TF):** Create `aws_kms_key` and `aws_kms_alias`.
    *   **Task:** Encrypt a file locally using the CLI and that Key ID.

**Day 10 (Wed, Feb 4): CI/CD (The Code* Suite)**
*   **Study:** CodeCommit, CodeBuild (buildspec.yaml), CodePipeline.
*   **Lab (Terraform):**
    *   **Infra (TF):** define `aws_codebuild_project`.
    *   **File:** Write the `buildspec.yml` (This file is NOT Terraform, it's YAML).

**Day 11 (Thu, Feb 5): CloudFormation & SAM (CRITICAL)**
*   **Study:** Intrinsic functions (`Fn::GetAtt`), Transforms.
*   **Constraint:** **DO NOT USE TERRAFORM TODAY.**
*   **Reason:** The exam will show you YAML templates, not HCL. If you don't write one, you won't recognize the syntax errors in the questions.
*   **Task:** Write a native CloudFormation template for an S3 bucket and deploy it.

**Day 12 (Fri, Feb 6): Elastic Beanstalk**
*   **Study:** Deployment Policies.
*   **Lab (Terraform):**
    *   **Infra (TF):** `aws_elastic_beanstalk_application` & `_environment`.
    *   **Task:** defining Option Settings in Terraform is tricky. Good learning experience.

**Weekend 2 (Feb 7 - Feb 8): Practice Exam & Gaps**
*   **Saturday:** Full Mock Exam 1 (Timed). Review EVERY wrong answer.
*   **Sunday:** Deep dive into weak areas.

---

### 🔧 Sprint 3: Fine-Tuning (18%)
*The "Exam Pass" Insurance.*

**Day 15 (Mon, Feb 9): Monitoring (CloudWatch & X-Ray)**
*   **Study:** Embedded Metric Format, X-Ray Sampling, Annotations vs Metadata.
*   **Code:**
    *   Use `put-metric-data` to send a custom metric.

**Day 16 (Tue, Feb 10): Caching & optimize**
*   **Study:** ElastiCache (Redis vs Memcached), CloudFront behaviors.
*   **Code:**
    *   Configure a CloudFront signed URL generation script.

**Day 17 (Wed, Feb 11): Final Review**
*   **Action:** Read "Cheat Sheets" (Tutorials Dojo). Get 8h sleep.

---

## 🛠️ Daily Routine (3.5h)
1.  **30m:** Review Flashcards (Anki).
2.  **1.5h:** Topic Study (Video at 1.5x speed OR Docs).
3.  **1.5h:** **LAB/CODE**. (This is non-negotiable).

## 🧰 Resources
*   **Docs:** [AWS Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
*   **Practice:** Tutorials Dojo (DVA-C02)
