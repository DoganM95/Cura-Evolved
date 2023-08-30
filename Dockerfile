# Use base image
FROM jlesage/baseimage-gui:ubuntu-22.04-v4.4.2

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apt update && \
    apt install -y curl jq wget libgl1-mesa-glx nano libegl1-mesa openbox x11-utils

# Fetch API response and save it to a file
RUN curl -s "https://api.github.com/repos/Ultimaker/Cura/releases/latest" > latest_release.json

# Extract the download URL and save it to a file
RUN cat latest_release.json | jq -r '.assets[] | select(.name | test("-linux-modern.AppImage")) | .browser_download_url' > download_url.txt

# Download the AppImage
RUN wget $(cat download_url.txt)

# Create necessary directories
RUN mkdir -p /app/squashfs-root/ /root/.local /config

# Set permissions
RUN chmod -R 755 /app/squashfs-root/ && \
    chmod -R 777 /root/.local

# Extract the AppImage
RUN chmod +x *.AppImage && \
    ./*modern.AppImage --appimage-extract

# Create a non-root user
RUN useradd -ms /bin/bash non-root-user

# Change ownership for /config and /root/.local to non-root-user
RUN chown -R non-root-user:non-root-user /config && \
    chown -R non-root-user:non-root-user /root/.local

# Create and populate /etc/openbox/main-window-selection.xml
# Documentation: https://github.com/jlesage/docker-baseimage-gui#maximizing-only-the-main-window
RUN mkdir -p /etc/openbox/ && \
    touch /etc/openbox/main-window-selection.xml && \
    echo '<Title>UltiMaker Cura</Title>' >> /etc/openbox/main-window-selection.xml

# Copy startup script
COPY startapp.sh /startapp.sh