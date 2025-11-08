{ config, pkgs, ... }:

{
  home.file.".config/hypr/environment.conf".text = ''
    # VARIABLES D'ENVIRONNEMENT
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = CLUTTER_BACKEND,wayland
    env = GDK_BACKEND,wayland,x11,*
    env = SDL_VIDEODRIVER,wayland
    
    # QT CONFIGURATION
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_SCALE_FACTOR,1
    env = QT_QPA_PLATFORM,wayland;xcb
    env = QT_QPA_PLATFORMTHEME,qt5ct
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
    
    # ELECTRON & BROWSERS
    env = NIXOS_OZONE_WL,1
    env = ELECTRON_OZONE_PLATFORM_HINT,wayland
    env = MOZ_ENABLE_WAYLAND,1
    
    # NVIDIA CORE
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = GBM_BACKEND,nvidia-drm
    env = LIBVA_DRIVER_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1
    env = WLR_RENDERER,vulkan
    
    # NVIDIA PERFORMANCE
    env = __GL_GSYNC_ALLOWED,1
    env = __GL_VRR_ALLOWED,1
    env = __NV_PRIME_RENDER_OFFLOAD,1
    env = __VK_LAYER_NV_optimus,NVIDIA_only
    env = NVD_BACKEND,direct
    
    # NVIDIA STABILITY
    env = WLR_DRM_NO_ATOMIC,1
    
    # HDR
    env = ENABLE_HDR_WSI,1
    
    # FALLBACKS & COMPATIBILITY
    env = WLR_RENDERER_ALLOW_SOFTWARE,1
    
    # APPLICATION SPECIFIC
    env = HYPRSHOT_DIR,$HOME/Images/screenshots
  '';
}