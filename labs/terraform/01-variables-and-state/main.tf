terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "~>6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "my_devops_journey" {
    name = local.repo_name
    description = var.repo_config.description
    visibility = var.repo_config.visibility

    # Features
    has_issues = var.enable_features.issues
    has_projects = var.enable_features.projects
    has_wiki = var.enable_features.wiki

    # Best Practices
    auto_init = false
    allow_merge_commit = true
    allow_squash_merge = true
    allow_rebase_merge = true
    topics = local.common_topics    
}

resource "github_branch_default" "main" {
    repository = github_repository.my_devops_journey.name
    branch = "main"
}