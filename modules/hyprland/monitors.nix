{ config, pkgs, ... }:

{
  home.file.".config/hypr/monitors.conf".text = ''
    # CONFIGURATION MONITEURS
    monitorv2 {
      output = DP-2
      mode = 3440x1440@165
      position = 1920x1440
      scale = 1
      vrr = 3
      bitdepth = 10
      cm = hdr
      sdrbrightness = 1.0
      sdrsaturation = 1.0
      }
    monitorv2 {
      output = DP-3
      mode = 3440x1440@120
      position = 1920x0
      scale = 1}
    monitorv2 {
      output = HDMI-A-1
      mode = 1920x1080@60
      position = 0x1800
      scale = 1
      }

    # ESPACES DE TRAVAIL
    workspace = 1,monitor:DP-2,persistent:true,default:true
    workspace = 2,monitor:HDMI-A-1,persistent:true
    workspace = 3,monitor:DP-3,persistent:true
    workspace = 4,monitor:DP-2,persistent:true
  '';
}