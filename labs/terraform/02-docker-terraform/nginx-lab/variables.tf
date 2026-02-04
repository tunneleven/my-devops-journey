variable "container_name" {
  type        = string
  description = "Name of the container"
  default     = "nginx-tf"
}

variable "internal_port" {
  type        = number
  description = "Internal port"
  default     = 80
}

variable "external_port" {
  type        = number
  description = "External port"
  default     = 8888
}

variable "postgres_user" {
  type        = string
  description = "PostgreSQL root user"
  default     = "postgres"
}

variable "postgres_password" {
  type        = string
  description = "PostgreSQL root password"
  sensitive   = true
}
