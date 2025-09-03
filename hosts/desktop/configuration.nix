{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ../../modules/hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Enable NVIDIA drivers
  hardware.graphics = {
      enable = true;
    };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
      modesettingg.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;
    }

  programs.hyprland.enable = true;

  programs.steam = {
      enable = true;
    };

  home-manager = {
      backupFileExtension = "bak";
      users.marc = import ./home.nix;
    };

  networking.hostName = "nixos-desktop"; # Define your hostname.

  environment.systemPackages =  with pkgs; [
    # System packages 
    kitty
    wofi
    waybar
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
    heroic

    # Easy Effects
    easyeffects
    lsp-plugins
    calf
    libebu128
    zam-plugins
    zita-convolver
    mdautils
    speedxdsp
    soundtouch
    rnnoise
    deepfilternet
  ];
}
