#!/usr/bin/env bash
# Defaults
USER="marc"
HOST="default"

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --user)
    USER="$2"
    shift
    ;;
  --host)
    HOST="$2"
    shift
    ;;
  *)
    echo "Unknown parameter passed: $1"
    exit 1
    ;;
  esac
  shift
done

if [[ -z "$USER" ]]; then
  echo "Error: --user parameter is requied"
  echo "Usage: $0 --user USERNAME"
  exit 1
fi


if [[ -z "$HOST" ]]; then
  echo "Error: --host parameter is requied"
  echo "Usage: $0 --host USERNAME"
  exit 1
fi

echo "Rebuilding machine for user: $USER on $HOST"

find ~/nixos -type f -exec sed -i "s/marc/$USER/g" {} +

echo "Replaced default user with: ${USER}"

echo "Generating hardware-config..."

bash ./regen_hardware.sh

echo "Generated hardware-configuration"

echo "Rebuilding machine"

bash ./rebuild.sh --host $HOST

echo "Built new machine correctly"
