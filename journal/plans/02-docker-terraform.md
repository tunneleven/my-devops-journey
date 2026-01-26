# 02: The Deep Dive - Docker Compose to Terraform
**Focus:** Translating a known configuration (Compose) to Infrastructure as Code.
**Time:** 3 hours
**Resource File:** [02: Docker & Terraform](../../learn/terraform/02-docker-terraform.md)

## 🎯 Objectives
1.  Manually create a `docker-compose.yml` (The "Before" state).
2.  Refactor that logic into Terraform resources (The "After" state).
3.  **Implement input variables to avoid hardcoding.**
4.  **Practice "Chaos Engineering" to understand State Drift.**

## 📚 Study (30 mins)

**Prerequisites:**
- Read [Docker Basics (Primer)](../../learn/docker/00-docker-basics.md) if new to Docker (~8 min)

**Read These Sections:**
1.  [The Terraform Docker Provider](../../learn/terraform/02-docker-terraform.md#1-the-terraform-docker-provider) (Why Kreuzwerker?)
2.  [Lifecycle Management](../../learn/terraform/02-docker-terraform.md#2-lifecycle-management-terraform-vs-compose) (State vs Runtime)
3.  [Resource Reference](../../learn/terraform/02-docker-terraform.md#-resource-reference-the-no-click-guide) (Network → Volume → Image → Container)
4.  [Mapping Compose to HCL](../../learn/terraform/02-docker-terraform.md#%EF%B8%8F-mapping-compose-to-hcl) (The Translation syntax)

## 💻 Lab: The Translation (2h 30 mins)
**Scenario:** You are migrating a legacy Docker setup to modern Terraform management.

### Step 1: The Legacy Way (Setup)
1.  Create a folder `nginx-lab` inside your day 02 folder.
2.  Create `index.html` with content: `<h1>Hello from Terraform Day 02</h1>`
3.  Create `docker-compose.yml`:
    ```yaml
    services:
      web:
        image: nginx:latest
        ports:
          - "8080:80"
        volumes:
          - ./index.html:/usr/share/nginx/html/index.html
    ```
4.  Run `docker-compose up -d`. Verify at `localhost:8080`.
5.  **Stop it:** `docker-compose down` (Crucial! Frees up the port).

### Step 2: The Terraform Way (Init & Variables)
1.  Create `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`.
2.  Define the `kreuzwerker/docker` provider in `providers.tf`.
3.  **Variables:** In `variables.tf`, define:
    *   `container_name` (default: "nginx-tf")
    *   `internal_port` (default: 80)
    *   `external_port` (default: 8080)
4.  **Provider Version:** Use `version = "~> 3.6"` (current as of Jan 2026).
5.  Run `terraform init`.

### Step 3: The Image Resource
1.  Define `resource "docker_image" "nginx"` in `main.tf`.
2.  Set `keep_locally = true`.
3.  Run `terraform apply`.
4.  **Verify:** `docker images` (Terraform pulled it).
5.  **Git:** `git commit -m "feat: add nginx docker image"`

### Step 4: The Container Resource (Dynamic)
1.  Define `resource "docker_container" "nginx"`.
2.  **Name:** Use `var.container_name`.
3.  **Ports:** Map `var.external_port` to `var.internal_port`.
4.  **Volumes:** Map `index.html`.
    *   *Challenge:* Use `abspath("${path.module}/index.html")` for the `host_path`.
5.  Run `terraform apply`.

### Phase 2: Chaos Engineering (Drift Detection)
**Goal:** Understand how Terraform reacts when reality changes without its permission.

1.  **The "Manual Sabotage":**
    *   Run `docker stop <container_name>`.
    *   Run `docker rm <container_name>`.
    *   Terraform *doesn't know yet*.
2.  **The "Reality Check":**
    *   Run `terraform plan`.
    *   *Observation:* Terraform says "Plan: 1 to add, 0 to change, 0 to destroy". Why? (It sees the missing resource).
3.  **The "Fix":**
    *   Run `terraform apply` to restore the state.
4.  **The "Configuration Drift":**
    *   Change `external_port` in `variables.tf` to `8081`.
    *   Run `terraform apply`.
    *   *Observation:* Does it update in place or destroy/create? (Docker containers are immutable!).

## 🔬 Verification
1.  **Curl Test:**
    ```bash
    curl localhost:8080 # or 8081 if you left it there
    # Output should include "Hello from Terraform Day 02"
    ```
2.  **State Check:**
    ```bash
    terraform show
    # Should list the container with current port config
    ```
3.  **The "Destroy Daily" Test:**
    ```bash
    terraform destroy -auto-approve
    curl localhost:8080 # Should FAIL
    terraform apply -auto-approve
    curl localhost:8080 # Should PASS
    ```

## 🧠 Knowledge Check
1.  Why do we need `abspath()` for the volume host path? [Answer](../../learn/terraform/02-docker-terraform.md#pathing-abspath)
2.  When we changed the port, why did Terraform destroy the container instead of updating it? [Answer](../../learn/terraform/02-docker-terraform.md#2-lifecycle-management-terraform-vs-compose)

---

## ➡️ What's Next?

**Day 03:** [AWS Basics (EC2 & Security Groups)](03-aws-ec2.md)
- AWS Provider configuration
- Data Sources (Dynamic AMI lookups)
- EC2 instances and Security Groups
