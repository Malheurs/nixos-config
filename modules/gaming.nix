{ pkgs, config, inputs, lib, ... }:

{
  # Enable Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # Enable gamescope
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs; [ proton-ge-bin];
  };
  
  # Path for Proton
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/user/.steam/root/compatibilitytools.d";
  };
  
  # Enable Gamemode & Gamescope
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # Genshin Impact
  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
  
  imports = [ inputs.aagl-gtk-on-nix.nixosModules.default];

  programs.anime-game-launcher.enable = true;
  aagl.enableNixpkgsReleaseBranchCheck = false;

  # Fix for using Xinput mode on 8bitdo Ultimate C controller
  # Activer le module kernel xpad pour le support Xbox
  boot.kernelModules = [ "xpad" ];
  
  # Règles udev pour la manette 8BitDo Ultimate C
  services.udev.extraRules = ''
    # 8BitDo Ultimate Controller - Mode Xinput (idProduct 3106)
    SUBSYSTEM=="usb", ATTR{idVendor}=="2dc8", ATTR{idProduct}=="3106", ATTR{manufacturer}=="8BitDo", MODE="0664", GROUP="input", TAG+="uaccess"
    
    # 8BitDo Ultimate Controller - Mode Switch/Android (idProduct 3016) 
    SUBSYSTEM=="usb", ATTR{idVendor}=="2dc8", ATTR{idProduct}=="3016", ATTR{manufacturer}=="8BitDo", MODE="0664", GROUP="input", TAG+="uaccess"
    
    # Permissions pour tous les périphériques 8BitDo
    SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", MODE="0664", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2dc8", MODE="0664", GROUP="input", TAG+="uaccess"
  '';
}
