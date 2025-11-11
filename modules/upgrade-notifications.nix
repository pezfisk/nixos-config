{ config, lib, pkgs, ... }: {

  services.systembus-notify.enable = true;

  systemd.services.nixos-upgrade {
  postStart = ''
    $(pkgs.dbus}/bin/dbus-send --system / net.nuetzlich.SystemNotifications.Notify "string:System Updated" "string:NixOS has been succesfully upgraded. Please Reboot"
  '';

}:
}
