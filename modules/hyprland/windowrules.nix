{ config, pkgs, ... }:

{
  home.file.".config/hypr/windowrules.conf".text = ''
    # VARIABLES POUR LES APPLICATIONS
    $browser = zen-beta

    # REGLES FENETRES GENERALES
    windowrule = float on, match:class (polkit-gnome-authentication-agent-1)
    windowrule = stay_focused on, match:class (polkit-gnome-authentication-agent-1)
    windowrule = float on, match:class (nm-connection-editor|blueman-manager)
    windowrule = float on, match:class (nwg-look|qt5ct|mpv|eog|zoom|rofi|org.gnome.SystemMonitor|yad)
    windowrule = float on, match:class (onedriver|onedriver-launcher)
    windowrule = float on, match:class (mpv|imv)
    windowrule = opaque on, match:class (mpv|imv)

    # Audio
    windowrule = float on, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = opaque on, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = center on, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = size 1250 775, match:class (pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|org.gnome.SystemMonitor)

    # VPN et autres
    windowrule = float on, match:title (Proton VPN)
    windowrule = opaque on, match:title (Proton VPN)
    windowrule = float on, match:class (xdg-desktop-portal-gtk)
    windowrule = float on, match:class (codium|codium-url-handler|VSCodium|code-oss), match:title (Add Folder to Workspace)

    # Transparence applications
    windowrule = opacity 0.9 0.8, match:class ^(vesktop)$
    windowrule = opacity 0.9 0.7, match:class ^(firefox|Firefox-esr|librewolf|floorp)$
    windowrule = opacity 0.8 0.6, match:class ^(pcmanfm-qt)$
    windowrule = opacity 0.9 0.8, match:class ^(kitty|com.mitchellh.ghostty)$
    windowrule = opacity 0.9 0.7, match:class ^([Rr]ofi|gedit|codium|codium-url-handler|yad|com.obsproject.Studio|com.github.neithern.g4music|page.kramo.Cartridges)$

    # Exceptions opacite pour streaming
    windowrule = opaque on, match:class ^(librewolf|floorp|zen-beta)$, match:title (.*)([Tt]witch|[Yy]ou[Tt]ube)(.*)
    windowrule = stay_focused on, match:class ^(gcr-prompter|polkit-gnome-authentication-agent-1)$

    # Inhiber mise en veille pour plein ecran
    windowrule = idle_inhibit fullscreen, match:fullscreen 1

    # Ignorer demandes maximisation
    windowrule = suppress_event maximize, match:class .*

    # Thunar
    windowrule = opacity 0.9 0.8, match:class ^([Tt]hunar)$
    windowrule = float on, match:class ^([Tt]hunar)$, match:title (Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)
    windowrule = center on, match:class ^([Tt]hunar)$, match:title (Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)
    windowrule = float on, match:class ^(thunar)$, match:title ^(.*[Rr]enommer.*)$
    windowrule = size 400 150, match:class ^(thunar)$, match:title ^(.*[Rr]enommer.*)$
    windowrule = center on, match:class ^(thunar)$, match:title ^(.*[Rr]enommer.*)$

    # qBittorrent
    windowrule = workspace 3, match:class ^(org.qbittorrent.qBittorrent)$
    windowrule = monitor 2, match:class ^(org.qbittorrent.qBittorrent)$

    # Steam
    windowrule = monitor DP-2, match:title ^([Ss]team)$
    windowrule = workspace 1, match:title ^([Ss]team)$
    windowrule = center on, match:title ^([Ss]team)$
    windowrule = opaque on, match:title ^([Ss]team)$
    windowrule = size 1250 775, match:title ^([Ss]team)$
    windowrule = float on, match:class ^([Ss]team)$
    windowrule = float on, match:class ^([Ss]team)$, match:title ^(Paramètres Steam|Se connecter à Steam|Steam Settings|Lancement...)$
    windowrule = center on, match:class ^([Ss]team)$, match:title ^(Paramètres Steam|Se connecter à Steam|Steam Settings|Lancement...)$
    windowrule = monitor DP-2, match:class ^steam_app_[0-9]+$
    windowrule = workspace 4, match:class ^steam_app_[0-9]+$
    windowrule = fullscreen on, match:class ^steam_app_[0-9]+$
    windowrule = monitor DP-2, match:class ^steam_app_.*$
    windowrule = workspace 4, match:class ^steam_app_.*$
    windowrule = fullscreen on, match:class ^steam_app_.*$
    windowrule = stay_focused on, match:class ^([Ss]team)$, match:title ^()$
    windowrule = min_size 1 1, match:class ^([Ss]team)$, match:title ^()$

    # Black Desert Online
    windowrule = monitor DP-2, match:class ^(blackdesert64.exe|blackdesertpatcher32.pae)$
    windowrule = workspace 4, match:class ^(blackdesert64.exe|blackdesertpatcher32.pae)$
    windowrule = fullscreen on, match:class ^(blackdesert64.exe|blackdesertpatcher32.pae)$

    # Cave of Qud
    windowrule = monitor DP-2, match:class ^(CoQ.x86_64)$
    windowrule = workspace 4, match:class ^(CoQ.x86_64)$
    windowrule = fullscreen on, match:class ^(CoQ.x86_64)$

    # Clair Obscur - Expedition 33
    windowrule = monitor DP-2, match:class ^(sandfall-win64-shipping.exe)$
    windowrule = workspace 4, match:class ^(sandfall-win64-shipping.exe)$
    windowrule = fullscreen on, match:class ^(sandfall-win64-shipping.exe)$

    # Dark Age of Camelot
    windowrule = float on, match:title ^(Eden Launcher)$
    windowrule = opaque on, match:title ^(Eden Launcher)$
    windowrule = monitor DP-2, match:class ^(edenlauncher.exe)$
    windowrule = workspace 1, match:class ^(edenlauncher.exe)$
    windowrule = monitor DP-2, match:class ^(game.dll)$
    windowrule = workspace 4, match:class ^(game.dll)$
    windowrule = fullscreen on, match:class ^(game.dll)$

    # Genshin Impact
    windowrule = monitor DP-2, match:class ^(genshinimpact.exe)$
    windowrule = workspace 4, match:class ^(genshinimpact.exe)$
    windowrule = fullscreen on, match:class ^(genshinimpact.exe)$

    # Guild Wars 2
    windowrule = monitor DP-2, match:class ^(gw2-64.exe)$
    windowrule = workspace 4, match:class ^(gw2-64.exe)$
    windowrule = fullscreen on, match:class ^(gw2-64.exe)$

    # Hollow Knight Silksong
    windowrule = monitor DP-2, match:class ^(Hollow Knight Silksong)$
    windowrule = workspace 4, match:class ^(Hollow Knight Silksong)$
    windowrule = fullscreen on, match:class ^(Hollow Knight Silksong)$

    # Picture-in-Picture
    windowrule = opacity 0.95 0.75, match:title ^(Picture-in-Picture)$
    windowrule = pin on, match:title ^(Picture-in-Picture)$
    windowrule = float on, match:title ^(Incrustation vidéo)$
    windowrule = float on, match:title ^(floorp)$
    windowrule = size 25% 25%, match:title ^(Picture-in-Picture)$
    windowrule = move 72% 7%, match:title ^(Picture-in-Picture)$

    # OrcaSlicer
    windowrule = force_rgbx on, match:class ^(OrcaSlicer)$
  '';
}