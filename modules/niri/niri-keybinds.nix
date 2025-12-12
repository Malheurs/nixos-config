{ config, pkgs, ... }:
{
  home.file.".config/niri/keybinds.kdl".text = ''
    // KEYBINDS POUR NIRI
    // Note: Niri utilise le modificateur "Mod" pour SUPER/Win
    
    binds {
        // ============================================
        // APPLICATIONS SYSTEME
        // ============================================
        
        Mod+Return { spawn "ghostty"; }
        Mod+Space { spawn "sh" "-c" "pkill rofi || rofi -show drun -modi drun,filebrowser,run"; }
        Mod+B { spawn "zen-beta"; }
        Mod+Alt+B { spawn "zen-beta" "--private-window"; }
        Mod+Y { spawn "g4music"; }
        Mod+T { spawn "thunar"; }
        Mod+G { spawn "cartridges"; }
        
        // ============================================
        // CONTROLES FENETRES
        // ============================================
        
        Mod+C { close-window; }
        Mod+F { fullscreen-window; }
        Mod+A { set-window-height "-10"; } // Toggle float n'existe pas tel quel dans Niri
        
        // Quitter Niri
        Mod+Shift+M { quit; }
        Ctrl+Alt+Delete { quit; }
        
        // Toggle bar (si vous utilisez un bar compatible)
        // Mod+B { spawn "noctalia" "ipc" "call" "bar" "toggle"; }
        
        // ============================================
        // NAVIGATION WORKSPACES
        // ============================================
        
        // Niri utilise un modèle de défilement horizontal
        Mod+Tab { focus-workspace-down; }
        Mod+Shift+Tab { focus-workspace-up; }
        
        // Navigation par numéro de workspace
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }
        
        // ============================================
        // NAVIGATION FOCUS (VIM-STYLE)
        // ============================================
        
        // Niri utilise un système de colonnes et de fenêtres
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        
        // Avec les flèches
        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Down { focus-window-down; }
        Mod+Up { focus-window-up; }
        
        // ============================================
        // DEPLACEMENT DE FENETRES
        // ============================================
        
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        
        // Avec les flèches
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+Up { move-window-up; }
        
        // ============================================
        // DEPLACER FENETRE VERS WORKSPACE
        // ============================================
        
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }
        
        // ============================================
        // REDIMENSIONNEMENT
        // ============================================
        
        // Niri utilise des presets de largeur de colonne
        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { reset-window-height; }
        
        // Mode resize interactif
        Mod+Alt+R { switch-layout "next"; }
        
        // Ajuster la largeur de colonne
        Mod+Equal { set-column-width "+10%"; }
        Mod+Minus { set-column-width "-10%"; }
        
        // Ajuster la hauteur de fenêtre
        Mod+Shift+Equal { set-window-height "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        
        // ============================================
        // LAYOUTS ET MAXIMISATION
        // ============================================
        
        Mod+M { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        
        // ============================================
        // WALLPAPERS
        // ============================================
        
        Mod+W { spawn "sh" "-c" "~/.config/niri/scripts/WallpaperSelect.sh"; }
        Ctrl+Alt+W { spawn "sh" "-c" "~/.config/niri/scripts/Wallpaper.sh"; }
        
        // ============================================
        // FONCTIONNALITES EXTRAS
        // ============================================
        
        Mod+Alt+R { spawn "sh" "-c" "~/.config/niri/scripts/Refresh.sh"; }
        Mod+Shift+H { spawn "sh" "-c" "~/.config/niri/scripts/KeyHints.sh"; }
        Mod+Alt+Space { spawn "sh" "-c" "~/.config/niri/scripts/ChangeLayout.sh"; }
        
        // ============================================
        // NAVIGATION PAR SCROLL (équivalent souris)
        // ============================================
        
        // Niri gère la souris différemment
        // Les binds souris se font automatiquement:
        // - Mod+Clic gauche = déplacer fenêtre
        // - Mod+Clic droit = redimensionner fenêtre
        
        // Scroll pour changer de workspace
        Mod+WheelScrollDown { focus-workspace-down; }
        Mod+WheelScrollUp { focus-workspace-up; }
        
        // ============================================
        // SCREENSHOTS (si vous utilisez grim/slurp)
        // ============================================
        
        Print { spawn "sh" "-c" "grim ~/Images/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"; }
        Shift+Print { spawn "sh" "-c" "grim -g \\"$(slurp)\\" ~/Images/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"; }
        
        // ============================================
        // CONTROLES MEDIA (optionnel)
        // ============================================
        
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
        
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
    }
  '';
}