{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # VARIABLES D'ENVIRONNEMENT
    env = [
      # Wayland
      "CLUTTER_BACKEND,wayland"
      "GDK_BACKEND,wayland,x11,*"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_SCALE_FACTOR,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "NIXOS_OZONE_WL,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      
      # NVIDIA
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
      "GBM_BACKEND,nvidia-drm"
      "LIBVA_DRIVER_NAME,nvidia"
      "__NV_PRIME_RENDER_OFFLOAD,1"
      "__VK_LAYER_NV_optimus,NVIDIA_only"
      "NVD_BACKEND,direct"
      
      # HDR
      "ENABLE_HDR_WSI,1"
      
      # Autres
      "WLR_RENDERER_ALLOW_SOFTWARE,1"
      "HYPRSHOT_DIR,$HOME/Images/screenshots"
    ];
  };
}
