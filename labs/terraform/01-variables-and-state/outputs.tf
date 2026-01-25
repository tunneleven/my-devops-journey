output "repo_full_name" {
  value       = github_repository.my_devops_journey.full_name
  description = "The full name of the repository"
}

output "repository_url" {
  value       = github_repository.my_devops_journey.html_url
  description = "The URL of the repository"
}

output "git_clone_url" {
  value       = github_repository.my_devops_journey.git_clone_url
  description = "The URL to clone the repository"
}

output "repository_visibility" {
  value       = github_repository.my_devops_journey.visibility
  description = "The visibility of the repository"
}

output "all_tags" {
  value       = local.all_tags
  description = "All tags for the repository"
}

output "push_instructions" {
  value       = <<EOT
    git remote add origin ${github_repository.my_devops_journey.html_url}
    git branch -M main
    git add .
    git commit -m "Initial commit"
    git push -u origin main
    EOT
  description = "Instructions to push to the repository"
}
