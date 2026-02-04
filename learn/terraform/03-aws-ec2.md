# 03: AWS Basics (EC2, Storage & Security)

**Reading Time:** ~35 min  
**Goal:** Master the `aws_instance` resource, understanding not just how to launch a VM, but how to architect it for storage, security, and production operations.

---

## 🏗️ 1. Core Concepts: The Declarative VM

EC2 (Elastic Compute Cloud) is the fundamental building block of AWS. In Terraform, the `aws_instance` resource is deceptively simple to start, but complex to master.

### The "Golden Image" Problem
In the old days, you manually installed software on every server. In the Cloud/DevOps era, we use **AMIs (Amazon Machine Images)**.
*   **Immutable Infrastructure:** You don't patch live servers; you replace them with new AMIs.
*   **Terraform's Role:** Terraform doesn't build AMIs (Packer does that). Terraform *deploys* them.

### Data Sources: Finding the Right AMI
Hardcoding AMI IDs (`ami-012345678`) is an anti-pattern because IDs are region-specific and change frequently. Use a **Data Source** to ask AWS which one to use.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's Official Account ID

  filter {
    name   = "name"
    # Selects the latest Ubuntu 24.04 LTS (Noble Numbat)
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```
> **Pro Tip:** Always pin your filter to a specific version (e.g., `24.04`) to avoid accidental upgrades to major versions you haven't tested.

---

## 💾 2. Storage Strategy (EBS)

Newcomers often ignore the storage block, accepting the defaults. This is dangerous for production because the default root volume is often small, unencrypted, and deleted on termination.

### Root Block Device (The OS Drive)
This block configures the volume where the OS installs.
*   **Volume Type:** Always use `gp3` over `gp2`. It's up to 20% cheaper and allows independent scaling of IOPS and Throughput.
*   **Encryption:** **Mandatory** for compliance.
*   **Delete on Termination:** `true` for cattle (stateless web servers), `false` for pets (databases, which you shouldn't run on EC2 anyway).

```hcl
resource "aws_instance" "web" {
  # ... codes ...

  root_block_device {
    volume_size           = 20    # GB
    volume_type           = "gp3" # General Purpose SSD (Modern)
    encrypted             = true
    delete_on_termination = true  # Ephemeral instance
    
    # gp3 specific settings (Included in price usually)
    iops       = 3000
    throughput = 125
  }
}
```

### EBS Block Devices (Additional Data Drives)
For data that must survive the instance replacement, use separate EBS volumes or attachments.
```hcl
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 50
    volume_type = "gp3"
    encrypted   = true
    # This data dies with the instance if set to true!
    delete_on_termination = false 
  }
```

---

## 🌐 3. Networking Context

An EC2 instance must live in a Subnet. If you don't specify one, AWS puts it in the `default` VPC, which is fine for learning but bad for production.

### Public IP vs Elastic IP
*   `associate_public_ip_address = true`: Dynamic. Changes every time you stop/start the instance. Good for verifying auto-scaling groups.
*   `aws_eip`: Static. Fixed IP. Use this if you need to whitelist the IP in a firewall or bind it to a DNS record manually.

```hcl
# The "Pet" Instance Approach
resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
  domain   = "vpc"
  
  tags = {
    Name = "web-production-ip"
  }
}
```

---

## 🛡️ 4. Security: Identity and Firewall

Security is the #1 priority in the Cloud.

### IAM Instance Profiles (Identity)
**Never** store AWS Access Keys on your EC2 instance. Instead, create an IAM Role and attach it via an `iam_instance_profile`.
This allows the SDKs/CLI inside the code to magically authenticate without credentials.
*(Note: We will dive deeper into writing IAM policies in the Security Sprint, but know that this attribute exists).*

```hcl
  iam_instance_profile = "my-application-role" 
```

### Security Groups (The Firewall)
A Security Group is a stateful firewall applied to the network interface.
**Golden Rule:** `0.0.0.0/0` (The World) should only be allowed for public web ports (80/443). SSH (22) should be restricted to your specific IP or VPN.

```hcl
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and Limited SSH"
  # VPC ID is optional if using default VPC, but mandatory otherwise
  # vpc_id      = data.aws_vpc.default.id 

  # Inbound: HTTP (Public)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound: SSH (Restricted)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["1.2.3.4/32"] # YOUR HOME IP
  }

  # Outbound: Allow All
  # Terraform removes the default "Allow All" egress! You MUST add it back.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---

## 🔄 5. Lifecycle Management

How does Terraform handle updates?

### User Data (Bootstrapping)
`user_data` is a script that runs **once** on the very first boot.
*   **The Trap:** If you change the script, Terraform destroys the instance and creates a new one to run the new script. It does NOT re-run on existing servers.
*   **Best Practice:** distinct from `user_data_base64`. Use `templatefile()` to inject variables into your script.

### The `lifecycle` Block
This global block changes how Terraform manages the resource state.

```hcl
resource "aws_instance" "web" {
  # ... configuration ...

  lifecycle {
    # Perfect for Zero-Downtime replacements
    # Terraform creates the new server first, switches network/DNS, then kills the old one.
    create_before_destroy = true

    # Usage: If an external system (like an Autoscaler) manages tags, ignore them here.
    ignore_changes = [tags]
  }
}
```

---

## 🔧 6. Operational Excellence (Troubleshooting)

When you run `terraform apply` and the instance says "Running" but you can't connect, what do you do?

### SSH Connection Requirements
For SSH to work, **ALL** of these must be true:
1.  **Security Group:** Port 22 allowed from your IP.
2.  **NACL:** Subnet NACL allows ephemeral ports return traffic (default is yes).
3.  **Routing:** Subnet has a Route Table with a route to `0.0.0.0/0` via an Internet Gateway.
4.  **Key Pair:** You possess the private key (`.pem`) matching the public key on the server.
5.  **User:** You are using the right username (e.g., `ubuntu`) not `root`.

### Debugging Boot Scripts
If your `user_data` failed, you won't know until you log in.
check the log:
```bash
cat /var/log/cloud-init-output.log
```

### System Log
If the instance fails to boot entirely (kernel panic), use the AWS Console -> Actions -> Monitor and troubleshoot -> **Get System Log**. This shows the Linux boot console output.

---

## 📝 Summary Checklist
1.  **AMI:** Use `data` sources, never hardcode IDs.
2.  **Block Devices:** Always define `root_block_device` with `gp3` and `encrypted = true`.
3.  **Network:** Explicitly define Security Group egress rules.
4.  **Access:** Lock down SSH to specific IPs.
5.  **Lifecycle:** Use `create_before_destroy` for smoother updates.
