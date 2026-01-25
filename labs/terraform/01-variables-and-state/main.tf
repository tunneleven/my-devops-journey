terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "my_devops_journey" {
  name        = var.repo_config.name
  description = var.repo_config.description
  visibility  = var.repo_config.visibility

  has_issues   = var.enable_features.issues
  has_projects = var.enable_features.projects
  has_wiki     = var.enable_features.wiki

  topics = local.common_topics

  auto_init = false
}

resource "github_branch_default" "main" {
  repository = github_repository.my_devops_journey.name
  branch     = "main"
}
