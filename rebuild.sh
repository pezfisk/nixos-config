#!/usr/bin/env bash

CONFIG_DIR=~/nixos
FLAKE_PATH="$CONFIG_DIR"

set -e

usage() {
  echo "Usage: $0 [--host hostname]"
  exit 1
}

HOST=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  --host)
    if [[ -n "$2" ]]; then
      HOST="$2"
      shift 2
    else
      usage
    fi
    ;;
  *)
    usage
    ;;
  esac
done

if git diff --quiet '*.nix'; then
  echo "No changes detected, exiting."
  popd
  exit 0
fi

git diff -U0 '*.nix'

if [[ -z "$HOST" ]]; then
  echo "Rebuilding and switching system with default host..."
  sudo nixos-rebuild switch --flake "$FLAKE_PATH"
else
  echo "Rebuilding and switching system for host: $HOST ..."
  sudo nixos-rebuild switch --flake "$FLAKE_PATH#$HOST"
fi

echo "Cleaning up system generations older than 3 days..."
sudo nix-collect-garbage --delete-older-than 3d

echo "Cleanup done."

current=$(nixos-rebuild list-generations | grep current)

git commit -am "$current"
