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

  # Augmenter le nombre de threads NFS pour de meilleures performances
  services.nfs.server.nproc = 16;
  
  # Configuration centralisée des exports NFS
  services.nfs.server.exports = ''
    /export           192.168.1.0/24(rw,fsid=0,no_subtree_check,async,no_root_squash)
    /export/Documents 192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
    /export/Games     192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
    /export/Images    192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
    /export/Media     192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
    /export/Private   192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
    /export/Softwares 192.168.1.0/24(rw,nohide,insecure,no_subtree_check,async,no_root_squash)
  '';

  # Ouvrir le port du firewall
  networking.firewall.allowedTCPPorts = [ 2049 111 ];
  networking.firewall.allowedUDPPorts = [ 2049 111 ];

  fileSystems."/mnt/Documents" = {
    device = "192.168.1.83:/volume1/Documents";
    fsType = "nfs";
    options = [ 
      "vers=4.1"                              # Utiliser NFSv4.1 pour de meilleures performances
      "rsize=1048576"                         # Taille de lecture augmentée (1MB)
      "wsize=1048576"                         # Taille d'écriture augmentée (1MB)
      "hard"                                  # Montage dur pour éviter la corruption
      "intr"                                  # Permettre l'interruption
      "timeo=600"                             # Timeout augmenté à 60 secondes (600 dixièmes)
      "retrans=2"                             # Nombre de retransmissions
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=180"           # Timeout de montage augmenté
      "x-systemd.after=network-online.target"
      "x-systemd.idle-timeout=1200"           # Timeout d'inactivité augmenté (20 min)
      "_netdev"                               # Montage réseau
    ];
  };

  fileSystems."/mnt/Games" = {
    device = "192.168.1.83:/volume1/Games";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "intr"
      "timeo=600"
      "retrans=2"
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=180"
      "x-systemd.after=network-online.target"
      "x-systemd.idle-timeout=1200"
      "_netdev" 
    ];
  };

  fileSystems."/mnt/Images" = {
    device = "192.168.1.83:/volume1/Images";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "intr"
      "timeo=600"
      "retrans=2"
      "x-systemd.automount" 
      "noauto" 
      "x-systemd.mount-timeout=180"
      "x-systemd.after=network-online.target"
      "x-systemd.idle-timeout=1200"
      "_netdev"
    ];
  };

  fileSystems."/mnt/Media" = {
    device = "192.168.1.83:/volume1/Media";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "intr"
      "timeo=600"
      "retrans=2"
      "x-systemd.automount" 
      "x-systemd.mount-timeout=180"
      "x-systemd.after=network-online.target"
      "_netdev"
    ];
  };

  fileSystems."/mnt/Private" = {
    device = "192.168.1.83:/volume1/Private";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "intr"
      "timeo=600"
      "retrans=2"
      "x-systemd.automount" 
      "x-systemd.mount-timeout=180"
      "x-systemd.after=network-online.target"
      "_netdev"
    ];
  };

  fileSystems."/mnt/Softwares" = {
    device = "192.168.1.83:/volume1/Softwares";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "intr"
      "timeo=600"
      "retrans=2"
      "x-systemd.automount" 
      "x-systemd.mount-timeout=180"
      "x-systemd.after=network-online.target"
      "_netdev"
    ];
  };
  
  # Paquets essentiels pour la gestion des systèmes de fichiers
  environment.systemPackages = with pkgs; [
    cifs-utils
    ntfs3g
    nfs-utils
  ];
}