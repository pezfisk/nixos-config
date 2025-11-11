{ config, pkgs, ... }:

{
    home.username = "marc";
    home.homeDirectory = "/home/marc";

    #home.file.".config/hypr".source = ../../dotfiles/hypr;
    #home.file.".config/waybar".source = ../../dotfiles/waybar;
    #home.file.".config/wofi".source = ../../dotfiles/wofi;
    home.file.".config/fish".source = ../../dotfiles/fish;
    home.file.".config/easyeffects".source = ../../dotfiles/easyeffects;
    home.file.".config/helix".source = ../../dotfiles/helix;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "25.11";
}
