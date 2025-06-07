{ pkgs, config, lib, ... }:

{
  # Systèmes de fichiers supportés au démarrage
  boot.supportedFilesystems = [ "ntfs" "cifs" "nfs" ];

  fileSystems."/WD_Black_Steam" = {
    device = "/dev/disk/by-uuid/c303d8a7-a173-426f-aa8b-533ef2bd2cc3";
    fsType = "ext4";
    options = [
      "nofail"
      "x-gvfs-show"
      "noatime"
      "nodiratime"
      "discard"
    ];
  };
    
  fileSystems."/840_Evo_GoG" = {
    device = "/dev/disk/by-uuid/a73bf865-e533-4eaa-8f3b-b4fec486e75c";
    fsType = "ext4";
    options = [
      "nofail"
      "x-gvfs-show"
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  fileSystems."/HDD_Samsung" = {
    device = "/dev/disk/by-uuid/6CFC488D763AB490";
    fsType = "ntfs";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
      "rw"
      "umask=000"
      "x-gvfs-show"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
    ];
  };
  
  # Activer le serveur NFS
  services.nfs.server.enable = true;
  
  # Configuration centralisée des exports NFS
  services.nfs.server.exports = ''
    /export           192.168.1.0/24(rw,fsid=0,no_subtree_check)
    /export/Documents 192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    /export/Games     192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    /export/Images    192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    /export/Media     192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    /export/Private   192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
    /export/Softwares 192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
  '';

  # Ouvrir le port du firewall
  networking.firewall.allowedTCPPorts = [ 2049 ];

  fileSystems."/mnt/Documents" = {
    device = "192.168.1.83:/volume1/Documents";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
      "x-systemd.idle-timeout=600" 
    ];
  };

  fileSystems."/mnt/Games" = {
    device = "192.168.1.83:/volume1/Games";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
      "x-systemd.idle-timeout=600" 
    ];
  };

  fileSystems."/mnt/Images" = {
    device = "192.168.1.83:/volume1/Images";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
      "x-systemd.idle-timeout=600" 
    ];
  };

  fileSystems."/mnt/Media" = {
    device = "192.168.1.83:/volume1/Media";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
    ];
  };

  fileSystems."/mnt/Private" = {
    device = "192.168.1.83:/volume1/Private";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
    ];
  };

  fileSystems."/mnt/Softwares" = {
    device = "192.168.1.83:/volume1/Softwares";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount" 
      "x-systemd.mount-timeout=90" 
      "x-systemd.after=graphical-session.target"
    ];
  };
  
  # Paquets essentiels pour la gestion des systèmes de fichiers
  environment.systemPackages = with pkgs; [
    cifs-utils
    ntfs3g
    nfs-utils
  ];
}