{ config, pkgs, ... }:

{

  users.users.marc = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
  };

}
