{ config, pkgs, ... }:

{
  home.file.".config/hypr/keybinds.conf".text = ''
    # VARIABLES POUR LES APPLICATIONS
    $mainMod = SUPER
    $files = thunar
    $browser = zen-beta
    $term = ghostty
    $music = g4music
    $game = cartridges

    # RACCOURCIS APPLICATIONS SYSTEME
    bind = $mainMod, Return, exec, $term
    bind = $mainMod, SPACE, exec, pkill rofi || ~/.config/hypr/scripts/rofi.sh
    bind = $mainMod, B, exec, $browser
    bind = $mainMod ALT, B, exec, $browser --private-window
    bind = $mainMod, Y, exec, $music
    bind = $mainMod, T, exec, $files
    bind = $mainMod, G, exec, $game

    # CONTROLES HYPRLAND
    bind = $mainMod, F, fullscreen
    bind = $mainMod, C, killactive
    bind = $mainMod, A, togglefloating
    bind = $mainMod SHIFT, P, pseudo
    bind = $mainMod SHIFT, O, togglesplit
    bind = $mainMod SHIFT, M, exit
    bind = CTRL ALT, Delete, exec, hyprctl dispatch exit 0

    # NAVIGATION ESPACES DE TRAVAIL
    bind = $mainMod, tab, workspace, m+1
    bind = $mainMod SHIFT, tab, workspace, m-1

    # BASCULER VERS ESPACES DE TRAVAIL
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4

    # NAVIGATION FOCUS
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, j, movefocus, d
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, l, movefocus, r
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, down, movefocus, d
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, right, movefocus, r

    # DEPLACER FENETRE VERS ESPACE DE TRAVAIL
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # NAVIGATION SOURIS
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # WALLPAPERS
    bind = $mainMod, W, exec, ~/.config/hypr/scripts/WallpaperSelect.sh
    bind = CTRL ALT, W, exec, ~/.config/hypr/scripts/Wallpaper.sh

    # FONCTIONNALITES EXTRAS
    bind = $mainMod ALT, R, exec, ~/.config/hypr/scripts/Refresh.sh
    bind = $mainMod SHIFT, H, exec, ~/.config/hypr/scripts/KeyHints.sh
    bind = $mainMod ALT, Space, exec, ~/.config/hypr/scripts/ChangeLayout.sh

    # RACCOURCIS SOURIS
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
  '';
}