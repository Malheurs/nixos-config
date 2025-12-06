{ config, pkgs, inputs, lib, ... }: 

{
  imports = [
    ./modules/hyprland-user.nix
  ];

  home.username = "cornelis";
  home.homeDirectory = "/home/cornelis";

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
