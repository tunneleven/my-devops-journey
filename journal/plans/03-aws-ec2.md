# 03: AWS Basics - EC2, Storage & Security
**Focus:** Deploying a secure, production-ready Web Server with encrypted storage, proper firewalling, and lifecycle management.
**Time:** 2 hours
**Resource File:** [03: AWS Basics](../../learn/terraform/03-aws-ec2.md)

## 🎯 Objectives
1.  **Modern AMIs:** Use `data` sources to find the latest Ubuntu AMI dynamically.
2.  **Secure Storage:** Configure `gp3` root volumes with encryption enabled.
3.  **Network Security:** Implement strict Security Group rules (including explicit Egress).
4.  **Lifecycle:** Use `create_before_destroy` to handle zero-downtime replacements.
5.  **Bootstrapping:** Install Apache via `user_data` and verify with SSH.

## 🎒 Prerequisites (Do this first!)
1.  **AWS Account:** You must have an active AWS account.
2.  **CLI Config:** Run `aws configure` in your terminal. Default region: `us-east-1`.
3.  **SSH Key:** `ssh-keygen` must be available.

## 📚 Study (30 mins)
**Read These Sections:**
1.  [Core Concepts (Data Sources)](../../learn/terraform/03-aws-ec2.md#1-core-concepts-the-declarative-vm)
2.  [Storage Strategy (EBS)](../../learn/terraform/03-aws-ec2.md#2-storage-strategy-ebs)
3.  [Security: Identity & Firewall](../../learn/terraform/03-aws-ec2.md#4-security-identity-and-firewall)
4.  [Lifecycle Management](../../learn/terraform/03-aws-ec2.md#5-lifecycle-management)

## 💻 Lab: The Production Web Server (1h 30 mins)
**Scenario:** You are deploying a web server for a client who demands security compliance (Encryption) and high availability updates.

### Step 1: The Keys
1.  Open your terminal in `journal/plans`.
2.  Generate a key: `ssh-keygen -t ed25519 -f my-tf-key` (Empty passphrase).

### Step 2: The Terraform Setup
1.  Create `main.tf`, `provider.tf` (Ensure `region = "us-east-1"`).
2.  Define `aws_key_pair` "deployer" using `file("my-tf-key.pub")`.
3.  **AMI Lookup:** Define `data "aws_ami" "ubuntu"` (Filter for 24.04 LTS).
4.  **Security Group:** Define `aws_security_group` "web_sg".
    *   **Ingress:** Port 80 (HTTP) from `0.0.0.0/0`.
    *   **Ingress:** Port 22 (SSH) from `YOUR_IP/32` (Google "what is my ip"). *Only use 0.0.0.0/0 if absolutely necessary.*
    *   **Egress:** `0.0.0.0/0` (Allow All). *Critical: Terraform removes the default Allow All if you don't add this!*

### Step 3: The Hardened Instance
1.  Define `aws_instance` "web".
2.  Use `data.aws_ami.ubuntu.id` and `t2.micro`.
3.  **Storage Configuration (Best Practice):**
    *   Define `root_block_device`.
    *   Set `volume_type = "gp3"`.
    *   Set `encrypted = true`.
    *   Set `delete_on_termination = true`.
4.  **Lifecycle Management:**
    *   Add `lifecycle { create_before_destroy = true }`.
5.  **Wiring:** Attach the SG and Key Pair.
6.  **Bootstrapping:** Add `user_data` to install Apache.

### Step 4: Verification
1.  Run `terraform apply`.
2.  **Verify Encryption:** Go to AWS Console -> EC2 -> Volumes. Check that the volume is "Encrypted".
3.  **Verify Web:** `curl <public_ip>` to see your page.
4.  **Verify SSH:** `ssh -i my-tf-key ubuntu@<public_ip>`.

## 🧠 Knowledge Check
1.  Why do we prefer `gp3` over `gp2` for general purpose workloads?
2.  What happens to your instance if you forget the `egress` rule in the Security Group?
3.  Why is `data.aws_ami` safer than hardcoding an AMI ID like `ami-12345`?
