{ config, pkgs, ... }:

{
  home.file.".config/hypr/windowrules.conf".text = ''
    # VARIABLES POUR LES APPLICATIONS
    $browser = zen-beta

    # REGLES FENETRES GENERALES
    windowrule = float,class:(polkit-gnome-authentication-agent-1)
    windowrule = stayfocused,class:(polkit-gnome-authentication-agent-1)
    windowrule = float,class:(nm-connection-editor|blueman-manager)
    windowrule = float,class:(nwg-look|qt5ct|mpv|eog|zoom|rofi|org.gnome.SystemMonitor|yad)
    windowrule = float,class:(onedriver|onedriver-launcher)
    windowrule = float,class:(mpv|imv)
    windowrule = opaque,class:(mpv|imv)
    
    # Audio
    windowrule = float,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = opaque,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = center,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)
    windowrule = size 1250 775,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|org.gnome.SystemMonitor)
    
    # VPN et autres
    windowrule = float,title:(Proton VPN)
    windowrule = opaque,title:(Proton VPN)
    windowrule = float,class:(xdg-desktop-portal-gtk)
    windowrule = float,class:(codium|codium-url-handler|VSCodium|code-oss),title:(Add Folder to Workspace)
    
    # Transparence applications
    windowrule = opacity 0.9 0.8,class:^(vesktop)$
    windowrule = opacity 0.9 0.7,class:^(firefox|Firefox-esr|librewolf|floorp)$
    windowrule = opacity 0.8 0.6,class:^(pcmanfm-qt)$
    windowrule = opacity 0.9 0.8,class:^(kitty|com.mitchellh.ghostty)$
    windowrule = opacity 0.9 0.7,class:^([Rr]ofi|gedit|codium|codium-url-handler|yad|com.obsproject.Studio|com.github.neithern.g4music|page.kramo.Cartridges)$
    
    # Exceptions opacite pour streaming
    windowrule = opaque,class:^(librewolf|floorp|zen-beta),title:(.*)([Tt]witch|[Yy]ou[Tt]ube)(.*)
    windowrule = stayfocused,class:^(gcr-prompter|polkit-gnome-authentication-agent-1)$
    
    # Inhiber mise en veille pour plein ecran
    windowrule = idleinhibit fullscreen,class:^(.*)$
    windowrule = idleinhibit fullscreen,title:^(.*)$
    windowrule = idleinhibit fullscreen,fullscreen:1
    
    # Ignorer demandes maximisation
    windowrule = suppressevent maximize,class:.*
    
    # Thunar
    windowrule = opacity 0.9 0.8,class:^([Tt]hunar)$
    windowrule = float,class:^([Tt]hunar),title:(Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)$
    windowrule = center,class:^([Tt]hunar),title:(Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)$
    
    # qBittorrent
    windowrule = workspace 3,class:^(org.qbittorrent.qBittorrent)$
    windowrule = monitor 2,class:^(org.qbittorrent.qBittorrent)$
    
    # Steam
    windowrule = monitor DP-2,title:^([Ss]team)$
    windowrule = workspace 1,title:^([Ss]team)$
    windowrule = center 1,title:^([Ss]team)$
    windowrule = opaque,title:^([Ss]team)$
    windowrule = size 1250 775,title:^([Ss]team)$
    windowrule = float,class:^([Ss]team)$
    windowrule = float,class:([Ss]team)$,title:^(Paramètres Steam|Steam Settings|Lancement...)$
    windowrule = center 1,class:^([Ss]team)$,title:^(Paramètres Steam|Steam Settings|Lancement...)$
    windowrule = monitor DP-2,class:^steam_app_[0-9]+$
    windowrule = workspace 4,class:^steam_app_[0-9]+$
    windowrule = fullscreen,class:^steam_app_[0-9]+$
    windowrule = monitor DP-2,class:^steam_app_.*$
    windowrule = workspace 4,class:^steam_app_.*$
    windowrule = fullscreen,class:^steam_app_.*$
    windowrule = stayfocused,title:^()$,class:^([Ss]team)$
    windowrule = minsize 1 1,title:^()$,class:^([Ss]team)$

    # Black Desert Online
    windowrule = monitor DP-2,class:^(blackdesert64.exe)$
    windowrule = workspace 4,class:^(blackdesert64.exe)$
    windowrule = fullscreen,class:^(blackdesert64.exe)$

    # Cave of Qud
    windowrule = monitor DP-2,class:^(CoQ.x86_64)$
    windowrule = workspace 4,class:^(CoQ.x86_64)$
    windowrule = fullscreen,class:^(CoQ.x86_64)$

    # Clair Obscur - Expedition 33
    windowrule = monitor DP-2,class:^(sandfall-win64-shipping.exe)$
    windowrule = workspace 4,class:^(sandfall-win64-shipping.exe)$
    windowrule = fullscreen,class:^(sandfall-win64-shipping.exe)$
    
    # Dark Age of Camelot
    windowrule = float,title:^(Eden Launcher)$
    windowrule = opaque,title:^(Eden Launcher)$
    windowrule = monitor DP-2,class:^(edenlauncher.exe)$
    windowrule = workspace 1,class:^(edenlauncher.exe)$
    windowrule = monitor DP-2,class:^(game.dll)$
    windowrule = workspace 4,class:^(game.dll)$
    windowrule = fullscreen,class:^(game.dll)$
    
    # Genshin Impact
    windowrule = monitor DP-2,class:^(genshinimpact.exe)$
    windowrule = workspace 4,class:^(genshinimpact.exe)$
    windowrule = fullscreen,class:^(genshinimpact.exe)$
    
    # Picture-in-Picture
    windowrule = opacity 0.95 0.75,title:^(Picture-in-Picture)$
    windowrule = pin,title:^(Picture-in-Picture)$
    windowrule = float,title:^(Incrustation vidéo)$
    windowrule = float,title:^(floorp)$
    windowrule = size 25% 25%,title:^(Picture-in-Picture)$
    windowrule = move 72% 7%,title:^(Picture-in-Picture)$

    # REGLES FENETRES V2 (pour syntaxe plus avancee)
    windowrulev2 = float,class:^(thunar)$,title:^(.*[Rr]enommer.*)$
    windowrulev2 = size 400 150,class:^(thunar)$,title:^(.*[Rr]enommer.*)$
    windowrulev2 = center,class:^(thunar)$,title:^(.*[Rr]enommer.*)$
    windowrulev2 = forcergbx,class:^(OrcaSlicer)$
  '';
}