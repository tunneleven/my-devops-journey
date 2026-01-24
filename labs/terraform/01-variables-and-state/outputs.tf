output "repository_url" {
  value       = github_repository.my_devops_journey.html_url
  description = "URL of the repository"
}

output "git_clone_url" {
  value       = github_repository.my_devops_journey.ssh_clone_url
  description = "SSH URL of the repository"
}

output "repo_full_name" {
  value       = github_repository.my_devops_journey.full_name
  description = "Full name of the repository"
}

output "repo_visibility" {
  value       = github_repository.my_devops_journey.visibility
  description = "Visibility of the repository"
}

output "enable_features" {
  value       = local.enable_features
  description = "Features enabled for the repository"
}

output "push_instructions" {
  value       = <<-EOT
    To push to this repository, use the following command:
    cd <your_project_directory>
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin ${github_repository.my_devops_journey.ssh_clone_url}
    git push -u origin main
    EOT
  description = "Instructions for pushing to the repository"
}
