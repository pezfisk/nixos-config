{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../generic.nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Enable NVIDIA drivers
  hardware.graphics = {
      enable = true;
    };

  services = {
    displayManager.gdm.enable = true;
    
    xserver.videoDrivers = ["nvidia"];

    flatpak = {
      packages = [
        "app.zen_browser.zen"
        "dev.vencord.Vesktop"
      ];
    };
  };

  hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  
  programs.hyprland.enable = true;

  programs.steam = {
      enable = true;
    };

  home-manager = {
      backupFileExtension = "bak";
      users.marc = import ./home.nix;
    };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3 --optimise";
    flake = "/home/marc/nixos";
  };

  networking.hostName = "nixos-desktop"; # Define your hostname.

  environment.systemPackages =  with pkgs; [
    # System packages 
    kitty
    wofi
    waybar
    eza
    zoxide
    fzf
    ripgrep
    bat
    dust
    duf
    tldr
    uutils-coreutils-noprefix

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
    nautilus
    godot
    handbrake
    onlyoffice-desktopeditors
    youtube-music
    yt-dlp
    phinger-cursors

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
    libebur128
    zam-plugins
    zita-convolver
    mda_lv2
    speexdsp
    soundtouch
    rnnoise
    deepfilternet
  ];
}
