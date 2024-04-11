# Use base image
FROM jlesage/baseimage-gui:ubuntu-22.04-v4.4.2

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apt update --fix-missing && \
    apt install -y curl jq wget libgl1-mesa-glx nano libegl1-mesa openbox dbus-x11

# Generate and install favicon
# RUN install_app_icon.sh "https://github.com/DoganM95/Cura-Evolved/blob/master/assets/Icon5.png"
COPY ./assets/favicon_package_v0.16/* /opt/noVNC/app/images/icons

# Logic to get the latest release on build; Disabled for github action compatibility

# # Fetch API response and save it to a file
# RUN touch latest_release.json
# RUN curl -s "https://api.github.com/repos/Ultimaker/Cura/releases/latest" > latest_release.json

# # Extract the download URL and save it to a file
# RUN touch download_url.txt
# RUN cat latest_release.json | jq -r '.assets[] | select(.name | test("-linux-X64.AppImage")) | .browser_download_url' | grep '\.AppImage$' > download_url.txt

# # Extract the current cura version into env var
# RUN touch current_cura_version.txt
# RUN cat latest_release.json | jq -r '.tag_name' > current_cura_version.txt

# Download the AppImage
RUN wget $(cat download_url.txt)

# Create necessary directories
RUN mkdir -p /app/squashfs-root/ /root/.local /config

# Set permissions
RUN chmod -R 755 /app/squashfs-root/ && \
    chmod -R 777 /root/.local

# Extract the AppImage
RUN chmod +x *.AppImage && \
    ./*linux-X64.AppImage --appimage-extract

# Create a non-root user
RUN useradd -ms /bin/bash non-root-user

# Change ownership for /config and /root/.local to non-root-user
RUN chown -R non-root-user:non-root-user /config && \
    chown -R non-root-user:non-root-user /root/.local

# Set environment variables
ENV APP_NAME="Cura"

# Create and populate /etc/openbox/main-window-selection.xml
# Documentation: https://github.com/jlesage/docker-baseimage-gui#maximizing-only-the-main-window
RUN mkdir -p /etc/openbox/ && \
    touch /etc/openbox/main-window-selection.xml && \
    echo '<Title>UltiMaker Cura</Title>' >> /etc/openbox/main-window-selection.xml

RUN mkdir -p /app/input 
RUN mkdir -p /app/output
RUN chmod -R 777 /app

# Copy startup script
COPY ./startapp.sh /startapp.sh

# Fix script permissions
RUN chmod -R 777 /startapp.sh

# Replace CRLF with LF in shartscript
RUN sed -i 's/\r$//' /startapp.sh
