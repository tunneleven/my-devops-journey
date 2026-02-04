# 📘 Day 8 Resources: Introduction to Modules

## 🧠 Core Concepts

### 1. The Module Structure
A module is just a folder with `.tf` files.
*   **Root Module:** The directory where you run `terraform apply`.
*   **Child Module:** A directory called *by* the Root Module.

### 2. The Black Box Model
Think of a module as a "Black Box".
*   **Inputs:** Defined by `variable` blocks in the child.
*   **Outputs:** Defined by `output` blocks in the child.
*   **Internals:** Resources inside the child are invisible to the parent unless exposed via Outputs.

### 3. Calling a Module
```hcl
module "network" {
  source = "./modules/vpc"  # Path is mandatory
  
  # Passing Variables
  cidr_block = "10.0.0.0/16"
  env        = "prod"
}
```

### 4. Reading Module Outputs
To use a value *from* a module, you reference it like this:
`module.<MODULE_NAME>.<OUTPUT_NAME>`
*   *Example:* `subnet_id = module.network.public_subnet_id`

---

## 🛠️ The Standard File Structure
```
root/
├── main.tf           # Calls modules
├── variables.tf      # Global variables
├── outputs.tf        # Final details (e.g. Load Balancer DNS)
└── modules/
    └── web_server/
        ├── main.tf       # EC2, SG
        ├── variables.tf  # AMI, Type
        └── outputs.tf    # Instance ID, Public IP
```

---

## 📖 Helpful Documentation
*   [Modules Overview](https://developer.hashicorp.com/terraform/language/modules)
*   [Module Sources (Local paths, Git, Registry)](https://developer.hashicorp.com/terraform/language/modules/sources)

---

## 💡 Pro Tips
*   **Init is King:** When you add a `module` block or change the `source` path, you **MUST** run `terraform init` again.
*   **Versioning:** In the real world, you link to Git tags (`?ref=v1.0`) to prevent your production code from breaking when someone updates the module.
