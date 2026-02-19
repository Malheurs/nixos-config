{ pkgs, config, lib, ... }:

let
  nfsOptions = [
    "vers=4.1" "rsize=1048576" "wsize=1048576"
    "soft" "timeo=50" "retrans=1" "bg"
    "x-systemd.automount" "x-systemd.mount-timeout=30"
    "x-systemd.after=network-online.target" "_netdev"
  ];
  nfsServer = "192.168.1.83";
  mkNfsMount = vol: {
    device = "${nfsServer}:/volume1/${vol}";
    fsType = "nfs";
    options = nfsOptions;
  };
in
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
    ];
  };
    
  fileSystems."/840_Evo_GoG" = {
    device = "/dev/disk/by-uuid/a73bf865-e533-4eaa-8f3b-b4fec486e75c";
    fsType = "ext4";
    options = [
      "nofail"
      "x-gvfs-show"
      "noatime"
    ];
  };

  fileSystems."/HDD_Samsung" = {
    device = "/dev/disk/by-uuid/6CFC488D763AB490";
    fsType = "ntfs";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
      "umask=000"
      "x-gvfs-show"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=300"
    ];
  };

  fileSystems."/WD_Red_Stockage" = {
    device = "/dev/disk/by-uuid/39a1f9d0-e347-43bd-bd09-476978587865";
    fsType = "ext4";
    options = [
      "nofail"
      "noatime"
      "x-gvfs-show"
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

  # Configuration optimisée pour les volumes pleins
  fileSystems."/mnt/Documents" = mkNfsMount "Documents";
  fileSystems."/mnt/Games"     = mkNfsMount "Games";
  fileSystems."/mnt/Images"    = mkNfsMount "Images";
  fileSystems."/mnt/Softwares" = mkNfsMount "Softwares";
  fileSystems."/mnt/Media" = {
    device = "192.168.1.83:/volume1/Media";
    fsType = "nfs";
    options = [ 
      "vers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "soft"
      "timeo=50"
      "retrans=1"
      "bg"
      "x-systemd.automount" 
      "x-systemd.mount-timeout=30"
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
      "soft"
      "timeo=50"
      "retrans=1"
      "bg"
      "x-systemd.automount" 
      "x-systemd.mount-timeout=30"
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