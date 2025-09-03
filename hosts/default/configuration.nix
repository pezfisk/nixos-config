{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  programs.hyprland.enable = true;

  programs.steam = {
      enable = true;
    }

  home-manager = {
      backupFileExtension = "bak";
      users.marc = import ./home.nix;
    };

  networking.hostName = "nixos-default"; # Define your hostname.

  environment.systemPackages =  with pkgs; [
    # System packages 
    kitty
    wofi
    waybar
    sbctl
    spicetify-cli

    # Hyprland stuff
    hyprland
    hyprlock
    hyprpaper
    hypridle
    hyprsunset
    hyprshot
    hyprpolkitagent

    # Other
    alvr
    gimp
    krita
    fastfetch
    rustup
    nautilus
    godot
    handbrake
    onlyoffice-desktopeditors
    ventoy
    youtube-music
    yt-dlp

    # Gaming
    wineWowPackages.stable
    winetricks
    gamescope
    gamescope
    bottles
    moonlight-qt
    sunshine
    prismlauncher
  ];
}
