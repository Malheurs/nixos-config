{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # VARIABLES D'ENVIRONNEMENT
    env = [
      ### WAYLAND CORE ###
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "CLUTTER_BACKEND,wayland"
      "GDK_BACKEND,wayland,x11,*"
      "SDL_VIDEODRIVER,wayland"
      
      ### QT CONFIGURATION ###
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      
      ### ELECTRON & BROWSERS ###
      "NIXOS_OZONE_WL,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      
      ### NVIDIA CORE ###
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "LIBVA_DRIVER_NAME,nvidia"
      "WLR_NO_HARDWARE_CURSORS,1"
      "WLR_RENDERER,vulkan"
      
      ### NVIDIA PERFORMANCE ###
      "__GL_GSYNC_ALLOWED,1"
      "__GL_VRR_ALLOWED,1"
      "__NV_PRIME_RENDER_OFFLOAD,1"
      "__VK_LAYER_NV_optimus,NVIDIA_only"
      "NVD_BACKEND,direct"
      
      ### NVIDIA STABILITY ###
      "WLR_DRM_NO_ATOMIC,1"
      
      ### HDR ###
      "ENABLE_HDR_WSI,1"
      
      ### FALLBACKS & COMPATIBILITY ###
      "WLR_RENDERER_ALLOW_SOFTWARE,1"
      
      ### APPLICATION SPECIFIC ###
      "HYPRSHOT_DIR,$HOME/Images/screenshots"
    ];
  };
}