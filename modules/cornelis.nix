{ pkgs, config, inputs, pkgs-unstable, lib, ... }:

{
  nixpkgs.overlays = [ (final: prev: { unstable = pkgs-unstable; }) ];

  users.users.cornelis = {
    isNormalUser = true;
    description = "Cornelis";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "libvirtd" "wireshark" "gamemode" "realtime" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      ### 3D Modeling & Printing ###
      unstable.blender # 3D Creation/Animation/Publishing System
      #unstable.orca-slicer # G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)
      
      ### Cloud Storage & Sync ###
      synology-drive-client # Desktop application to synchronize files and folders between the computer and the Synology Drive server

      ### Development - Code Formating ###
      nixpkgs-fmt # Nix code formatter for nixpkgs

      ### Development - Dotfiles & Config ###
      chezmoi # Manage your dotfiles across multiple machines, securely

      ### Development - Game Engines ###
      godot_4 # Free and Open Source 2D and 3D game engine

      ### Development - Languages ###
      python3Full # High-level dynamically-typed programming language

      ### Development - Web & Static Sites ###
      unstable.hugo # A fast and modern static website engine

      ### Download Managers ###
      media-downloader # Youtube Downloader
      qbittorrent # Featureful free software BitTorrent client
      unstable.varia # Simple download manager based on aria2 and libadwaita

      ### File Sharing & Transfer ###
      rsync # Fast incremental file transfer utility
      warp # Sharing files tools

      ### Image Editing & Graphics ###
      unstable.gimp3 # The GNU Image Manipulation Program
      pinta # Drawing/editing program modeled after Paint.NET

      ### Internet Browser ###
      unstable.floorp # A fork of Firefox, focused on keeping the Open, Private and Sustainable Web alive, built in Japan
      #unstable.ladybird # Browser using the SerenityOS LibWeb engine with a Qt or Cocoa GUI
      inputs.zen-browser.packages."${pkgs.system}".default # Zen Browser is a privacy-focused web browser based on Firefox and Tor Browser - From flake

      ### Gaming Platforms & Launchers ###
      unstable.cartridges # A GTK4 + Libadwaita game launcher
      goverlay # An opensource project that aims to create a Graphical UI to help manage Linux overlays
      unstable.heroic # A Native GOG, Epic, and Amazon Games Launcher for Linux, Windows and Mac
      unstable.lutris # Open Source gaming platform for GNU/Linux
      mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
      moonlight-qt # Play your PC games on almost any device
      sunshine # Sunshine is a Game stream host for Moonlight

      ### Gaming Utilities ###
      unstable.path-of-building # Offline build planner for Path of Exile
      vesktop # Alternate client for Discord with Vencord built-in

      ### Hardware Specific ###
      qwerty-fr # Qwerty keyboard layout with French accents
      wootility # A customization and management software for Wooting keyboards
      wooting-udev-rules # udev rules that give NixOS permission to communicate with Wooting keyboards

      ### Media Players & Streaming ###
      g4music # A beautiful, fast, fluent, light weight music player written in GTK4
      obs-studio # Free and open source software for video recording and live streaming
      
      ### Media Editing & Conversion ###
      handbrake # A tool for converting video files and ripping DVDs
      mkvtoolnix # MKV container tool
      unstable.picard  # Official MusicBrainz tagger

      ### Media Viewers ###
      mcomix # Comic book reader and image viewer
      newsflash # Modern feed reader designed for the GNOME desktop

      ### Minecraft ###
      prismlauncher # Free, open source launcher for Minecraft
      modrinth-app # Modrinth's game launcher

      ### Proton Services ###
      proton-pass # Desktop application for Proton Pass
      unstable.protonvpn-gui # Proton VPN GTK app for Linux
      protonmail-desktop # Desktop application for Mail and Calendar, made with Electron

      ### Text Editors & Note Taking ###
      helix # A post-modern modal text editor
      obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files

      ### Virtualization & Compatibility ###
      appimage-run # Run AppImages
      bottles # An easy-to-use wineprefix manager

      ### Vpn ###
      wireguard-tools # Tools for the WireGuard secure network tunnel
      wireshark # Powerful network protocol analyzer

      ### Vscode free of Microsoft telemetry ###
      (vscode-with-extensions.override {
        vscode = unstable.vscodium;
        vscodeExtensions = with vscode-extensions; [
          # AI & Productivity
          vscode-extensions.github.copilot # GitHub Copilot uses OpenAI Codex to suggest code and entire functions in real-time right from your editor
          vscode-extensions.github.copilot-chat # GitHub Copilot Chat is a companion extension to GitHub Copilot that houses experimental chat features

          # Language Support
          bbenoist.nix # Extension for nix support
          ms-python.python # Extension with rich support for the Python language
          ms-python.vscode-pylance # A performant, feature-rich language server for Python in VS Code  
          vscode-extensions.jnoortheen.nix-ide # Nix IDE with formatting and error support

          # Localization
          vscode-extensions.ms-ceintl.vscode-language-pack-fr # French language pack

          # Web Development
          vscode-extensions.esbenp.prettier-vscode # Code formatter using prettier
          vscode-extensions.ritwickdey.liveserver # Local server for web dev
          vscode-extensions.formulahendry.auto-rename-tag # Automatically rename paired HTML tag

        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Custom Theme
          {
            name = "kanagawa-vscode-color-theme";
            publisher = "metaphore";
            version = "0.5.0";
            sha256 = "sha256-Os4v1zXnr+WLXyvjS8qgf3UOJHGd4lmCczjVaCArXtA=";
          }
          # Additional Web Development
          {
            name = "vscode-html-css";
            publisher = "ecmel";
            version = "2.0.13";
            sha256 = "sha256-2BtvIyeUaABsWjQNCSAk0WaGD75ecRA6yWbM/OiMyM0=";
          }
        ];
      })
    ];
  };

  programs = {
    git = {
      enable = true;
      config = {
        user = {
          name = "Malheurs";
          email = "malheurcornelis@proton.me";
        };
        init = {
          defaultBranch = "main";
        };
        safe = {
          directory = [
            "/etc/nixos"
            "/home/cornelis/.dotfiles"
          ];
        };
      };
    };
  wireshark.enable = true;
};
  
  services.displayManager = {
    sddm.enable = true; 
    sddm.wayland.enable = true;
    autoLogin = {
      enable = true;
      user = "cornelis";
    };
  };

  hardware.wooting.enable = true;

  services = {
    goxlr-utility = {
      enable = true;
    };
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  environment.sessionVariables = {
    FLAKE = "/home/cornelis/.dotfiles";
  };

  # Orca Slicer Workaround
  environment.etc."xdg/applications/Orca-Slicer.desktop".text = ''
    [Desktop Entry]
    Name=Orca-Slicer
    GenericName=3D Printing Software
    Icon=OrcaSlicer
    Exec=${lib.concatStringsSep " " [
      "${pkgs.coreutils}/bin/env"
      "__GLX_VENDOR_LIBRARY_NAME=mesa"
      "__EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
      "MESA_LOADER_DRIVER_OVERRIDE=zink"
      "GALLIUM_DRIVER=zink"
      "WEBKIT_DISABLE_DMABUF_RENDERER=1"
      "${lib.getExe pkgs.orca-slicer} %U"
    ]}
    Terminal=false
    Type=Application
    MimeType=model/stl;model/3mf;application/vnd.ms-3mfdocument;application/prs.wavefront-obj;application/x-amf;
    Categories=Graphics;3DGraphics;Engineering;
    StartupNotify=false
  '';

  # Hyprland Nvidia VRAM Workaround
  environment.etc = {
    "nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.txt" = {
      text = ''
      {
        "rules": [
            {
                "pattern": {
                "feature": "cmdline",
                "matches": "Hyprland"
            },
            "profile": "Limit Free Buffer Pool On Wayland Compositors"
        },
        {
            "pattern": {
                "feature": "cmdline",
                "matches": "hyprland"
            },
            "profile": "Limit Free Buffer Pool On Wayland Compositors"
        },
    ],
    "profiles": [
        {
            "name": "Limit Free Buffer Pool On Wayland Compositors",
            "settings": [
                {
                    "key": "GLVidHeapReuseRatio",
                    "value": 1
                }
            ]
        }
      ]
    }
    '';
    mode = "0444";
    };
  };
}
