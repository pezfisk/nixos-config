{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-flatpak
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      #      pkgs = nixpkgs.legacyPackages.$(system);
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/default/configuration.nix
            ./modules/auto-update.nix
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            ./hosts/desktop/configuration.nix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/vm/configuration.nix
          ];
        };

        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
            ./hosts/iso/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./hosts/default/home.nix
          ];
        };

        vm = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./hosts/vm/home.nix
          ];
        };
      };
    };
}
