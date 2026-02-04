
resource "docker_network" "app_net" {
  name = "app_net"
}

resource "docker_volume" "db_data" {
  name = "postgres_data"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_image" "postgres" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_image" "redis" {
  name         = "redis:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.name

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${path.module}/index.html")
    container_path = "/usr/share/nginx/html/index.html"
  }

  networks_advanced {
    name    = docker_network.app_net.name
    aliases = [var.container_name]
  }

  healthcheck {
    test     = ["CMD-SHELL", "curl -f http://localhost/health"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }
}

resource "docker_container" "postgres" {
  name  = "postgresDB"
  image = docker_image.postgres.name

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=postgres",
  ]

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql"
  }

  networks_advanced {
    name    = docker_network.app_net.name
    aliases = ["postgresDB"]
  }
}

resource "docker_container" "redis" {
  name  = "redisCache"
  image = docker_image.redis.name

  networks_advanced {
    name    = docker_network.app_net.name
    aliases = ["redisCache"]
  }
}

