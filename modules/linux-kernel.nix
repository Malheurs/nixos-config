{ config, pkgs, lib, ... }:

#let
#  kernel = pkgs.linuxPackages_cachyos.kernel; # Workaround for modules kernel 6,12+
#in
{
  boot.kernelParams = [ 
  "pcie_aspm=off" 
  "nvidia.NVreg_EnableResizableBar=1"  # Pour les GPU NVIDIA
  "mitigations=off"  # Meilleures performances, désactive certaines mitigations de sécurité
  "preempt=full"     # Préemption complète pour meilleure interactivité
  "iommu=pt"         # Performance I/O
  ];

  # Linux Kernel - CachyOS
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest; # New repo

  # Paramètres de performance
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;                   # Moins d'utilisation du swap
    "vm.vfs_cache_pressure" = 50;           # Garde les inodes en cache plus longtemps
    "vm.dirty_background_ratio" = 5;        # Écriture en arrière-plan plus tôt
    "vm.dirty_ratio" = 10;                  # Commencer à écrire plus tôt
    "kernel.nmi_watchdog" = 0;              # Désactiver watchdog pour économiser CPU
    "net.core.rmem_max" = 16777216;         # Augmentation de la taille des buffers réseau
    "net.core.wmem_max" = 16777216;
    "net.core.rmem_default" = 262144;
    "net.core.wmem_default" = 262144;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_congestion_control" = "bbr"; # Algorithme BBR pour meilleure performance réseau
  };
}
