{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Commandes d'exécution au démarrage
    exec = [
      "hyprctl setcursor Bibata-Modern-Classic 20"
      "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'"
      "gsettings set org.gnome.desktop.interface cursor-size 20"
      "gsettings set org.gnome.desktop.interface icon-theme 'Kanagawa'"
      "gsettings set org.gnome.desktop.interface gtk-theme 'Kanagawa-B-LB'"
      "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      "gsettings set org.gnome.desktop.interface font-name 'Nerd Font 10'"
      "gsettings set org.gnome.desktop.interface document-font-name 'Nerd Font 10'"
      "gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font Mono 9'"
      "gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'"
      "gsettings set org.gnome.desktop.interface font-hinting 'full'"
    ];

    # Configuration générale
    general = {
      gaps_in = 2;
      gaps_out = 3;
      border_size = 3;
      "col.active_border" = "rgba(E5C07CFF)";    # Jaune pour les bordures actives
      "col.inactive_border" = "rgba(3B4152FF)";  # Gris sombre pour les bordures inactives
      layout = "master";
      resize_on_border = true;
      allow_tearing = true;
    };

    # Configuration des groupes
    group = {
      "col.border_active" = "rgba(E5C07CFF)";           # Jaune pour les bordures actives
      "col.border_inactive" = "rgba(3B4152FF)";         # Gris sombre pour les bordures inactives
      "col.border_locked_active" = "rgba(E5C07CFF)";    # Jaune pour les bordures verrouillées actives
      "col.border_locked_inactive" = "rgba(3B4152FF)";  # Gris sombre pour les bordures verrouillées inactives
    };

    # Configuration du curseur
    cursor = {
      inactive_timeout = 15;
    };

    # Configuration des décorations
    decoration = {
      rounding = 10;

      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        new_optimizations = true;
        ignore_opacity = true;
        xray = false;
      };
    };
  };
}