{
  description = "Cornelis's NixOS 2025";

  inputs = {
    # AAGL 
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    # Affinity
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # CachyOS Kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # Hyprland
    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "github:hyprwm/Hyprland/v0.51.1";
    # Home‑Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    
    
    # Nixpkgs – version stable (25.05) & unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    aagl,
    affinity-nix,
    nix-cachyos-kernel,
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
        aagl.nixosModules.default               # AAGL
        home-manager.nixosModules.home-manager  # Home‑Manager
        hyprland.nixosModules.default           # Hyprland
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
            overlays = [
              # Use the exact kernel versions as defined in this repo.
              # Guarantees you have binary cache.
              nix-cachyos-kernel.overlays.pinned
            ];
          };
        }
      ];

      specialArgs = {
        inherit pkgs-unstable;
        inherit inputs;
        inherit hyprland;
      };
    };
  };
}