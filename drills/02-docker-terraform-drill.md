# 02: Drill - Docker & Terraform

## ⚔️ The Challenge
**Scenario:** The Development team has provided a legacy `docker-compose.yml` for an Nginx web server. Your task is to decommission the Compose file and replace it with a robust Terraform configuration.

**Time Limit:** 15 Minutes

---

## 📋 Requirements

### 1. Provider
*   Use the community standard Docker provider.
*   Ensure it connects to the local Docker socket.

### 2. Infrastructure
*   **Image:** `nginx:latest`
    *   *Constraint:* Do NOT delete the image from disk when `terraform destroy` is run.
*   **Container:** Named `web_server_prod`
    *   *Port:* Map host `8080` to container `80`.
    *   *Volume:* Bind mount a local `index.html` (content: "Drill Success") to `/usr/share/nginx/html`.
    *   *Constraint:* You MUST use a dynamic path function for the volume (no hardcoded `/home/user` paths).

---

## 🔬 Pass/Fail Criteria

**1. Verification Command:**
```bash
curl localhost:8080
```
*   **Pass:** Output contains "Drill Success".
*   **Fail:** Connection refused or 404.

**2. Resilience Test:**
```bash
terraform destroy -auto-approve
docker images | grep nginx
```
*   **Pass:** The `nginx` image is STILL present in the list.
*   **Fail:** The image was deleted.

---

## 🆘 Stuck?
*   **Theory:** [Read the Encyclopedia](../../learn/terraform/02-docker-terraform.md)
*   **Steps:** [Review the Plan](../../journal/plans/02-docker-terraform.md)
