# 04: Looping & Logic - Drill

> **Goal:** Practice creating multiple resources using count, for_each, and splat.
> **Time Limit:** 30 minutes
> **No Peeking:** Complete without checking the Resource file.

---

## Drill 1: Count Basics (5 min)
Create 5 `null_resource` instances using `count`. Output all their IDs using a splat expression.

**Success Criteria:**
- [ ] 5 resources created
- [ ] Output shows list of 5 IDs

---

## Drill 2: For_Each with Set (5 min)
Create `null_resource` instances for each environment: `["dev", "staging", "prod"]`

Use `for_each`, not `count`.

**Success Criteria:**
- [ ] 3 resources created with keys "dev", "staging", "prod"
- [ ] Can reference by name: `null_resource.env["dev"]`

---

## Drill 3: For_Each with Map (10 min)
Given this variable:
```hcl
variable "databases" {
  default = {
    users    = { port = 5432, size = "small" }
    products = { port = 5433, size = "large" }
    logs     = { port = 5434, size = "xlarge" }
  }
}
```

Create `null_resource` instances that store the name, port, and size in triggers.
Output all ports as a list.

**Success Criteria:**
- [ ] 3 resources created
- [ ] Output shows `["5432", "5433", "5434"]`

---

## Drill 4: Conditional Creation (5 min)
Create a resource that only exists when `var.debug_mode = true`.

Test with:
```bash
terraform apply -var="debug_mode=true"
terraform apply -var="debug_mode=false"
```

**Success Criteria:**
- [ ] Resource exists when debug_mode=true
- [ ] Resource destroyed when debug_mode=false

---

## Drill 5: The Index Shift Test (5 min)
1. Create a `for_each` resource with `["web", "api", "db"]`
2. Apply
3. Remove "api" from the list
4. Run `terraform plan`

**Question:** Which resource(s) will be destroyed? Which will be untouched?

---

## 🏁 Completion
```bash
terraform destroy -auto-approve
```
