# 00: Docker Basics (Primer)

**Reading Time:** ~8 min  
**Summary:** The absolute minimum Docker knowledge needed before using Terraform with Docker.

---

## 🎯 What You Need to Know

This is a **crash course** for Terraform users who haven't used Docker before. We'll cover only what's essential for Day 02.

---

## 🧠 Core Concepts

### 1. What is Docker?

Docker lets you run applications in **isolated environments** called containers.

| Concept | Traditional | Docker |
|---------|-------------|--------|
| **Install App** | Install on your OS directly | Run in a container |
| **Dependencies** | Might conflict with other apps | Isolated per container |
| **Portability** | "Works on my machine" | Works everywhere |

> **Think of it like:** A shipping container. Everything the app needs is packed inside. It runs the same whether it's on your laptop, a server, or the cloud.

---

### 2. Images vs Containers

This is the **most important concept**.

| Term | What It Is | Analogy |
|------|-----------|---------|
| **Image** | A blueprint/template (read-only) | A recipe |
| **Container** | A running instance of an image | A cooked dish |

```
Image (nginx:latest)  →  Container (my_web_server)
      [Template]              [Running Instance]
```

- **One image** can create **many containers**
- Images are stored in **registries** (like Docker Hub)
- Containers are temporary; images are permanent

---

### 3. Docker Hub (The Registry)

[Docker Hub](https://hub.docker.com) is like an "App Store" for images.

| Image Name | What It Is |
|------------|-----------|
| `nginx` | Web server |
| `postgres` | Database |
| `redis` | Cache |
| `ubuntu` | Linux OS |

**Image naming:** `name:tag` (e.g., `nginx:latest`, `postgres:15-alpine`)

---

### 4. Ports (The Bridge)

Containers are **isolated** by default. To access a web server inside a container, you must **expose** its port.

```
Your Browser → localhost:8080 → Container's port 80 → Nginx
              [Host Port]      [Container Port]
```

| Term | Meaning |
|------|---------|
| **Host Port** | Port on YOUR machine (e.g., 8080) |
| **Container Port** | Port INSIDE the container (e.g., 80) |

**Mapping:** `host:container` → `8080:80`

> **Why different ports?** You might run multiple containers. Each needs a unique host port, but they can all use port 80 internally.

---

### 5. Volumes (Persistent Data)

Containers are **ephemeral**. When you delete a container, its data is lost.

**Volumes** let you save data outside the container:

| Type | What It Is | Use Case |
|------|-----------|----------|
| **Bind Mount** | Maps a folder on your machine | Development (live code reload) |
| **Named Volume** | Docker-managed storage | Databases (persist data) |

```
Host: /home/user/project/html  ←→  Container: /usr/share/nginx/html
         [Your Files]                    [Where Nginx Looks]
```

---

### 6. Networks (Container Communication)

Containers on the same **network** can talk to each other using their names.

```
┌─────────────────────────────────────┐
│           Docker Network            │
│  ┌─────────┐        ┌─────────┐    │
│  │  web    │───────→│  db     │    │
│  │ (nginx) │        │(postgres)│    │
│  └─────────┘        └─────────┘    │
│  Can reach db:5432                  │
└─────────────────────────────────────┘
```

---

## 🛠️ Essential Commands (5-Minute Practice)

Before using Terraform to manage Docker, try these commands manually:

### Pull an Image
```bash
docker pull nginx:latest
```

### Run a Container
```bash
docker run -d --name my_nginx -p 8080:80 nginx:latest
```
- `-d` = Run in background (detached)
- `--name` = Give it a name
- `-p 8080:80` = Map host port 8080 to container port 80

### Check Running Containers
```bash
docker ps
```

### Stop and Remove
```bash
docker stop my_nginx
docker rm my_nginx
```

### View Images
```bash
docker images
```

---

## 🔗 How This Connects to Terraform

| Docker CLI | Terraform Resource |
|------------|-------------------|
| `docker pull nginx` | `docker_image` |
| `docker run ...` | `docker_container` |
| `docker network create` | `docker_network` |
| `docker volume create` | `docker_volume` |

Terraform doesn't replace Docker—it **automates** Docker commands using code.

---

## ✅ Checklist: Ready for Day 02?

Before continuing to [Docker & Terraform](../terraform/02-docker-terraform.md), confirm you understand:

- [ ] **Image vs Container** (template vs running instance)
- [ ] **Docker Hub** (where images come from)
- [ ] **Ports** (host:container mapping)
- [ ] **Volumes** (persisting data outside containers)
- [ ] **Networks** (how containers talk to each other)

If you can explain these 5 concepts, you're ready!

---

## 📚 Want to Learn More?

This primer only covers what's needed for Terraform. For deeper Docker learning:

| Resource | Link |
|----------|------|
| Docker Official Docs | [docs.docker.com](https://docs.docker.com/get-started/) |
| Docker 101 Tutorial | [docker.com/101-tutorial](https://www.docker.com/101-tutorial/) |

---

## ➡️ What's Next?

**Continue to:** [02: Docker & Terraform](../terraform/02-docker-terraform.md)
- Now you'll manage Docker with Terraform!
