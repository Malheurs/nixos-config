{ config, pkgs, inputs, pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    caelestia-shell.packages.<system>.default
  ];
}