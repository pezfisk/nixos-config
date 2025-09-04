# Personal NixOS configuration files.

## How to install on a new machine;

Once you have installed NixOS, you have to get `git` as its not installed by default.
To do so, run the following command:
```bash
nix-shell -p git
```

Then clone this repository:
```bash
git clone https://github.com/pezfisk/nixos-config nixos
```
Make sure you clone into "~/nixos".

Once cloned, cd into `nixos` and run the following command which will prompt you with the installation instructions:
```bash
./build_new_machine.sh
```
