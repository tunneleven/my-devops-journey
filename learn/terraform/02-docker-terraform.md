# 02: Docker & Terraform

**Reading Time:** ~18 min  
**Summary:** Docker provider setup, resource reference (network, volume, image, container), port mapping, volumes, networks, healthchecks, and lifecycle management vs Docker Compose.

## 📋 Prerequisites

> **New to Docker?** Read [Docker Basics (Primer)](../docker/00-docker-basics.md) first (~8 min).

This resource assumes you understand:
- Images vs Containers
- Ports (host:container mapping)
- Volumes (bind mounts)
- Docker networks

---

## 🧠 Core Concepts

### 1. The Terraform Docker Provider
Terraform manages Docker containers by communicating with the Docker Daemon API, acting as a client similar to the `docker` CLI.

*   **Provider:** `kreuzwerker/docker`
    *   *Source:* [registry.terraform.io/providers/kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
    *   *Why not HashiCorp?* The official HashiCorp provider is deprecated. The Kreuzwerker provider is the maintained community standard.
*   **Communication:** Defaults to the local Unix socket (`unix:///var/run/docker.sock`) on Linux/macOS, or a named pipe on Windows.

#### Provider Configuration
Define this in your `providers.tf`:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"  # Updated: Jan 2026
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```

### 2. Lifecycle Management (Terraform vs Compose)
Understanding the difference in philosophy is critical:

| Feature | Docker Compose | Terraform |
| :--- | :--- | :--- |
| **State** | Runtime State (checks daemon) | **State File** (`terraform.tfstate`) |
| **Drift** | Ignored unless recreated | **Detected** (`terraform plan`) |
| **Goal** | Run Services | Manage Infrastructure Lifecycle |

> **⚠️ The State Trap:** If you delete a container manually (`docker rm`), Terraform knows it's missing because of the State file and will recreate it. If you create a container manually, Terraform *doesn't know it exists* unless you import it.

---

## 📚 Resource Reference (The "No-Click" Guide)

> **Order:** Resources are listed in dependency order (create networks/volumes first, then images, then containers).

---

### 1. `docker_network`
Creates a custom bridge network for container communication.

```hcl
resource "docker_network" "app_net" {
  name   = "my_app_network"
  driver = "bridge"
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | **Required** | The name of the network. |
| `driver` | string | `"bridge"` | The networking driver (`bridge`, `overlay`, `host`, `none`). |
| `attachable` | bool | `false` | If `true`, standalone containers can attach to this network. |
| `internal` | bool | `false` | If `true`, the network has no external connectivity. |

---

### 2. `docker_volume`
Creates a managed Docker volume for persistent data.

```hcl
resource "docker_volume" "db_data" {
  name = "postgres_data"
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | **Required** | The name of the volume. |
| `driver` | string | `"local"` | Volume driver to use. |

---

### 3. `docker_image`
Pulls an image from a registry (like Docker Hub).

```hcl
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | **Required** | The name of the image (e.g., `nginx:latest`, `postgres:15-alpine`). |
| `keep_locally` | bool | `false` | If `true`, the image is **not** deleted on `terraform destroy`. Recommended `true`. |
| `build` | block | `null` | Build an image from a Dockerfile. |
| `force_remove` | bool | `false` | Force removal even if containers are using it (dangerous). |
| `pull_triggers` | list | `null` | List of values that, when changed, will trigger a re-pull. |

---

### 4. `docker_container`
Runs a container from an image.

```hcl
resource "docker_container" "web" {
  name  = "web_server"
  image = docker_image.nginx.image_id
  
  # See blocks below for ports, volumes, networks, healthcheck
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | **Required** | The name of the container. |
| `image` | string | **Required** | The ID of the image. Use `docker_image.name.image_id`. |
| `env` | list | `[]` | Environment variables: `["KEY=VALUE", "DB_HOST=localhost"]`. |
| `command` | list | `null` | Override the default command: `["nginx", "-g", "daemon off;"]`. |
| `entrypoint` | list | `null` | Override the entrypoint. |
| `working_dir` | string | `null` | Working directory inside the container. |
| `user` | string | `null` | User to run as (e.g., `"1000:1000"`). |
| `restart` | string | `"no"` | Restart policy: `"no"`, `"on-failure"`, `"always"`, `"unless-stopped"`. |
| `must_run` | bool | `true` | If `true`, Terraform will fail if the container stops. |
| `privileged` | bool | `false` | Gives extended privileges (security risk). |

---

#### Block: `ports` (Port Mapping)
Exposes container ports to the host machine.

```hcl
resource "docker_container" "web" {
  name  = "web_server"
  image = docker_image.nginx.image_id
  
  ports {
    internal = 80   # Container port
    external = 8080 # Host port
    protocol = "tcp"
  }
  
  # Expose multiple ports
  ports {
    internal = 443
    external = 8443
  }
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `internal` | number | **Required** | Port inside the container. |
| `external` | number | `null` | Port on the host. If omitted, Docker assigns random port. |
| `ip` | string | `"0.0.0.0"` | IP address to bind to. Use `"127.0.0.1"` for localhost only. |
| `protocol` | string | `"tcp"` | Protocol: `"tcp"` or `"udp"`. |

---

#### Block: `volumes` (Mounts)
Mount host paths or Docker volumes into the container.

```hcl
resource "docker_container" "web" {
  name  = "web_server"
  image = docker_image.nginx.image_id
  
  # Bind Mount (host folder → container)
  volumes {
    host_path      = abspath("${path.module}/html")
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }
  
  # Named Volume (Docker-managed)
  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `container_path` | string | **Required** | Path inside the container. |
| `host_path` | string | - | **Bind Mount:** Absolute path on host (use `abspath()`). |
| `volume_name` | string | - | **Named Volume:** Name of `docker_volume` resource. |
| `read_only` | bool | `false` | If `true`, mount is read-only. |

> ⚠️ Use **either** `host_path` (bind mount) **or** `volume_name` (named volume), not both.

---

#### Block: `networks_advanced`
Attach container to custom networks with advanced options.

```hcl
resource "docker_container" "web" {
  name  = "web_server"
  image = docker_image.nginx.image_id
  
  networks_advanced {
    name         = docker_network.app_net.name
    aliases      = ["web", "frontend"]  # DNS names within network
    ipv4_address = "172.20.0.10"        # Optional static IP
  }
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | **Required** | Name of the `docker_network` to attach to. |
| `aliases` | list | `[]` | DNS aliases for this container within the network. |
| `ipv4_address` | string | `null` | Static IPv4 address. |
| `ipv6_address` | string | `null` | Static IPv6 address. |

> **Tip:** Use `aliases` so other containers can reach this one via `curl http://web:80`.

---

#### Block: `healthcheck`
Configure container health monitoring.

```hcl
resource "docker_container" "web" {
  name  = "web_server"
  image = docker_image.nginx.image_id
  
  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost/health"]
    interval     = "30s"
    timeout      = "10s"
    start_period = "5s"
    retries      = 3
  }
}
```

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `test` | list | **Required** | Command to run. Use `["CMD", "..."]` or `["NONE"]` to disable. |
| `interval` | string | `"30s"` | Time between checks. |
| `timeout` | string | `"30s"` | Maximum time for a check to complete. |
| `start_period` | string | `"0s"` | Grace period before checks start counting. |
| `retries` | number | `3` | Consecutive failures before marking unhealthy. |

> **Pro Tip:** Always add healthchecks for production containers. Terraform will wait for a healthy state.

---

## 🛠️ Mapping Compose to HCL

| Docker Compose Concept | Terraform Resource | Key Arguments |
| :--- | :--- | :--- |
| `image: nginx:latest` | `resource "docker_image"` | `name`, `keep_locally` |
| `service: web` | `resource "docker_container"` | `image`, `name`, `ports` |
| `volumes:` (Bind Mount) | `volumes` block | `host_path`, `container_path` |
| `volumes:` (Named Vol) | `volumes` block | `volume_name`, `container_path` |
| `environment:` | `env` set | List of strings `["KEY=VALUE"]` |
| `networks:` | `resource "docker_network"` | `networks_advanced` block in container |

---

## 🛡️ Security & Best Practices

### The Docker Socket
Mounting the Docker socket (`/var/run/docker.sock`) into a container gives that container **root access** to the host.
*   **Terraform usage:** Terraform needs access to this socket locally.
*   **Fix:** Ensure the user running Terraform is in the `docker` group: `sudo usermod -aG docker $USER`.

### Pathing (`abspath`)
Docker requires **absolute paths** for bind mounts. Terraform works with relative paths. You must bridge this gap.

*   ❌ `host_path = "./html"` (Will fail or mount the wrong thing)
*   ✅ `host_path = abspath("${path.module}/html")` (Converts to `/home/user/project/html`)

---

## 🐳 Multi-Container Example

A realistic setup with Nginx and Redis:

```hcl
# Network for container communication
resource "docker_network" "app_net" {
  name = "my_app_network"
}

# Redis cache
resource "docker_image" "redis" {
  name         = "redis:alpine"
  keep_locally = true
}

resource "docker_container" "cache" {
  image = docker_image.redis.image_id
  name  = "redis_cache"
  
  networks_advanced {
    name    = docker_network.app_net.name
    aliases = ["cache"]  # DNS name within network
  }
}

# Nginx web server
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web" {
  image = docker_image.nginx.image_id
  name  = "web_server"
  
  ports {
    internal = 80
    external = 8080
  }
  
  networks_advanced {
    name = docker_network.app_net.name
  }
  
  # Web can reach Redis via: cache:6379
}
```

> **Key Insight:** Containers in the same `docker_network` can communicate using their `name` or `aliases` as DNS hostnames.

---

## 💡 Pro Tips
1.  **Commit Often:** When migrating, commit after getting the *Image* pulling, then again after the *Container* starts, then after *Ports* work.
2.  **Destroy Test:** The ultimate test of Infrastructure as Code is `terraform destroy` followed by `terraform apply`. If it comes back up perfectly, your code is solid.
3.  **Network First:** Always create the `docker_network` before containers that use it. Terraform handles this automatically via implicit dependencies.

---

## ➡️ What's Next?

**Day 03:** [AWS Basics (EC2 & Security Groups)](03-aws-ec2.md)
- AWS Provider configuration
- Data Sources (Dynamic AMI lookups)
- EC2 instances and Security Groups
- SSH access and User Data bootstrapping
