{ inputs, pkgs, lib, config, pkgs-unstable, ... }:

{
  imports = [
    ./hyprland/animations.nix
    ./hyprland/environment.nix
    ./hyprland/keybinds.nix
    ./hyprland/monitors.nix
    ./hyprland/scripts.nix
    ./hyprland/kanagawa.nix
    ./hyprland/windowrules.nix
  ];

  # Configuration de base via home.file
  home.file.".config/hypr/hyprland.conf".text = ''
    # Source des configurations
    source = ~/.config/hypr/monitors.conf
    source = ~/.config/hypr/animations.conf
    source = ~/.config/hypr/keybinds.conf
    source = ~/.config/hypr/windowrules.conf
    source = ~/.config/hypr/environment.conf
    source = ~/.config/hypr/kanagawa.conf

    # CONFIGURATION INPUT
    input {
        kb_layout = qwerty-fr
        kb_variant = 
        kb_model = 
        kb_rules = 
        repeat_rate = 50
        repeat_delay = 300
        left_handed = false
        follow_mouse = 1
        mouse_refocus = false
        float_switch_override_focus = 0
    }

    # CONFIGURATION DWINDLE
    dwindle {
        pseudotile = true
        preserve_split = true
        special_scale_factor = 0.8
        force_split = 2
        smart_split = true
        split_bias = 1
    }

    # CONFIGURATION MASTER
    master {
        new_status = slave
        new_on_top = false
        mfact = 0.5
        allow_small_split = true
        drop_at_cursor = true
    }

    # CONFIGURATION MISC
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        mouse_move_enables_dpms = true
        focus_on_activate = false
        enable_swallow = true
        swallow_regex = ^(kitty|com.mitchellh.ghostty)$
        close_special_on_empty = true
        new_window_takes_over_fullscreen = 2
        enable_anr_dialog = false
    }

    # CONFIGURATION BINDS
    binds {
        workspace_back_and_forth = true
        allow_workspace_cycles = true
        pass_mouse_when_bound = false
    }

    # CONFIGURATION XWAYLAND
    xwayland {
        force_zero_scaling = true
    }

    # CONFIGURATION HDR
    render {
        cm_fs_passthrough = 0
        cm_auto_hdr = 0
    }

    # VARIABLES
    $scriptsDir = ~/.config/hypr/scripts
    $lock = $scriptsDir/LockScreen.sh
    $SwwwRandom = $scriptsDir/WallpaperRandom.sh
    $WallpaperPath = ~/Images/wallpapers

    # APPLICATIONS AU DEMARRAGE
    exec-once = dbus-update-activation-environment --systemd --all &                               # for XDPH
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &          # for XDPH
    exec-once = sleep 0.2 & goxlr-daemon & # Launch GoXLR deamon
    exec-once = sleep 0.2 & systemctl restart --user polkit-gnome-authentication-agent-1 & # Launch Polkit
    exec-once = hyprpanel & # launch the system panel
    exec-once = nm-applet --indicator &  # systray app for Network/Wifi
    exec-once = eww daemon &  # start eww daemon
    exec-once = wl-paste --type text --watch cliphist store & # clipboard store text data
    exec-once = wl-paste --type image --watch cliphist store & # clipboard store image data
    exec-once = sleep 1.5 && swww query || swww init  & # init wallpaper switcher
    exec-once = sleep 1.5 && $SwwwRandom $WallpaperPath & # random wallpaper switcher every 30 minutes
    exec-once = $scriptsDir/zen-workspace-manager.sh
    # Make DP-2 the primary monitor
    exec-once = sleep 1.5s && hyprctl dispatch workspace 1 & # start on workspace 1
    exec-once = sleep 7 && watch -n 60 xrandr --output DP-2 --primary # set primary monitor every 1 minutes
  '';
}