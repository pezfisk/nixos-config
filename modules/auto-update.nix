{ config, pkgs, ...}; {
  
  system.autoUpgrade = {
    enable = true;
    flake = "github:pezfisk/nixos-config";

    flags = [
    	"--print-build-logs"
	"--no-write-lock-file"
    ];

    dates = "daily";
    randomizedDelaySec = "45mins";
    allowReboot = false;
  };


  nix.gc {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  enviroment.systemPackages = with pkgs; [
    libnotify
  ];
}
