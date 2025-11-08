{ pkgs, inputs, ... }:
{
    home-manager.users.drfoobar = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];
  };
  # install package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
  ];
}