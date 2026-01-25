locals {
  repo_name = var.repo_config.name

  common_topics = try(concat(var.topics, ["2026"]))

  all_tags = merge(var.extra_tags, {
    "Year" = "2026"
  })
}