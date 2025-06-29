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

# Download the appropriate version with progress
echo "Downloading utunnel_manager for $ARCH..."

if command -v wget >/dev/null 2>&1; then
    wget --progress=bar:force -O utunnel_manager "$URL"
elif command -v curl >/dev/null 2>&1; then
    curl -# -L -o utunnel_manager "$URL"
else
    echo "Error: Neither wget nor curl is installed."
    exit 1
fi

# Verify the binary was downloaded
if [ ! -f "utunnel_manager" ]; then
    echo "Failed to download utunnel_manager"
    exit 1
fi

# Make it executable
chmod +x utunnel_manager

# Print banner and start the manager
clear
cat <<'EOF'
      +@@@@@.  :@@%  :@@  :@@:  @@ +@@  %@% +@@   @@#    #@%    #@%   %@#

       **** ushkayanet utunnel Reverse tunnel management console  Edited by Kyan(Diyakou)  ****

EOF

echo "Starting utunnel_manager..."
./utunnel_manager
