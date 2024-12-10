# Use base image
FROM jlesage/baseimage-gui:ubuntu-22.04-v4.4.2

# Set working directory
WORKDIR /app

# Accept the Cura version as a build argument
ARG CURA_VERSION
ENV CURA_VERSION=${CURA_VERSION}

# Check initial size
RUN echo "Initial size:" && du -sh /app

# Install necessary packages and clean up apt cache to reduce image size
RUN apt update --fix-missing && \
    apt install -y \
    curl \
    dbus-x11 \
    jq \
    libegl1-mesa \
    libgl1-mesa-glx \
    nano \
    openbox \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Check size after installing packages
RUN echo "Size after package installation:" && du -sh /app

# Copy favicon assets
COPY ./assets/favicon_package_v0.16/* /opt/noVNC/app/images/icons

# Check size after copying assets
RUN echo "Size after copying favicon assets:" && du -sh /app

# Fetch the AppImage URL and download the file
RUN curl -s "https://api.github.com/repos/Ultimaker/Cura/releases" | \
    jq -r --arg VERSION "$CURA_VERSION" '.[] | select(.tag_name == $VERSION) | .assets[] | select(.name | test("X64\\.AppImage$")) | .browser_download_url' > /app/download_url && \
    wget -i /app/download_url

# Check size after downloading AppImage
RUN echo "Size after downloading AppImage:" && du -sh /app

# Create necessary directories
RUN mkdir -p /app/squashfs-root/ /root/.local /config

# Extract the AppImage
RUN chmod +x *.AppImage && \
    ./*linux-X64.AppImage --appimage-extract

# Check size after extracting AppImage
RUN echo "Size after extracting AppImage:" && du -sh /app


### GRAVEYARD

# Generate and install favicon
# RUN install_app_icon.sh "https://github.com/DoganM95/Cura-Evolved/blob/master/assets/Icon5.png"
# COPY ./assets/favicon_package_v0.16/* /opt/noVNC/app/images/icons

# Logic to get the latest release on build; Disabled for github action compatibility

# # Fetch API response and save it to a file
# RUN touch latest_release.json
# RUN curl -s "https://api.github.com/repos/Ultimaker/Cura/releases/latest" > latest_release.json

# # Extract the download URL and save it to a file
# RUN touch download_url
# RUN cat latest_release.json | jq -r '.assets[] | select(.name | test("-linux-X64.AppImage")) | .browser_download_url' | grep '\.AppImage$' > download_url

# # Extract the current cura version into env var
# RUN touch current_cura_version.txt
# RUN cat latest_release.json | jq -r '.tag_name' > current_cura_version.txt

# # Copy url file
# COPY ./download_url /app/download_url

# # Turn CRLF file into LF
# RUN sed -i 's/\r$//' download_url

# # Download the AppImage
# RUN wget $(cat download_url)

# # Set permissions
# RUN chmod -R 755 /app/squashfs-root/ && \
#     chmod -R 777 /root/.local
