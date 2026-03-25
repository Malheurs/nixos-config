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
        on_focus_under_fullscreen = 2
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
        cm_enabled = true
        cm_fs_passthrough = 1
        cm_auto_hdr = 0
        direct_scanout = 2
    }

    # VARIABLES
    $scriptsDir = ~/.config/hypr/scripts
    $lock = $scriptsDir/LockScreen.sh
    $SwwwRandom = $scriptsDir/WallpaperRandom.sh
    $WallpaperPath = ~/Images/wallpapers

    # APPLICATIONS AU DEMARRAGE
    # ── Layer 0 : services système ───────────────────────────────────────
    exec-once = systemctl --user start gvfs-daemon.service
    exec-once = systemctl restart --user polkit-gnome-authentication-agent-1
    exec-once = goxlr-daemon

    # ── Layer 1 : shell & tray ───────────────────────────────────────────
    #exec-once = hyprpanel
    #exec-once = noctalia-shell
    exec-once = caelestia-shell -d
    exec-once = nm-applet --indicator
    #exec-once = eww daemon

    # ── Layer 2 : clipboard ──────────────────────────────────────────────
    exec-once = wl-paste --type text --watch cliphist store
    exec-once = wl-paste --type image --watch cliphist store

    # ── Layer 3 : wallpaper ──────────────────────────────────────────────
    exec-once = sleep 1.5 && { swww query || swww init; }
    exec-once = sleep 2 && $SwwwRandom $WallpaperPath

    # ── Layer 4 : fichiers & workspace ───────────────────────────────────
    exec-once = nm-online -t 30 && ls /mnt/{Documents,Games,Images,Media,Private,Softwares} > /dev/null 2>&1
    exec-once = thunar --daemon
    exec-once = hyprctl dispatch workspace 1
    exec-once = $scriptsDir/zen-workspace-manager.sh
    exec-once = watch -n 300 xrandr --output DP-2 --primary

    # ── Layer 5 : apps lourdes ───────────────────────────────────────────
    exec-once = sleep 3 && steam -silent
    '';
}