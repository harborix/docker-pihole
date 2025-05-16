# Use official multi-arch base image from Pi-hole
FROM pihole/pihole:latest

# Optional: Add custom dnsmasq config
COPY 01-custom.conf /etc/dnsmasq.d/

# Optional: Predefine setupVars.conf (e.g. for password, DNS upstreams, etc.)
COPY setupVars.conf /etc/pihole/setupVars.conf

# Optional: Add custom list domains or allowlists
COPY adlists.list /etc/pihole/adlists.list

# Optional: Adjust timezone or add ENV vars if needed
ENV TZ=Europe/Zurich

# Expose standard ports (DNS + web UI)
EXPOSE 53/tcp 53/udp 80/tcp 443/tcp

# CMD remains from base image
