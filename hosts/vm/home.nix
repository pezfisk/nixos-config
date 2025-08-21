{ config, pkgs, ... }:

{
    home.username = "marc";
    home.homeDirectory = "/home/marc";

    home.file.".config/i3".source = ../../dotfiles/i3;
    home.file.".config/polybar".source = ../../dotfiles/polybar;
    home.file.".config/fish".source = ../../dotfiles/fish;
    home.file.".config/xfce4/xfconf/xfce-perchannel-xml".source = ../../dotfiles/xfce4/xfconf/xfce-perchannel-xml;

    home.stateVersion = "25.05";
}
