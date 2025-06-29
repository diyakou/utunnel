#!/bin/bash

# Determine CPU architecture
ARCH=$(uname -m)

# Map architecture to download URL
case $ARCH in
    "x86_64")
        URL="https://github.com/diyakou/utunnel/releases/download/release1/utunnelmanageramd64"
        ;;
    "aarch64" | "arm64")
        URL="https://github.com/diyakou/utunnel/releases/download/release1/utunnelmanagerarm64"
        ;;
    "i386" | "i686")
        URL="https://github.com/diyakou/utunnel/releases/download/release1/utunnelmanager386"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Download the appropriate version with progress indication
echo "Downloading utunnel_manager for $ARCH..."

if command -v wget >/dev/null 2>&1; then
    wget --progress=bar:force -O utunnel_manager "$URL"
elif command -v curl >/dev/null 2>&1; then
    curl -# -L -o utunnel_manager "$URL"
else
    echo "Neither wget nor curl is available for downloading."
    exit 1
fi

# Check if download was successful
if [ ! -f "utunnel_manager" ]; then
    echo "Failed to download utunnel_manager"
    exit 1
fi

# Make it executable
chmod +x utunnel_manager

# Run the manager
echo "Starting utunnel_manager..."
./utunnel_manager
