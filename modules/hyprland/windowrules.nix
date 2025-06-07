{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # REGLES FENETRES GENERALES
    windowrule = [
      # Applications systeme
      "float,class:(polkit-gnome-authentication-agent-1)"
      "stayfocused,class:(polkit-gnome-authentication-agent-1)"
      "float,class:(nm-connection-editor|blueman-manager)"
      "float,class:(nwg-look|qt5ct|mpv|eog|zoom|rofi|org.gnome.SystemMonitor|yad)"
      "float,class:(onedriver|onedriver-launcher)"
      "float,class:(mpv|imv)"
      "opaque,class:(mpv|imv)"
      
      # Audio
      "float,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)"
      "opaque,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)"
      "center,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)"
      "size 1250 775,class:(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|org.gnome.SystemMonitor)"
      
      # VPN et autres
      "float,title:(Proton VPN)"
      "opaque,title:(Proton VPN)"
      "float,class:(xdg-desktop-portal-gtk)"
      "float,class:(codium|codium-url-handler|VSCodium|code-oss),title:(Add Folder to Workspace)"
      
      # Transparence applications
      "opacity 0.9 0.8,class:^(vesktop)$"
      "opacity 0.9 0.7,class:^(firefox|Firefox-esr|librewolf|floorp)$"
      "opacity 0.8 0.6,class:^(pcmanfm-qt)$"
      "opacity 0.9 0.8,class:^(kitty|com.mitchellh.ghostty)$"
      "opacity 0.9 0.7,class:^([Rr]ofi|gedit|codium|codium-url-handler|yad|com.obsproject.Studio|com.github.neithern.g4music|page.kramo.Cartridges)$"
      
      # Exceptions opacite pour streaming
      "opaque,class:^(librewolf|floorp|zen-beta),title:(.*)([Tt]witch|[Yy]ou[Tt]ube)(.*)"
      "stayfocused,class:^(gcr-prompter|polkit-gnome-authentication-agent-1)$"
      
      # Inhiber mise en veille pour plein ecran
      "idleinhibit fullscreen,class:^(*)$"
      "idleinhibit fullscreen,title:^(*)$"
      "idleinhibit fullscreen,fullscreen:1"
      
      # Ignorer demandes maximisation
      "suppressevent maximize,class:.*"
      
      # Thunar
      "opacity 0.9 0.8,class:^([Tt]hunar)$"
      "float,class:^([Tt]hunar),title:(Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)$"
      "center,class:^([Tt]hunar),title:(Opération sur des fichiers en cours|Confirmer le remplacement de fichiers)$"
      
      # qBittorrent
      "workspace 3,class:^(org.qbittorrent.qBittorrent)$"
      "monitor 2,class:^(org.qbittorrent.qBittorrent)$"
      
      # Steam
      "monitor DP-2,title:^([Ss]team)$"
      "workspace 1,title:^([Ss]team)$"
      "center 1,title:^([Ss]team)$"
      "opaque,title:^([Ss]team)$"
      "size 1250 775,title:^([Ss]team)$"
      "float,class:^([Ss]team)$"
      "float,class:([Ss]team)$,title:^(Paramètres Steam|Steam Settings|Lancement...)$"
      "center 1,class:^([Ss]team)$,title:^(Paramètres Steam|Steam Settings|Lancement...)$"
      "monitor DP-2,class:^steam_app_\\d+$"
      "workspace 4,class:^steam_app_\\d+$"
      "fullscreen,class:^steam_app_\\d+$"
      "stayfocused,title:^()$,class:^([Ss]team)$"
      "minsize 1 1,title:^()$,class:^([Ss]team)$"
      
      # Dark Age of Camelot
      "float,title:^(Eden Launcher)$"
      "opaque,title:^(Eden Launcher)$"
      "monitor DP-2,class:^(edenlauncher.exe)$"
      "workspace 1,class:^(edenlauncher.exe)$"
      "monitor DP-2,class:^(game.dll)$"
      "workspace 4,class:^(game.dll)$"
      "fullscreen,class:^(game.dll)$"
      
      # Genshin Impact
      "monitor DP-2,class:^(genshinimpact.exe)$"
      "workspace 4,class:^(genshinimpact.exe)$"
      "fullscreen,class:^(genshinimpact.exe)$"
      
      # Cave of Qud
      "monitor DP-2,class:^(CoQ.x86_64)$"
      "workspace 4,class:^(CoQ.x86_64)$"
      "fullscreen,class:^(CoQ.x86_64)$"
      
      # Picture-in-Picture
      "opacity 0.95 0.75,title:^(Picture-in-Picture)$"
      "pin,title:^(Picture-in-Picture)$"
      "float,title:^(Incrustation vidéo)$"
      "float,title:^(floorp)$"
      "size 25% 25%,title:^(Picture-in-Picture)$"
      "move 72% 7%,title:^(Picture-in-Picture)$"
    ];

    # REGLES FENETRES V2 (pour syntaxe plus avancee)
    windowrulev2 = [
      "float,class:^(thunar)$,title:^(.*[Rr]enommer.*)$"
      "size 400 150,class:^(thunar)$,title:^(.*[Rr]enommer.*)$"
      "center,class:^(thunar)$,title:^(.*[Rr]enommer.*)$"
      "forcergbx,class:^(OrcaSlicer)$"
    ];
  };
}
