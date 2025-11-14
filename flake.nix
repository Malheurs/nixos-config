{
  description = "Cornelis's NixOS 2025";

  inputs = {
    # AAGL 
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    # Affinity
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    # Chaotic‑nix 
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    # Home‑Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Quickshell & Noctalia
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    
    
    # Nixpkgs – version stable (25.05) & unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    aagl,
    affinity-nix,
    chaotic,
    hyprland,
    home-manager,
    zen-browser,
    ...
  }: let
    system = "x86_64-linux";

    # Options communes appliquées à tous les imports de nixpkgs
    commonConfig = {
      allowUnfree = true;
    };

    # Paquets stables
    pkgs = import nixpkgs {
      inherit system;
      config = commonConfig;
    };

    # Paquets provenant du canal instable
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
        ./modules/noctalia.nix                  # Noctalia Shell
        chaotic.nixosModules.default            # Chaotic‑nix
        aagl.nixosModules.default               # AAGL
        home-manager.nixosModules.home-manager  # Home‑Manager
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
          };
        }
      ];

      specialArgs = {
        inherit pkgs-unstable;
        inherit inputs;
      };
    };
  };
}