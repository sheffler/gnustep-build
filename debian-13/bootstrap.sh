#!/bin/sh

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

OS_ID="debian"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

REQUIREMENTS_FILE="${SCRIPT_DIR}/requirements/${OS_ID}.txt"

if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "No requirements file found for OS: $OS_ID"
    echo "Expected: $REQUIREMENTS_FILE"
    exit 1
fi

echo "Checking packages in: $REQUIREMENTS_FILE"

apt update
apt install dkms linux-headers-$(uname -r)


missing=""

case "$OS_ID" in

debian)

    while IFS= read -r pkg || [ -n "$pkg" ]; do
      pkg="${pkg%%#*}"           # strip comments after #
      pkg="$(echo "$pkg" | xargs)" # trim whitespace
      [ -z "$pkg" ] && continue
      if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
        missing="$missing $pkg"
      fi
    done < "$REQUIREMENTS_FILE"

    if [ -n "$missing" ]; then
      echo "Missing packages:$missing"
      echo "Updating apt cache..."
      apt-get update -y
      echo "Installing:$missing"
      DEBIAN_FRONTEND=noninteractive apt-get install -y $missing
    else
      echo "All required packages are already installed."
    fi
    ;;

*)
    echo "Unsupported OS for package checking: $OS_ID"
    exit 1
    ;;
esac
