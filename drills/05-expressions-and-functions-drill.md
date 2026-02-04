# 05: Expressions & Functions - Drill

> **Goal:** Practice locals, functions, and error handling without assistance.
> **Time Limit:** 30 minutes
> **No Peeking:** Complete without checking the Resource file.

---

## Drill 1: Locals (5 min)
Create locals that:
1. Combine `var.env` and `var.app` into a name prefix
2. Create a `common_tags` map with Environment, Project, and ManagedBy

**Success Criteria:**
- [ ] `local.name_prefix` outputs correctly
- [ ] `local.common_tags` contains all 3 keys

---

## Drill 2: String Functions (5 min)
Given `var.input = "  HELLO-world  "`:
1. Trim whitespace
2. Convert to lowercase
3. Replace `-` with `_`

**Success Criteria:**
- [ ] Output is `"hello_world"`

---

## Drill 3: List Functions (5 min)
Given `var.names = ["web", "api", "db", "api"]`:
1. Remove duplicates
2. Sort alphabetically
3. Output the length

**Success Criteria:**
- [ ] Distinct list is `["api", "db", "web"]`
- [ ] Length is `3`

---

## Drill 4: try() (5 min)
Create a local that safely accesses `var.config.database.port` with a fallback of `5432`.

Test with:
1. `var.config = {}`
2. `var.config = { database = { port = 3306 } }`

**Success Criteria:**
- [ ] Returns `5432` when config is empty
- [ ] Returns `3306` when config has port

---

## Drill 5: can() Validation (10 min)
Create a variable `cidr_block` that only accepts valid CIDR notation (e.g., `10.0.0.0/16`).

Hint: CIDR pattern is `X.X.X.X/N`

**Success Criteria:**
- [ ] `10.0.0.0/16` passes
- [ ] `192.168.1.0/24` passes
- [ ] `invalid` fails
- [ ] `10.0.0.0` fails (missing /N)

---

## 🏁 Completion
```bash
terraform destroy -auto-approve
```
