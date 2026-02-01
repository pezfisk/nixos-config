{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ../../generic.nix
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # systemd.services.nvidia-container-toolkit-cdi-generator = {
  #   environment.LD_LIBRARY_PATH = "${lib.getLib config.hardware.nvidia.package}/lib";
  # };
  environment.etc."cdi/nvidia-container-toolkit.json".source = "/run/cdi/nvidia-container-toolkit.json";

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = true;
    };

    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    bluetooth.enable = true;
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };

  services = {
    displayManager.gdm.enable = true;

    xserver.videoDrivers = [ "nvidia" ];

    ratbagd.enable = true;

    flatpak.packages = [
      "app.zen_browser.zen"
      "dev.vencord.Vesktop"
      "org.gimp.GIMP"
    ];

    wivrn = {
      enable = true;
      openFirewall = true;

      autoStart = true;
      defaultRuntime = true;

      package = (pkgs.wivrn.override { cudaSupport = true; });
    };

    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    docker.daemon.settings = {
      runtimes = {
        nvidia = {
          path = "$(pkgs.nvidia-container-toolkit)/bin/nvidia-container-runtime";
        };
      };
    };
  };

  home-manager = {
    backupFileExtension = "bak";
    users.marc = import ./home.nix;
  };

  programs = {
    virt-manager.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    coolercontrol.enable = true;

    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        steamArgs = [
          "-tenfoot"
        ];
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    nh = {
      enable = true;
      flake = "/home/marc/nixos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 3 --optimise";
      };
    };
  };

  qt = {
    enable = true;
    style = "adwaita";
  };

  networking = {
    hostName = "nixos-desktop";

    firewall = {
      allowedTCPPorts = [ 9757 ];
      allowedUDPPorts = [ 9757 ];
    };
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  environment.systemPackages = with pkgs; [
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
    overskride
    e2fsprogs
    btrfs-progs
    uutils-coreutils-noprefix
    distrobox
    docker-compose
    nvidia-docker

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
    krita
    fastfetch
    nautilus
    godot
    onlyoffice-desktopeditors
    youtube-music
    yt-dlp
    phinger-cursors
    mixxx
    thunderbird
    qbittorrent
    android-tools
    obs-studio
    gparted

    # Gaming
    wineWow64Packages.stagingFull
    winetricks
    protonplus
    bottles
    moonlight-qt
    sunshine
    prismlauncher
    heroic
    mangohud
    envision
    ryubing
    lsfg-vk
    lsfg-vk-ui
    zulu25

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
