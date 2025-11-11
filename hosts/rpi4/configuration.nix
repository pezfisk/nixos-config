{ config, pkgs, lib, ... }:

{
  # create hardware-configuration.nix
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  sops = {
    defaultSopsFile = ../../secrets/rasp.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      mail-password = {
        owner = "virtualMail";
        group = "virtualMail";
        mode = "0440";
      };
      acme-email = {
        owner = "root";
        mode = "0440";
      };
      ssh-authrized-key = {
        owner = "inverse";
        mode = "0400";
      };
    };
  };

  networking = {
    hostName = "rpi4";
    domain = "invrs.dev";

    useDHCP = false;
    interfaces.eth0.useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        25
        465
        587
        993
        143
      ];
    };
  };

  # Locale
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  users.users.inverse = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];

    openssh.authorizedKeys.keys = [
      (builtins.readFile config.sops.secrets.ssh-authorized-key.path)
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.nginx = {
    enable = true;
    enableReload = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."invrs.dev" = {
      serverAliases = [ "www.invrs.dev" ];
      forceSSL = true;
      enableACME = true;
      root = "/var/www/invrs.dev";

      locations."/" = {
        index = "index.html";
        tryFiles = "$uri $uri/ =404";
      };
    };

    virtualHosts."mail.invrs.dev" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        return = "301 https://invrs.dev";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = builtins.readFile config.sops.secrets.acme-email.path;
  };

  mailserver = {
    enable = true;
    fqdn = "mail.invrs.dev";
    domains = [ "invrs.dev" ];

    loginAccounts = {
      "me@invrs.dev" = {
        hashedPasswordFile = config.sops.secrets.mail-password.path;
        aliases = [
          "admin@invrs.dev"
          "postmaster@invrs.dev"
        ];
      };
    };

    certificateScheme = "acme-nginx";
    enableImap = true;
    enableImapSsl = true;
    enableSubmission = true;
    enableSubmissionSsl = true;
    enableManageSieve = true;
    virusScanning = false;
    localDnsResolver = false;
  };

  # Website dir
  systemd.tmpfiles.rules = [
    "d /var/www/invrs.dev 0755 nginx nginx -"
  ];

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    wget
    sops
    age
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  system.stateVersion = "25.11";
}
