# AWS Services Glossary

> Quick reference for AWS services mentioned throughout the course.

---

## Compute

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **EC2** | Virtual servers (IaaS) | [Day 4](../resources/day-04-compute-storage.md) |
| **Lambda** | Serverless functions (FaaS) | [Day 5](../resources/day-05-databases-serverless.md) |
| **Elastic Beanstalk** | Deploy apps without managing infra (PaaS) | [Day 6](../resources/day-06-integration-billing.md) |
| **ECS** | Run Docker containers | [Day 5](../resources/day-05-databases-serverless.md) |
| **EKS** | Managed Kubernetes | [Day 5](../resources/day-05-databases-serverless.md) |
| **Fargate** | Serverless containers | [Day 5](../resources/day-05-databases-serverless.md) |
| **Lightsail** | Simple VPS for beginners | [Day 5](../resources/day-05-databases-serverless.md) |
| **Batch** | Run batch jobs at scale | [Day 5](../resources/day-05-databases-serverless.md) |

---

## Storage

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **S3** | Object storage (files, images) | [Day 4](../resources/day-04-compute-storage.md) |
| **EBS** | Block storage for EC2 | [Day 4](../resources/day-04-compute-storage.md) |
| **EFS** | Shared file system (NFS) | [Day 4](../resources/day-04-compute-storage.md) |
| **S3 Glacier** | Archive storage (cheap, slow) | [Day 4](../resources/day-04-compute-storage.md) |
| **Storage Gateway** | Hybrid cloud storage | [Day 4](../resources/day-04-compute-storage.md) |
| **FSx** | Managed file systems (Windows/Lustre) | [Day 4](../resources/day-04-compute-storage.md) |

---

## Database

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **RDS** | Managed relational databases | [Day 5](../resources/day-05-databases-serverless.md) |
| **Aurora** | AWS-optimized MySQL/PostgreSQL | [Day 5](../resources/day-05-databases-serverless.md) |
| **DynamoDB** | NoSQL key-value database | [Day 5](../resources/day-05-databases-serverless.md) |
| **ElastiCache** | In-memory cache (Redis/Memcached) | [Day 5](../resources/day-05-databases-serverless.md) |
| **Redshift** | Data warehouse for analytics | [Day 5](../resources/day-05-databases-serverless.md) |
| **DocumentDB** | MongoDB-compatible database | [Day 5](../resources/day-05-databases-serverless.md) |
| **Neptune** | Graph database | [Day 5](../resources/day-05-databases-serverless.md) |

---

## Networking

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **VPC** | Virtual private network | [Day 3](../resources/day-03-security-vpc.md) |
| **Subnets** | Network partitions in VPC | [Day 3](../resources/day-03-security-vpc.md) |
| **Security Groups** | Instance-level firewall (stateful) | [Day 3](../resources/day-03-security-vpc.md) |
| **NACLs** | Subnet-level firewall (stateless) | [Day 3](../resources/day-03-security-vpc.md) |
| **Internet Gateway** | Connects VPC to internet | [Day 3](../resources/day-03-security-vpc.md) |
| **NAT Gateway** | Outbound internet for private subnets | [Day 3](../resources/day-03-security-vpc.md) |
| **Route 53** | DNS service | [Day 5](../resources/day-05-databases-serverless.md) |
| **CloudFront** | CDN for content delivery | [Day 5](../resources/day-05-databases-serverless.md) |
| **API Gateway** | Create and manage APIs | [Day 5](../resources/day-05-databases-serverless.md) |
| **Direct Connect** | Dedicated connection to AWS | [Day 3](../resources/day-03-security-vpc.md) |
| **VPN** | Encrypted tunnel to AWS | [Day 3](../resources/day-03-security-vpc.md) |
| **Transit Gateway** | Hub for connecting VPCs | [Day 3](../resources/day-03-security-vpc.md) |
| **VPC Endpoints** | Private access to AWS services | [Day 3](../resources/day-03-security-vpc.md) |
| **Global Accelerator** | Improve global app performance | [Day 5](../resources/day-05-databases-serverless.md) |
| **ALB** | Application Load Balancer (Layer 7) | [Day 4](../resources/day-04-compute-storage.md) |
| **NLB** | Network Load Balancer (Layer 4) | [Day 4](../resources/day-04-compute-storage.md) |

---

## Security & Identity

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **IAM** | Users, roles, permissions | [Day 2](../resources/day-02-iam-security.md) |
| **IAM Identity Center** | Single sign-on for AWS accounts | [Day 2](../resources/day-02-iam-security.md), [Note](iam-identity-center.md) |
| **Cognito** | User auth for apps | [Day 2](../resources/day-02-iam-security.md), [Note](amazon-cognito.md) |
| **Organizations** | Manage multiple AWS accounts | [Day 2](../resources/day-02-iam-security.md), [Note](aws-organizations.md) |
| **WAF** | Web application firewall | [Day 3](../resources/day-03-security-vpc.md), [Note](aws-waf.md) |
| **Shield** | DDoS protection | [Day 3](../resources/day-03-security-vpc.md), [Note](aws-shield.md) |
| **GuardDuty** | Threat detection (ML-based) | [Day 3](../resources/day-03-security-vpc.md) |
| **Inspector** | Vulnerability scanning | [Day 3](../resources/day-03-security-vpc.md) |
| **Macie** | PII detection in S3 | [Day 3](../resources/day-03-security-vpc.md) |
| **KMS** | Encryption key management | [Day 3](../resources/day-03-security-vpc.md) |
| **CloudHSM** | Dedicated hardware encryption | [Day 3](../resources/day-03-security-vpc.md) |
| **Secrets Manager** | Store and rotate secrets | [Day 3](../resources/day-03-security-vpc.md) |
| **ACM** | SSL/TLS certificates | [Day 3](../resources/day-03-security-vpc.md) |
| **Security Hub** | Centralized security dashboard | [Day 3](../resources/day-03-security-vpc.md) |
| **Artifact** | AWS compliance reports | [Day 3](../resources/day-03-security-vpc.md) |

---

## Monitoring & Management

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **CloudWatch** | Monitoring, metrics, logs, alarms | [Day 6](../resources/day-06-integration-billing.md) |
| **CloudTrail** | API activity logging (who did what) | [Day 3](../resources/day-03-security-vpc.md) |
| **AWS Config** | Resource configuration tracking | [Day 3](../resources/day-03-security-vpc.md) |
| **Systems Manager** | Manage EC2 at scale | [Day 6](../resources/day-06-integration-billing.md) |
| **Trusted Advisor** | Best practice recommendations | [Day 6](../resources/day-06-integration-billing.md) |
| **CloudFormation** | Infrastructure as Code | [Day 6](../resources/day-06-integration-billing.md) |
| **Service Catalog** | Curated product portfolios | [Day 6](../resources/day-06-integration-billing.md) |

---

## Integration & Messaging

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **SQS** | Message queuing service | [Day 6](../resources/day-06-integration-billing.md) |
| **SNS** | Pub/sub notifications | [Day 6](../resources/day-06-integration-billing.md) |
| **EventBridge** | Event bus for app integration | [Day 6](../resources/day-06-integration-billing.md) |
| **Kinesis** | Real-time data streaming | [Day 6](../resources/day-06-integration-billing.md) |
| **Step Functions** | Orchestrate workflows | [Day 5](../resources/day-05-databases-serverless.md) |
| **AppSync** | Managed GraphQL APIs | [Day 5](../resources/day-05-databases-serverless.md) |

---

## Cost & Billing

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **Cost Explorer** | Visualize spending | [Day 6](../resources/day-06-integration-billing.md) |
| **AWS Budgets** | Set spending alerts | [Day 6](../resources/day-06-integration-billing.md) |
| **Pricing Calculator** | Estimate costs | [Day 6](../resources/day-06-integration-billing.md) |
| **Cost & Usage Report** | Detailed billing data | [Day 6](../resources/day-06-integration-billing.md) |

---

## Machine Learning

| Service | What It Does | Deep Dive |
|---------|--------------|-----------|
| **SageMaker** | Build and train ML models | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Rekognition** | Image and video analysis | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Comprehend** | NLP text analysis | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Polly** | Text to speech | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Lex** | Chatbots (Alexa tech) | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Transcribe** | Speech to text | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Translate** | Language translation | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Textract** | Extract text from documents | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Kendra** | Intelligent search | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Personalize** | Real-time recommendations | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Forecast** | Time-series predictions | [Day 7](../resources/day-07-ml-practice-exam.md) |
| **Amazon Q** | Gen AI assistant for business | [Day 7](../resources/day-07-ml-practice-exam.md) |

---

## Quick Lookup Tips

**"Which service for...?"**

| Need | Service |
|------|---------|
| Virtual servers | EC2 |
| Serverless code | Lambda |
| Object storage | S3 |
| Relational database | RDS |
| NoSQL database | DynamoDB |
| User authentication (apps) | Cognito |
| AWS user management | IAM |
| Block SQL injection | WAF |
| Block DDoS | Shield |
| Threat detection | GuardDuty |
| Vulnerability scan | Inspector |
| PII in S3 | Macie |
| API activity logs | CloudTrail |
| Resource compliance | AWS Config |
| Metrics & alarms | CloudWatch |
