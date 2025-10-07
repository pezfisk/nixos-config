{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      ../../modules/auto-update.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
    	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };

  programs.steam.enable = true;

  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [
     {
       lockAll = true;

       settings = {
         "org/gnome/shell" = {
           disable-user-extensions = false;
           enabled-extensions = [
	     "caffeine@patapon.info"
	     "dash-to-dock@micxgx.gmail.com"
	     "blur-my-shell@aunetx"
	     "Vitals@CoreCoding.com"
	     "mediacontrols@cliffniff.github.com"
	     "compiz-windows-effect@hermes83.github.com"
	     "compiz-alike-magic-lamp-effect@hermes83.github.com"
	   ];

	   favorite-apps = [
	     "firefox.desktop"
	     "org.gnome.Nautilus.desktop"
	     "org.gnome.Console.desktop"
	     "org.gnome.Software.desktop"
	     "org.gnome.Settings.desktop"
	   ];
	 };

	 "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
	   friction = "2";
	   mass = "80";
	   speedup-factor-divider = "10";
	   spring-k = "6";
	 };
	 
	 "org/gnome/desktop/interface" = {
	   color-scheme = "prefer-dark";
	   font-antialiasing = "rgba";
	 };

	 "org/gnome/desktop/wm/preferences".button-layout = "icon,menu:minimize,maximize,close";
	 
	 ## Experimental features crashes VM, ill test on real hardware
	 #"org/gnome/mutter".experimental-features = [
	 #  "variable-refresh-rate"
	 #  "scale-monitor-framebuffer"
	 #  "xwayland-native-scaling"
	 #];

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

  #enviroment.gnome.excludePackages = (with pkgs; [
  #  atomix
  #  geary
  #  hitori
  #  iagno
  #]);

  environment.systemPackages =  with pkgs; [
    # Gnome Shell
    evince
    gnome-terminal
    gnome-extension-manager
        # Others
    eza
    zoxide
    dconf-editor
    gnome-tweaks
    handbrake
    mangohud
    thunderbird

    # uutils
    uutils-coreutils-noprefix
    uutils-diffutils
    uutils-findutils

  ] ++ (with gnomeExtensions; [
	caffeine
	dash-to-dock
	blur-my-shell
	vitals
	media-controls
	compiz-windows-effect
	compiz-alike-magic-lamp-effect
  ]);
}
