{ inputs, pkgs, lib, config, pkgs-unstable, ... }:

{
  # Remplacer le paquet hyprland dans pkgs par celui d'unstable via pkgs-unstable
  nixpkgs.overlays = [(final: prev: { hyprland = pkgs-unstable.hyprland; xdg-desktop-portal-hyprland = pkgs-unstable.xdg-desktop-portal-hyprland; })];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  environment.sessionVariables = {
    # Necessary for e.g. `Hyprland` config `exec` commands to use `gsettings`,
    # e.g. to bind keys for switching light/dark mode.
    XDG_DATA_DIRS =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      [ datadir ];
  };
  
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    # Hyprland required
    ags # EWW-inspired widget system as a GJS library
    brightnessctl # Read and control device brightness
    cliphist # Wayland clipboard manager
    eww # ElKowars wacky widgets
    hyprpaper # Blazing fast wayland wallpaper utility
    hyprpanel # Hyprland's panel
    hyprpicker # Wayland color picker
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qt5.qtwayland # A cross-platform application framework for C++
    libsForQt5.qtstyleplugin-kvantum # Qt5 theme engine plus a config tool and extra themes
    networkmanagerapplet # Network manager applet
    playerctl # CLI for controlling media players that implement MPRIS
    pywal # Generate and change color theme on the fly
    pyprland # Hyprland plugin system
    qt6.qtwayland # A cross-platform application framework for C++
    rofi-wayland # Windows switcher, DMenu
    slurp # Select region for screenshot
    swww # Animated wallpaper daemon
    wlogout # Logout menu
    wl-clipboard # CLI copy/paste
    wf-recorder # Screen recording
    wlsunset # Day/night gamma adjustments for Wayland
    wtype # Xdotool 
    wlrctl # CLI for misc extensions
    wlr-randr # Screen utility for setting main screen
  ];
}
