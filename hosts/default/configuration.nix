{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  programs.hyprland.enable = true;

  home-manager = {
      backupFileExtension = "bak";
      users.marc = import ./home.nix;
    };

  networking.hostName = "nixos-default"; # Define your hostname.

  environment.systemPackages =  with pkgs; [
    waybar
    wofi
    kitty
    eza
    zoxide
  ];
}
