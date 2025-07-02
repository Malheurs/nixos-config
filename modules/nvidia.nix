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
      enable = true;
    };
    open = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  
  # To pin a specific package
  #  package = (config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs {
  #    src = pkgs.fetchurl {
  #      url = "https://download.nvidia.com/XFree86/Linux-x86_64/575.57.08/NVIDIA-Linux-x86_64-575.57.08.run";
  #      sha256 = "sha256-KqcB2sGAp7IKbleMzNkB3tjUTlfWBYDwj50o3R//xvI=";
  #    };
  #  });
  };
  
  # Optimisations spécifiques Wayland + NVIDIA
    boot.extraModprobeConfig = ''
    options nvidia_drm modeset=1 fbdev=1
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_InitializeSystemMemoryAllocations=0
  '';
}
