{ pkgs, inputs, quickshell, ... }:
{
  # install package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
  ];
  # import the nixos module
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = true;

  #home-manager.users.cornelis = {
    # import the home manager module
    #imports = [
    #  inputs.noctalia.homeModules.default
    #];
  #};
}