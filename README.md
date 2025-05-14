# docker-pihole

Custom Pi-hole container image based on `debian:bullseye-slim`, designed for multi-architecture builds (amd64 & arm64) and automated publishing via GitHub Actions.

This image is built independently from the official `pihole/pihole` image and provides a lightweight, flexible setup for self-hosted DNS-based ad blocking.

---

## 📦 Features

- Based on `debian:bullseye-slim`
- Multi-arch support: `linux/amd64`, `linux/arm64`
- Headless installation via Pi-hole's unattended setup
- Lightweight web GUI via `lighttpd`
- DNS service on port `53` (TCP & UDP), web GUI on port `80`
- Systemd-free, simple entrypoint

---

## 🧱 Build locally

```bash
docker buildx build   --platform linux/amd64,linux/arm64   -t harborix/pihole:latest   --push .
```

---

## 🚀 Run locally

```bash
docker run -d \
  --name pihole \
  -p 53:53/tcp -p 53:53/udp \
  -p 80:80 \
  harborix/pihole:latest
```

> You may want to bind mount `/etc/pihole` and `/etc/dnsmasq.d` to persist configuration and blocklists.

---

## 🛠 Configuration

Pi-hole can be configured after container start via the web interface or CLI:

```bash
docker exec -it pihole pihole -a -p       # Set admin password
docker exec -it pihole pihole -g          # Update gravity list
```

---

## 🔐 GitHub Actions

This repository includes a GitHub Actions workflow to automatically build and publish the image to Docker Hub on every `push` to the `main` branch.

Make sure to define these repository secrets:

- `DOCKERHUB_USER`
- `DOCKERHUB_TOKEN`

---

## 🧪 Development

Test changes locally:

```bash
docker build -t pihole-test .
docker run --rm -it -p 53:53/tcp -p 53:53/udp -p 80:80 pihole-test
```

---

## 📬 Maintainer

harborix  
<containers@harborix.net>
