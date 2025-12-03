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
   # open = true;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;

   # package = config.boot.kernelPackages.nvidiaPackages.latest;
  
  # To pin a specific package
    package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs (oldAttrs: {
      src = pkgs.fetchurl {
        url = "https://download.nvidia.com/XFree86/Linux-x86_64/590.44.01/NVIDIA-Linux-x86_64-590.44.01.run";
        sha256 = "sha256-VbkVaKwElaazojfxkHnz/nN/5olk13ezkw/EQjhKPms=";
      };
      version = "590.54.01";
    });
  };
  
  # Optimisations spécifiques Wayland + NVIDIA
    boot.extraModprobeConfig = ''
    options nvidia_drm modeset=1 fbdev=1
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_InitializeSystemMemoryAllocations=0
  '';
}
