{ config, pkgs, ... }:

{
  home.file.".config/hypr/monitors.conf".text = ''
    # CONFIGURATION MONITEURS
    # DP-2 with HDR
    monitorv2 {
      output = DP-2
      mode = 3440x1440@165
      position = 1920x1440
      scale = 1
      vrr = 3
      cm = srgb
      bitdepth = 10
      sdrbrightness = 1.0
      sdrsaturation = 1.1
      supports_wide_color = 1
      supports_hdr = 1
      sdr_min_luminance = 0.0005
      sdr_max_luminance = 200
      min_luminance = 0.0005
      max_luminance = 1000
      max_avg_luminance = 250
    }

    # DP-3
    monitorv2 {
      output = DP-3
      mode = 3440x1440@120
      position = 1920x0
      scale = 1
      bitdepth = 8
    }

    # DP-1
    monitorv2 {
      output = DP-1
      mode = 1920x1080@240
      position = 0x1800
      scale = 1
      bitdepth = 8
    }

    monitor = ,preferred,auto,1

    # ESPACES DE TRAVAIL
    workspace = 1,monitor:DP-2,persistent:true,default:true
    workspace = 2,monitor:DP-1,persistent:true
    workspace = 3,monitor:DP-3,persistent:true
    workspace = 4,monitor:DP-2,persistent:true
  '';
}