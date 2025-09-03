#!/usr/bin/env bash
set -e

CONFIG_DIR=~/nixos
HW_CONFIG_PATH="$CONFIG_DIR/modules/hardware-configuration.nix"

echo "Generating new hardware config"

mkdir -p "$CONFIG_DIR/modules"

sudo nixos-generate-config --dir "$CONFIG_DIR/hwgen"

sudo mv "$CONFIG_DIR/hwgen/hardware-configuration.nix" "$HW_CONFIG_PATH"

sudo rm -rf "$CONFIG_DIR/hwgen"

echo "hardware-configuration.nix regenerated and placed in modules/."
