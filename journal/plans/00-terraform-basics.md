# 00: Terraform Basics - Installation & First Steps
**Focus:** Getting started with Terraform - installation, basic commands, and providers.

**Time:** 2 hours total

---

## 🎯 Objectives
1. Install Terraform on your system
2. Understand basic Terraform workflow (init, plan, apply, destroy)
3. Configure your first providers (Docker, AWS, GitHub)
4. Create your first resources

---

## 📚 Study (30 mins)

### What is Terraform?
Read: [00-terraform-basics.md > What is Terraform?](../../learn/terraform/00-terraform-basics.md#-what-is-terraform)

**Key Points to Understand:**
- Declarative Infrastructure as Code (IaC)
- Provider-based architecture
- State-driven management

---

## 🛠️ Installation (20 mins)

**Follow the Resource Guide:** [00-terraform-basics.md > Installation](../../learn/terraform/00-terraform-basics.md#️-installation)

**Choose your method:**
- **Ubuntu/Debian:** Use package manager (recommended)
- **macOS:** Use Homebrew
- **Other Linux:** See resource file for your distro

**Verify:**
```bash
terraform version
# Expected: Terraform v1.7.0 (or later)
```

**Optional:** Enable tab completion (see resource file)

---

## 💻 Lab 1: Docker Provider (40 mins)

### Step 1: Setup Project
```bash
mkdir ~/terraform-basics
cd ~/terraform-basics
```

### Step 2: Create Docker Resource
Create `docker.tf`:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "my-nginx-container"
  image = docker_image.nginx.image_id
  
  ports {
    internal = 80
    external = 8080
  }
}
```

### Step 3: Run the Workflow
```bash
# 1. Initialize (downloads Docker provider)
terraform init

# 2. Preview changes
terraform plan

# 3. Create resources
terraform apply
# Type 'yes' when prompted

# 4. Test
curl localhost:8080
# You should see Nginx welcome page

# 5. Inspect state
terraform show

# 6. Cleanup
terraform destroy
# Type 'yes' when prompted
```

**Reference Commands:** See [CLI Commands section](../../learn/terraform/00-terraform-basics.md#-terraform-cli-commands-detailed) for full command options.

---

## 💻 Lab 2: AWS Provider (30 mins - Optional)

**Prerequisites:** AWS account + `aws configure` completed

Create `aws.tf`:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-basics"
  }
}
```

**Run:**
```bash
terraform init
terraform plan
terraform apply

# Important: Destroy to avoid charges!
terraform destroy
```

---

## 💻 Lab 3: GitHub Provider (30 mins - Optional)

**Prerequisites:** GitHub personal access token

Create `github.tf`:

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "example" {
  name        = "terraform-test-repo"
  description = "Created with Terraform"
  visibility  = "public"
}
```

---

## 📝 Completion Checklist
- [ ] Terraform installed and verified
- [ ] Completed Docker provider lab
- [ ] Successfully ran: init → plan → apply → destroy
- [ ] Understand what `terraform.tfstate` is (don't edit it!)
- [ ] (Optional) Tried AWS provider
- [ ] (Optional) Tried GitHub provider

---

## 🧠 Knowledge Check

After completing this day, you should be able to answer:

1. What are the 4 core Terraform commands?
2. What does `terraform init` do?
3. Why should you run `terraform plan` before `apply`?
4. What is a provider?
5. What file tracks deployed resources?

**Answers:** Check the [Resource File](../../learn/terraform/00-terraform-basics.md)

---

## 💡 Key Takeaways
1. **Always `terraform init`** after adding providers
2. **Always `terraform plan`** before apply
3. **Always `terraform destroy`** when testing to avoid costs
4. **Never edit `terraform.tfstate`** manually
5. **Providers are plugins** that connect Terraform to platforms

---

## 🎯 Next Day
[01: Variables & State](01-variables-and-state.md) - Learn to parameterize your code and manage state properly.
