#!/usr/bin/env bash
# Default username (optional)
USER=""

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --user)
    USER="$2"
    shift
    ;;
  *)
    echo "Unknown parameter passed: $1"
    exit 1
    ;;
  esac
  shift
done

if [ -z "$USER" ]; then
  echo "Usage: $0 --user USERNAME"
  exit 1
fi

echo "Rebuilding machine for user: $USER"

find ~/nixos -type f -exec sed -i "s/marc/NEW_WORD/g" {} +

echo "Replaced default user with: ${USER}"

echo "Generating hardware-config..."

bash ./regen_hardware.sh

echo "Generated hardware-configuration"

echo "Rebuilding machine"

bash ./rebuild.sh

echo "Built new machine correctly"
