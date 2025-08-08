{ config, pkgs, inputs, outputs, lib, pkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Hardware configuration
      ./modules/cornelis.nix # User - That's me
      ./modules/disk.nix # Disk, filesystem & NFS mount
      ./modules/gaming.nix # Steam, Genshin Impact & 8bitdo controller
      ./modules/hyprland.nix # Hyprland Display Manager & config
      ./modules/linux-kernel.nix # Linux Kernel config
      ./modules/nvidia.nix # Nvidia drivers & config
    ];
  
  nixpkgs.overlays = [ (final: prev: { unstable = pkgs-unstable; }) ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = "auto";
    cores = 0;
    sandbox = true;
    eval-cache = true;
    auto-optimise-store = true;
    substituters = [
      "https://cache.nixos.org/"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = 1;
    };
    initrd = {
      enable = true;
      systemd.enable = true;
      compressor = "zstd";
      compressorArgs = [ "-1" "-T0" ];
    };
    plymouth.enable = true; ### Change for SDDM
    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
    };
  };

  networking = {
    hostName = "NixOS";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    interfaces.enp5s0 = {
      useDHCP = true;
    };
    dhcpcd.extraConfig = ''
      nooption domain_name_servers
      nooption domain_name
      nooption domain_search
    '';
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::9" "2620:fe::fe" ];
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Paris";
  };
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = lib.genAttrs [
      "LC_ADDRESS" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MONETARY"
      "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME"
    ] (_: "fr_FR.UTF-8");
  };
  console.keyMap = "fr";

  services.xserver.xkb = {
    layout = "qwerty-fr";
    extraLayouts.qwerty-fr = {
      description = "US keyboard with french symbols - AltGr combination";
      languages = [ "eng" ];
      symbolsFile = ./symbols/us_qwerty-fr;
    };
  };

  fonts.packages = with pkgs; [
    dejavu_fonts fira-code font-awesome_5 font-awesome_4 google-fonts hack-font jetbrains-mono 
    line-awesome noto-fonts-cjk-sans noto-fonts-cjk-serif ipafont kochi-substitute takao weather-icons
  ] ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)); # All Nerd Fonts

  services = {
    flatpak.enable = true;
    gvfs.enable = true; # USB Automounting
    gnome.gnome-keyring.enable = true;
    geoclue2.enable = true;
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ xfce.xfconf gnome2.GConf ];
    };
    mpd.enable = false;
    tumbler.enable = true;
    fwupd.enable = false;
    auto-cpufreq.enable = true;
    envfs.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 7d";
      };
      flake = "/home/cornelis/.dotfiles";
    };
    fish = {
      enable = true;
      shellInit = "set fish_greeting
        microfetch
        starship init fish | source
        zoxide init fish | source
        if status is-interactive
        end";
    };
    dconf.enable = true;
    direnv.enable = true;
    thunar.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services = {
      cornelis.enableGnomeKeyring = true;
      swaylock = {};
    };
  };

  systemd = {
    packages = with pkgs; [ auto-cpufreq ]; # Automatic CPU speed & power optimizer for Linux
    services = {
      NetworkManager-wait-online.serviceConfig.TimeoutSec = 1;
      flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
      };
    };
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "multi-user.target" ];
      wants = [ "multi-user.target" ];
      after = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  # Virtualisation
  #programs.virt-manager.enable = true;
  #users.groups.libvirtd.members = ["cornelis"];
  #virtualisation.libvirtd.enable = true;
  #virtualisation.spiceUSBRedirection.enable = true;

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    ### Accessibility ###
    at-spi2-atk # Interface protocol definitions and daemon for D-Bus

    ### Audio ###
    pamixer # Pulseaudio command line mixer
    pulsemixer # Cli and curses mixer for pulseaudio
    pavucontrol # PulseAudio Volume Control
    goxlr-utility # An unofficial GoXLR App replacement for Linux

    ### Development Tools ###
    gettext # Required for building things
    glib.dev # C library of programming building blocks
    gnumake # Make command
    nix-fast-build # Combine the power of nix-eval-jobs with nix-output-monitor to speed-up your evaluation and building process

    ### Files Managers & Archves ###
    file-roller # Archive manager
    lf # A terminal file manager written in Go and heavily inspired by ranger
    yazi # Blazing fast terminal file manager written in Rust, based on async I/O
    zip # Zip command
    unzip # Unzip command

    ### Graphics & 3D ###
    mesa # Open source 3D graphics library
    libGL # GL Vendor-Neutral Dispatch library
    libGLU # OpenGL utility library

    ### Gnome Applications ###
    blueberry # Bluetooth configuration tool
    glib # For gsettings to work  
    gnome-disk-utility # Disk utilitary
    gnome-software # GUI install Flatpak

    ### Media & Multimedia ###
    mpv # General-purpose media player, fork of MPlayer and mplayer2
    imv # A command line image viewer for tiling window managers
    ffmpeg_6-full # Cross-platform solution to record, convert and stream audio and video

    ### Navigation & Search ###
    fzf # Command-line fuzzy finder written in Go
    tldr # Simplified and community-driven man pages
    zoxide # Fast cd command that learns your habits

    ### Network Tools ###
    dig # Domain name server
    wget # Wget command

    ### Office & Productivity ###
    gedit # File editor
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org

    ### Security ###
    unstable.lynis # Security auditing tool for Linux, macOS, and UNIX-based systems

    ### System Fetch Tools ###
    fastfetch # An actively maintained, feature-rich and performance oriented, neofetch like system information tool
    ipfetch # Neofetch for ip adresses
    microfetch # Microscopic fetch script in Rust, for NixOS systems
    starfetch # CLI star constellations displayer
    
    ### System Monitoring & Info ###
    baobab # Graphical application to analyse disk usage in any GNOME environment
    bottom # A cross-platform graphical process/system monitor with a customizable interface
    btop # A monitor of resources
    dysk # Get information on your mounted disks
    htop # An interactive process viewer
    kmon # Linux Kernel Manager and Activity Monitor
    mission-center # Monitor your CPU, Memory, Disk, Network and GPU usage
    nvtopPackages.full # A (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs

    ### Theming & Appearance ###
    bibata-cursors # Cursor theme
    gtk-engine-murrine # Needed for a lot of GTK components
    kanagawa-gtk-theme # A GTK theme with the Kanagawa colour palette
    kanagawa-icon-theme # An icon theme for the Kanagawa colour palette
    libsForQt5.qt5ct # QT5 theming
    linux-wallpaperengine # Wallpaper Engine backgrounds for Linux

    ### Terminal ###
    bash # Shell for convenience with downloaded script & other
    ghostty-patched # Fast, native, feature-rich terminal emulator pushing modern features
    starship # A minimal, blazing fast, and extremely customizable prompt for any shell
    
    ### Terminal bullshit ###
    asciiquarium # Enjoy the mysteries of the sea from the safety of your own terminal!
    cava # Console-based Audio Visualizer for Alsa
    cbonsai # Grow bonsai trees in your terminal
    cmatrix # Simulates the falling characters theme from The Matrix movie
    figlet # Program for making large letters out of ordinary text
    gti # Humorous typo-based git runner; drives a car over the terminal
    nyancat # Nyancat in your terminal, rendered through ANSI escape sequences
    pipes-rs # An over-engineered rewrite of pipes.sh in Rust
    rsclock # A simple terminal clock written in Rust
    tty-clock # Digital clock in ncurses
    
    ### USB specific packages ###
    usbutils # Tools for working with USB devices, such as lsusb

    ### Utilities ###
    home-manager # Nix-based user environment configurator
    jq # A lightweight and flexible command-line JSON processor
    killall # Kill all command
    yad # GUI dialog tool for shell scripts

    ### Version Control (Git) ###
    gitu # A TUI Git client inspired by Magit
    gitui # Blazing fast terminal-ui for Git written in Rust
    git-ignore # Fetch .gitignore templates from gitignore.io
    git-credential-manager # A secure, cross-platform Git credential storage with authentication to GitHub, Azure Repos, and other popular Git hosting services
    gh # GitHub CLI tool
    lazygit # Simple terminal UI for git commands
    pass-git-helper # A git credential helper interfacing with pass, the standard unix password manager

    ### Wine ###
    winePackages.waylandFull # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    winetricks # Script to install DLLs needed to work around problems in Wine
  ];

  system.stateVersion = "22.11";

}
