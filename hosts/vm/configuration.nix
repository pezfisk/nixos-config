{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services.xserver.windowManager.i3 = {
    enable = true;
  };

  home-manager = {
    backupFileExtension = "bak";
    users.marc = import ./home.nix;
  };

  networking.hostName = "nixos-vm"; # Define your hostname.

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    # System packages 
    rofi
    polybar

    # Other stuff
    fastfetch
    rustup
  ];
}
