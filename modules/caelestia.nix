{ config, pkgs, inputs, pkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
  ];
}