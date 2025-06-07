{ inputs, pkgs, lib, config, pkgs-unstable, ... }:

{
  imports = [
    ./hyprland/animations.nix
    ./hyprland/environment.nix
    ./hyprland/keybinds.nix
    ./hyprland/monitors.nix
    ./hyprland/scripts.nix
    ./hyprland/windowrules.nix
  ];

  # Configuration utilisateur Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # CONFIGURATION INPUT
      input = {
        kb_layout = "fr";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";
        repeat_rate = 50;
        repeat_delay = 300;
        left_handed = 0;
        follow_mouse = 1;
        mouse_refocus = false;
        float_switch_override_focus = 0;
      };

      # CONFIGURATION GENERALE
      general = {
        allow_tearing = true;
        layout = "master";
      };

      # CONFIGURATION DWINDLE
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.8;
        force_split = 2;
        smart_split = 1;
        split_bias = 1;
      };

      # CONFIGURATION MASTER
      master = {
        new_status = "slave";
        new_on_top = 0;
        mfact = 0.5;
        allow_small_split = true;
        drop_at_cursor = true;
      };

      # CONFIGURATION MISC
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        enable_anr_dialog = false;
        vrr = 1;
        vfr = true;
        focus_on_activate = false;
        enable_swallow = true;
        swallow_regex = "^(kitty|com.mitchellh.ghostty)$";
        close_special_on_empty = true;
        new_window_takes_over_fullscreen = 2;
      };

      # CONFIGURATION BINDS
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
        pass_mouse_when_bound = false;
      };

      # CONFIGURATION XWAYLAND
      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      # CONFIGURATION HDR
      render = {
        cm_fs_passthrough = 2;
        cm_enabled = true;
      };

      # CONFIGURATION EXPERIMENTALE
      experimental = {
        xx_color_management_v4 = true;
      };

      # APPLICATIONS AU DEMARRAGE
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "sleep 0.2 && goxlr-daemon"
        "sleep 0.2 && systemctl restart --user polkit-gnome-authentication-agent-1"
        "hyprpanel"
        "nm-applet --indicator"
        "eww daemon"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "sleep 1.5 && swww query || swww init"
        "sleep 1.5 && ~/.config/hypr/UserScripts/WallpaperRandom.sh ~/Images/wallpapers"
        "sleep 1.5s && hyprctl dispatch workspace 1"
        "sleep 7 && xrandr --output DP-2 --primary"
        "sleep 7 && watch -n 60 xrandr --output DP-2 --primary"
      ];
    };
  };
}
