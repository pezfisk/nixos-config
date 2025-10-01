{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      ../../modules/auto-update.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [
    #./home.nix;
     {
       lockAll = true;

       settings = {
         "org/gnome/shell" = {
           disable-user-extensions = false;
           enabled-extensions = [
	     "caffeine@patapon.info"
	     "dash-to-dock@micxgx.gmail.com"
	     "blur-my-shell@aunetx"
	   ];
	 };
	 
	 "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        };

	#locks = [
	#  "/org/gnome/shell/enabled-extensions"
	#  "/org/gnome/shell/disabled-extensions"
	#];

	#home.packages = with pkgs.gnomeExtensions; [
	#  	caffeine
	#];
      }
  ];

  networking.hostName = "nixos-default"; # Define your hostname.

  environment.systemPackages =  with pkgs; [
    # Gnome Shell
    cheese
    evince
    gedit
    gnome-music
    gnome-photos
    gnome-terminal
    totem

    # Gnome Extensions
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell

    # Others
    eza
    zoxide
    dconf-editor
  ];
}
