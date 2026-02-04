# 03: Drill - AWS EC2 & Access

## ⚔️ The Challenge
**Scenario:** A developer needs a generic Ubuntu development server. They must be able to log in via SSH using a provided public key.

**Time Limit:** 20 Minutes

---

## 📋 Requirements

### 1. Access (Key Pair)
*   **Resource:** `aws_key_pair`.
*   **Source:** Read a local public key file (e.g., `~/.ssh/id_ed25519.pub` or similar).

### 2. Networking (Security Group)
*   **Ingress:** Allow SSH (22) from ANYWHERE.
*   **Egress:** Allow ALL outbound (Crucial for updates).

### 3. Compute (Instance)
*   **AMI:** Use `data` block to find the latest Ubuntu Jammy (22.04).
*   **Config:** Attach the Key Pair and the Security Group.
*   **User Data:** None required for this drill (Focus is on Access).

### 4. Usability (Outputs)
*   **Output:** The full SSH connection string (e.g., `ssh -i ... ubuntu@...`).

---

## 🔬 Pass/Fail Criteria

**1. Connectivity Check:**
```bash
# Run the outputted command
$(terraform output -raw ssh_connection)
```
*   **Pass:** You log in successfully (or get "Permission denied (publickey)" which means the server accepted the connection but maybe your local key path is wrong - that counts as *access* working).
*   **Fail:** "Connection Refused" or "Operation Timed Out" (Security Group issue).

**2. Destroy Check:**
```bash
terraform destroy
```
*   **Pass:** The EC2 is gone, but your local ssh public key file remains.

---

## 🆘 Stuck?
*   **Theory:** [Read the Encyclopedia](../../learn/terraform/03-aws-ec2.md)
*   **Steps:** [Review the Plan](../../journal/plans/03-aws-ec2.md)
