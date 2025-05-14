# docker-pihole/Dockerfile
FROM debian:bullseye-slim

LABEL maintainer="harborix <containers@harborix.net>"

ENV DEBIAN_FRONTEND=noninteractive \
    PIHOLE_VERSION=2024.05.0 \
    DNSMASQ_USER=pihole \
    PIHOLE_INSTALL_DIR=/opt/pihole

# Installiere Abhängigkeiten
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl bash git ca-certificates procps dnsutils iproute2 net-tools \
        lsb-release cron iputils-ping sudo gnupg2 \
        lighttpd php-common php-cgi php-sqlite3 php-intl php-xml && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Erstelle Benutzer und Verzeichnisse
RUN useradd -r -d /etc/pihole -s /usr/sbin/nologin ${DNSMASQ_USER} && \
    mkdir -p /etc/pihole /etc/dnsmasq.d

# Installiere Pi-hole
RUN curl -sSL https://install.pi-hole.net | bash /dev/stdin --unattended

# Kopiere das Entrypoint-Skript
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 53/tcp 53/udp 80/tcp

HEALTHCHECK --interval=30s --timeout=3s \
    CMD dig +short pi.hole @127.0.0.1 || exit 1

ENTRYPOINT ["/entrypoint.sh"]
