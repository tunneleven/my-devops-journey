variable "github_token" {
    type = string
    description = "GitHub token for authentication"
    sensitive = true
}

variable "repo_config" {
    type = object({
        name = string
        description = string
        visibility = string
    })
    description = "Repository configuration"

    validation {
        condition = can(regex("^[a-zA-Z0-9_-]{1,100}$", var.repo_config.name))
        error_message = "Repository name must be between 1 and 100 characters and can only contain letters, numbers, underscores, and hyphens."
    }
    validation {
        condition = contains(["public", "private"], var.repo_config.visibility)
        error_message = "Repository visibility must be either 'public' or 'private'."
    }
}

variable "topics" {
    type = list(string)
    description = "List of topics for the repository"
    default = ["DevOps", "Learning"]
}

variable "enable_features" {
    type = object({
        issues = bool
        wiki = bool
        projects = bool
    })
    description = "Features to enable for the repository"
    default = {
        issues = true
        wiki = true
        projects = true
    }
}