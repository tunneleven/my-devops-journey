locals {
  # Standardize repo name
  repo_name = var.repo_config.name

  # Common labels/tags (add year automatically)
  common_topics = concat(var.topics, ["2026"])

  # Features summary
  enable_features = [
    for feature, enabled in var.enable_features :
    feature if enabled
  ]
}
