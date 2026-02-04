# 01: Drill - Variables & State

## ⚔️ The Challenge
**Scenario:** A client needs a private GitHub repository for a "Secret Project". They have strict requirements for how variables are handled, avoiding hardcoded values entirely.

**Time Limit:** 10 Minutes

---

## 📋 Requirements

### 1. Variables (No Hardcoding)
*   **Variable:** `repo_name` (Type: String, Description: "Name of the secret project").
*   **Variable:** `visibility` (Type: String, Default: "private").
    *   *Constraint:* Must validate that the value is either "public" or "private".
*   **Variable:** `github_token` (Type: String).
    *   *Constraint:* Must be marked as sensitive.

### 2. Infrastructure
*   **Resource:** `github_repository`
*   **Attributes:** Use your variables to set the name, visibility, and `auto_init = true`.

### 3. Output
*   **Output:** `clone_url`
    *   *Value:* The SSH clone URL of the created repo.
    *   *Constraint:* Must include a description.

---

## 🔬 Pass/Fail Criteria

**1. Validation Check:**
```bash
# Attempt to run with invalid visibility
terraform apply -var="visibility=hidden"
```
*   **Pass:** Terraform fails with your custom error message (Validation worked).
*   **Fail:** Terraform applies or gives a generic schema error.

**2. Sensitive Check:**
```bash
terraform plan
```
*   **Pass:** The `github_token` variable is shown as `(sensitive value)`.
*   **Fail:** The plaintext token is visible in the plan output.

---

## 🆘 Stuck?
*   **Theory:** [Read the Encyclopedia](../../learn/terraform/01-variables-and-state.md)
*   **Steps:** [Review the Plan](../../journal/plans/01-variables-and-state.md)
