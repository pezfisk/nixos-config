{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      ../../modules/auto-update.nix
      inputs.home-manager.nixosModules.home-manager
    ];

#  services.xserver = {
#    enable = true;
#    displayManager.gdm.enable = true;
#  };

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
