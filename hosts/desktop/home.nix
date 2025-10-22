{ config, pkgs, ... }:

{
    home.username = "marc";
    home.homeDirectory = "/home/marc";

    home.file.".config/hypr".source = ../../dotfiles/hypr;
    home.file.".config/waybar".source = ../../dotfiles/waybar;
    home.file.".config/wofi".source = ../../dotfiles/wofi;
    home.file.".config/fish".source = ../../dotfiles/fish;
    home.file.".config/kitty".source = ../../dotfiles/kitty;
    home.file.".config/easyeffects".source = ../../dotfiles/easyeffects;

    programs.direnv = {
	enable = true;	
	nix-direnv.enable = true;
	enableFishIntegration = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
	package = pkgs.gnome-themes-extra;
      };
    };

    home.pointerCursor = {
	name = "phinger-cursors-dark";
	package = pkgs.phinger-cursors;
	size = 32;
	gtk.enable = true;
    };

    home.stateVersion = "25.11";
}
