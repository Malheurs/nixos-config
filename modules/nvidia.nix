{ config, lib, pkgs, ... }:

{
  # Load nvidia driver for Xorg and Wayland
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
    };
   # open = true;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;

   # package = config.boot.kernelPackages.nvidiaPackages.latest;
  
  # To pin a specific package
    package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs (oldAttrs: {
      src = pkgs.fetchurl {
        url = "https://download.nvidia.com/XFree86/Linux-x86_64/595.45.04/NVIDIA-Linux-x86_64-595.45.04.run";
        sha256 = "sha256-zUllSSRsuio7dSkcbBTuxF+dN12d6jEPE0WgGvVOj14=";
      };
      version = "595.45.04";
    });
  };
  
  # Optimisations spécifiques Wayland + NVIDIA
    boot.extraModprobeConfig = ''
    options nvidia_drm modeset=1 fbdev=1
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_InitializeSystemMemoryAllocations=0
  '';
}
