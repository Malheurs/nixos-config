{ config, pkgs, ... }:

{
  home.file.".config/hypr/monitors.conf".text = ''
    # CONFIGURATION MONITEURS
    monitor = DP-2,3440x1440@165,1920x1440,1,vrr,3,bitdepth,10,cm,auto,sdrbrightness,1.0,sdrsaturation,1.1
    monitor = DP-3,3440x1440@120,1920x0,1
    monitor = HDMI-A-1,1920x1080@60,0x1800,1

    # ESPACES DE TRAVAIL
    workspace = 1,monitor:DP-2,persistent:true,default:true
    workspace = 2,monitor:HDMI-A-1,persistent:true
    workspace = 3,monitor:DP-3,persistent:true
    workspace = 4,monitor:DP-2,persistent:true
  '';
}