{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
#      pkgs = nixpkgs.legacyPackages.$(system);
    in {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/default/configuration.nix
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
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
