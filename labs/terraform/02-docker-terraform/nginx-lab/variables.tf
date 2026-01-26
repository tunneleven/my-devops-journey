variable "container_name" {
    type = string
    description = "Name of the container"
    default = "nginx-tf"
}

variable "internal_port" {
    type = number
    description = "Internal port"
    default = 80
}

variable "external_port" {
    type = number
    description = "External port"
    default = 8080
}