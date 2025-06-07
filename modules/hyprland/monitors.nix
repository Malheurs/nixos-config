{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # CONFIGURATION MONITEURS
    monitor = [
      # Moniteur principal avec HDR
      "DP-2,3440x1440@165,1920x1440,1,vrr,2,bitdepth,10"
      # Moniteur secondaire
      "DP-3,3440x1440@120,1920x0,1"
      # Moniteur tertiaire
      "HDMI-A-1,1920x1080@60,0x1800,1"
    ];

    # ESPACES DE TRAVAIL
    workspace = [
      "1,monitor:DP-2,persistent:true,default:true"
      "2,monitor:HDMI-A-1,persistent:true,default:true"
      "3,monitor:DP-3,persistent:true,default:true"
      "4,monitor:DP-2,name:game,persistent:false,border:false,rounding:false,decorate:false,shadow:false,gapsin:0,gapsout:0"
    ];
  };
}
