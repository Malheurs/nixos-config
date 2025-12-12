{ inputs, pkgs, lib, config, pkgs-unstable, ... }:

{
  imports = [
    ./niri-keybinds.nix
    ./niri-monitors.nix
  #  ./niri/scripts.nix
  #  ./niri/kanagawa.nix
  #  ./niri/windowrules.nix
  ];

  # Configuration Niri via home.file
  home.file.".config/niri/config.kdl".text = ''
    // Source des configurations
    // Note: Niri utilise le format KDL, les imports se font différemment
    
    input {
        keyboard {
            xkb {
                layout "qwerty-fr"
            }
            repeat-delay 300
            repeat-rate 50
        }
        
        mouse {
            // Niri gère le focus différemment, pas d'équivalent direct pour tous les paramètres
            accel-profile "flat"
        }
        
        touchpad {
            tap
            dwt
            natural-scroll
        }
        
        focus-follows-mouse
    }
    
    // CONFIGURATION DES LAYOUTS
    layout {
        // Niri n'a pas dwindle/master, il utilise son propre système de colonnes
        gaps 8
        
        center-focused-column "on-overflow"
        
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        
        default-column-width { proportion 0.5; }
        
        focus-ring {
            width 2
            active-color "#7E9CD8"
            inactive-color "#2A2A37"
        }
        
        border {
            width 1
            active-color "#7E9CD8"
            inactive-color "#2A2A37"
        }
    }
    
    // CONFIGURATION DES ANIMATIONS
    animations {
        slowdown 1.0
        
        window-open {
            duration-ms 150
            curve "ease-out-cubic"
        }
        
        window-close {
            duration-ms 150
            curve "ease-out-cubic"
        }
        
        window-movement {
            duration-ms 200
            curve "ease-out-cubic"
        }
        
        workspace-switch {
            duration-ms 200
            curve "ease-out-cubic"
        }
        
        horizontal-view-movement {
            duration-ms 200
            curve "ease-out-cubic"
        }
        
        window-resize {
            duration-ms 150
            curve "ease-out-cubic"
        }
    }
    
    // CONFIGURATION DES WORKSPACES
    // Niri gère les workspaces différemment (défilement horizontal)
    prefer-no-csd
    
    // CONFIGURATION DIVERSES
    spawn-at-startup "dbus-update-activation-environment" "--systemd" "--all"
    spawn-at-startup "systemctl" "--user" "import-environment" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "sh" "-c" "sleep 0.2 && goxlr-daemon"
    spawn-at-startup "sh" "-c" "sleep 0.2 && systemctl restart --user polkit-gnome-authentication-agent-1"
    spawn-at-startup "nm-applet" "--indicator"
    spawn-at-startup "eww" "daemon"
    spawn-at-startup "sh" "-c" "wl-paste --type text --watch cliphist store"
    spawn-at-startup "sh" "-c" "wl-paste --type image --watch cliphist store"
    spawn-at-startup "sh" "-c" "sleep 1.5 && (swww query || swww init)"
    spawn-at-startup "sh" "-c" "sleep 1.5 && ~/.config/niri/scripts/WallpaperRandom.sh ~/Images/wallpapers"
    spawn-at-startup "sh" "-c" "~/.config/niri/scripts/zen-workspace-manager.sh"
    
    // VARIABLES D'ENVIRONNEMENT
    environment {
        XCURSOR_SIZE "24"
        XCURSOR_THEME "Adwaita"
    }
    
    // CONFIGURATION DES OUTPUTS (MONITEURS)
    // À adapter selon vos moniteurs spécifiques
    // Les configurations de monitors.nix devront être converties en KDL
    
    // RÈGLES DE FENÊTRES
    // Les windowrules devront être adaptées au format KDL de Niri
    window-rule {
        match app-id=".*"
        default-column-width { proportion 0.5; }
    }
    
    // KEYBINDS DE BASE (à compléter avec keybinds.nix)
    binds {
        // Les keybinds Hyprland devront être convertis au format Niri
        // Exemple de base:
        Mod+Return { spawn "kitty"; }
        Mod+Q { close-window; }
        
        // Navigation entre fenêtres
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        
        // Déplacement de fenêtres
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        
        // Workspaces (Niri utilise un défilement horizontal)
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        
        // Mode fullscreen
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        
        // Redimensionnement
        Mod+R { switch-preset-column-width; }
    }
    
    // SCREENSHOT ET AUTRES FONCTIONNALITÉS
    screenshot-path "~/Images/screenshots/screenshot-%Y-%m-%d_%H-%M-%S.png"
  '';

  # Création des fichiers de scripts adaptés
  home.file.".config/niri/scripts/WallpaperRandom.sh" = {
    source = ./niri/scripts/WallpaperRandom.sh;
    executable = true;
  };
  
  home.file.".config/niri/scripts/zen-workspace-manager.sh" = {
    source = ./niri/scripts/zen-workspace-manager.sh;
    executable = true;
  };
}