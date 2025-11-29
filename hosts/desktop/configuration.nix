{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ../../generic.nix
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
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
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  home-manager = {
    backupFileExtension = "bak";
    users.marc = import ./home.nix;
  };

  programs = {
    virt-manager.enable = true;
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;

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

  system.activationScripts.btrfsTurning = ''
    # enable cow and compression on /home
    if [ -d /home ]; then
      ${pkgs.btrfs-progs}/bin/btrfs property set /home compression zstd || true
    fi
  '';

  networking = {
    hostName = "nixos-desktop";

    firewall = {
      allowedTCPPorts = [ 9757 ];
      allowedUDPPorts = [ 9757 ];
    };
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
    handbrake
    onlyoffice-desktopeditors
    youtube-music
    yt-dlp
    phinger-cursors
    mixxx
    thunderbird

    # Gaming
    wineWow64Packages.stagingFull
    winetricks
    gamescope
    gamescope
    bottles
    moonlight-qt
    sunshine
    prismlauncher
    heroic
    mangohud
    envision

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
