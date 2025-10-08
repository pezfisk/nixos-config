# Personal NixOS configuration files.

## How to install on a new machine;

### Manuel installation

After partitioning the disk, you can clone the repository:
```bash
git clone https://github.com/pezfisk/nixos-config nixos
```

Then cd into `nixos` and run the following command:
```bash
./regen_hardware.sh
```

To create a custom user, edit modules/users.nix by replacing `marc` with your own username.

Then run nixos-install with the flake:
```bash
nixos-install --flake path/to/flake.nix#default
```

After completion, run `nixos-enter --root /mnt -c 'passwd {username-you-set'` to set your password.

After that, the flake will be installed and the system can be rebooted.

### Graphical installation

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
./regen_hardware.sh
```

After its finished, run the following command to install the flake:
```bash
./rebuild.sh --host default
```
