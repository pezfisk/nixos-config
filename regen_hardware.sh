#!/usr/bin/env bash
set -e

CONFIG_DIR=~/nixos
HW_CONFIG_PATH="$CONFIG_DIR/modules/hardware-configuration.nix"

if [ -f "$HW_CONFIG_PATH" ]; then
  echo "hardware-configuration.nix already exists in modules/. No action needed."
else
  echo "hardware-configuration.nix not found. Regenerating..."

  # Create modules directory if it doesn't exist
  mkdir -p "$CONFIG_DIR/modules"

  # Generate hardware-configuration.nix to a temp location
  sudo nixos-generate-config --dir "$CONFIG_DIR/hwgen"

  # Move the generated file to modules/
  sudo mv "$CONFIG_DIR/hwgen/hardware-configuration.nix" "$HW_CONFIG_PATH"

  # Clean up the temporary directory
  sudo rm -rf "$CONFIG_DIR/hwgen"

  echo "hardware-configuration.nix regenerated and placed in modules/."
fi
