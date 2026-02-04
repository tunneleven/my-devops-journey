# Day 6: Dry Code - Count & For Each
**Date:** Tuesday, Jan 27
**Focus:** Stopping the "Copy-Paste" madness. Using loops to create multiple resources.

## 🎯 Objectives
1.  Use `count` to create identical resources (e.g., 2 EC2 instances).
2.  Use `for_each` to create similar resources with specific differences (e.g., 3 Users).
3.  Understand the "Index" problem with `count`.

## 📚 Study (45 mins)
*   **Concepts:**
    *   **Count:** Simple loop. Access with `count.index`.
    *   **For Each:** Map/Set loop. Access with `each.key` and `each.value`.
    *   **Splats:** `[*]` operator to get a list of IDs from a counted resource.
*   **Reading/Video:**
    *   *Zeal Vora Course:* Sections on `count` and `for_each`.
    *   *Docs:* [The `count` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/count)

## 💻 Lab: The Multiple Server Challenge (1h 15 mins)
**Scenario:** You need 3 web servers, not 1. And you need 3 AWS IAM Users for your team.

### Step 1: The Count Loop
*   Modify your `aws_instance` from Day 5.
*   Add `count = 3`.
*   Update the Name tag: `Name = "web-server-${count.index + 1}"`.
*   *Observation:* Apply and see 3 instances created.

### Step 2: The Splat Output
*   Update your `outputs.tf` to show ALL public IPs.
    *   *Old:* `value = aws_instance.web.public_ip` (Error!)
    *   *New:* `value = aws_instance.web[*].public_ip`
*   Apply and see the list.

### Step 3: The For_Each Loop (IAM Users)
*   Define a variable `user_names` (list of strings): `["alice", "bob", "charlie"]`.
*   Create a resource `aws_iam_user` `team`.
*   Add `for_each = toset(var.user_names)`.
*   Name: `name = each.value`.
*   *Observation:* Safer than count because removing "bob" won't shift "charlie's" index!

## 📝 Checklist
- [ ] Created multiple EC2 instances using `count`.
- [ ] Output a list of IPs using Splat `[*]`.
- [ ] Created IAM Users using `for_each`.
- [ ] Understood why `for_each` is generally better than `count` for non-identical lists.
