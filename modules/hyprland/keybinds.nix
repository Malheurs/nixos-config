{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # VARIABLES POUR LES APPLICATIONS
    "$mainMod" = "SUPER";
    "$files" = "thunar";
    "$browser" = "zen-beta";
    "$term" = "ghostty";
    "$music" = "g4music";
    "$game" = "cartridges";
    "$scriptsDir" = "$HOME/.config/hypr/scripts";

    # RACCOURCIS APPLICATIONS SYSTEME
    bind = [
      # Applications principales
      "$mainMod, Return, exec, $term"
      "$mainMod, SPACE, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run"
      "$mainMod, B, exec, $browser"
      "$mainMod ALT, B, exec, $browser --private-window"
      "$mainMod, Y, exec, $music"
      "$mainMod, T, exec, $files"
      "$mainMod, G, exec, $game"

      # Controles Hyprland
      "$mainMod, F, fullscreen"
      "$mainMod, C, killactive"
      "$mainMod, A, togglefloating"
      "$mainMod SHIFT, P, pseudo"
      "$mainMod SHIFT, O, togglesplit"
      "$mainMod SHIFT, M, exit"
      "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"

      # Navigation espaces de travail
      "$mainMod, tab, workspace, m+1"
      "$mainMod SHIFT, tab, workspace, m-1"

      # Basculer vers espaces de travail
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"

      # Navigation focus
      "$mainMod, h, movefocus, l"
      "$mainMod, j, movefocus, d"
      "$mainMod, k, movefocus, u"
      "$mainMod, l, movefocus, r"
      "$mainMod, left, movefocus, l"
      "$mainMod, down, movefocus, d"
      "$mainMod, up, movefocus, u"
      "$mainMod, right, movefocus, r"

      # Deplacer fenetre vers espace de travail
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Navigation souris
      "$mainMod, mouse_down, workspace, 1"
      "$mainMod, mouse_up, workspace, 4"

      # Wallpapers
      "$mainMod, W, exec, $scriptsDir/WallpaperSelect.sh"
      "CTRL ALT, W, exec, $scriptsDir/Wallpaper.sh"

      # Fonctionnalites extras
      "$mainMod ALT, R, exec, $scriptsDir/Refresh.sh"
      "$mainMod SHIFT, H, exec, $scriptsDir/KeyHints.sh"
      "$mainMod ALT, Space, exec, $scriptsDir/ChangeLayout.sh"

      # Submap pour mode deplacement
      ",escape,submap,reset"
    ];

    # RACCOURCIS SOURIS
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # SUBMAP MOVE
    submap = [
      "move"
      "reset"
    ];
  };
}
