terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.10.2"
    }
  }
}

provider "github" {
    token = var.github_token
}

resource "github_repository" "example" {
  name        = "Terraform-Learn-Repo"
  description = "A repository created with Terraform"

  visibility = "private"
}