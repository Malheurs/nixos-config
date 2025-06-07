{ inputs, pkgs, lib, config, pkgs-unstable, ... }:

{
  # Remplacer le paquet hyprland dans pkgs par celui d'unstable via pkgs-unstable
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = pkgs-unstable.hyprland;
      xdg-desktop-portal-hyprland = pkgs-unstable.xdg-desktop-portal-hyprland;
    })
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_RENDERER = "vulkan";
    
    # Nouvelles optimisations NVIDIA/Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_DRM_NO_ATOMIC = "1";  # Si problèmes de stabilité
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";  # Fallback sur X11 si nécessaire
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    
    # Performance
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    
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
    dunst # Notification daemon
    eww # ElKowars wacky widgets
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprpaper # Blazing fast wayland wallpaper utility
    hyprpanel # Hyprland's panel ### Bind to flake ###
    hyprpicker # Wayland color picker
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qt5.qtwayland # A cross-platform application framework for C++
    libsForQt5.qtstyleplugin-kvantum # Qt5 theme engine plus a config tool and extra themes
    networkmanagerapplet # Network manager applet
    playerctl # CLI for controlling media players that implement MPRIS
    pywal # Generate and change color theme on the fly
    pyprland # Hyprland plugin system
    qt6.qtwayland # A cross-platform application framework for C+
    rofi-wayland # Windows switcher, DMenu
    slurp # Select region for screenshot
    swww # Animated wallpaper daemon
    wlogout # Logout menu
    wl-clipboard # CLI copy/paste
    wf-recorder # Screen recording
    wlsunset # Day/night gamma adjustments for Wayland
    wtype # Xdotool 
    wlrctl # CLI for misc extesions
    wlr-randr # Screen utility for setting main screen
  ];
}
