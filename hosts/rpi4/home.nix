{ config, pkgs, ... }:

{
  home.username = "inverse";
  home.homeDirectory = "/home/inverse";

  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fd
  ];

  programs.git = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch flake /etc/nixos#rpi4";
      update = "cd /etc/nixos && nix flake update && rebuild";
      edit-secrets = "sops /etc/nixos/secrets/rpi4.yaml";
    };
  };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
