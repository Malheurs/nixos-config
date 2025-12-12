{ config, pkgs, ... }:
{
  home.file.".config/niri/keybinds.kdl".text = ''
    output "DP-2" {
        mode "3440x1440@165"
        position x=1920 y=1440
        scale 1.0
        
        hdr enable
        variable-refresh-rate
    }
    
    output "DP-3" {
        mode "3440x1440@120"
        position x=1920 y=0
    }
    
    output "HDMI-A-1" {
        mode "1920x1080@60"
        position x=0 y=1800
    }
  '';
}