{ config, modulesPath, pkgs, lib, ... }: {
  
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../hosts/default/configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
}
