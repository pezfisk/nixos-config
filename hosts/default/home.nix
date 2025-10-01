{ config, pkgs, ... }:

{
    #home.username = "marc";
    #home.homeDirectory = "/home/marc";

    #home.file.".config/hypr".source = ../../dotfiles/hypr;
    #home.file.".config/waybar".source = ../../dotfiles/waybar;
    #home.file.".config/wofi".source = ../../dotfiles/wofi;
    home.file.".config/fish".source = ../../dotfiles/fish;

    home.stateVersion = "25.05";
}
