#!/usr/bin/env bash
set -e

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Podman is installed
if ! command -v podman &> /dev/null; then
    echo -e "${RED}Error: Podman is not installed. Please install it to continue.${NC}" >&2
    exit 1
fi

# Start Podman machine if not running
if ! podman machine list --format "{{.Running}}" | grep -q "true"; then
    echo -e "${YELLOW}Starting Podman machine...${NC}"
    podman machine start
fi

# Build the container image
echo -e "${YELLOW}Building container image with Podman...${NC}"
podman manifest create "cloud-tools-container"
podman build . \
  --manifest "cloud-tools-container" \
  --platform "linux/amd64,linux/arm64" \
  --tag "cloud-tools-container:latest"

echo -e "${GREEN}Build script completed successfully.${NC}"
