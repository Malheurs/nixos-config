{ config, pkgs, inputs, quickshell, ... }:
{
  # install package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  # import the nixos module
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell = {
    enable = true;
  };
    home-manager.users.cornelis = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # configure options
    #settings = {
        # configure noctalia here; defaults will
        # be deep merged with these attributes.
        #bar = {
        #  density = "compact";
        #  };
        #};
        #location = {
        #  monthBeforeDay = true;
        #  name = "Marseille, France";
        #};
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
}