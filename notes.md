## Image bauen (nur amd64)

``bash
docker build -t harborix/pihole:latest .
```

Wenn du bereits buildx korrekt konfiguriert hast (für Multi-Arch):
```bash
docker buildx build \
  --platform linux/amd64 \
  -t harborix/pihole:latest \
  --load \
  .
```

## Testlauf (lokal)
Einfachste Variante:
``` bash
docker run -d \
  --name pihole-test \
  -p 53:53/tcp -p 53:53/udp \
  -p 80:80 -p 443:443 \
  -e TZ=Europe/Zurich \
  -e WEBPASSWORD=changeme \
  harborix/pihole:latest
```

Dann im Browser öffnen:
```bash
http://localhost/admin
```

Benutzer: kein Loginname
Passwort: changeme
