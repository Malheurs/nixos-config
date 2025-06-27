{
  description = "Cornelis's NixOS 2025";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  # Stable Nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";  # Unstable Nixpkgs

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";  # Chaotic-nix
    hyprland.url = "github:hyprwm/Hyprland"; # Hyprland
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";  # HyprPanel
    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # Zen Browser

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "path:.";
      flake = false;
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, chaotic, hyprpanel, hyprland, zen-browser, aagl, home-manager, dotfiles, ... }:
    let
      system = "x86_64-linux";

      commonConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = commonConfig;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = commonConfig;
      };
    in {
      nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          ./modules/cornelis.nix
          chaotic.nixosModules.default  # Chaotic-nix
          aagl.nixosModules.default  # AAGL
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.cornelis = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit pkgs-unstable;
            };
          }

          {
            nixpkgs = {
              config = commonConfig;
              overlays = [ hyprpanel.overlay ]; # HyprPanel
            };
          }
        ];
        specialArgs = {
          inherit pkgs-unstable;
          inherit inputs;
          inherit dotfiles;
        };
      };
    };
}
