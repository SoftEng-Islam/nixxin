{
  settings,
  pkgs,
  inputs,
  lib,
  utils,
  ...
}:
with utils.lib;
{
  imports = [
    ./greeter.nix
  ];

  home-manager.users.${settings.user.username} = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia = {
      enable = true;
      settings = (importDir ./settings { inherit lib; });
    };
  };

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  environment.systemPackages = with pkgs; [
    # Noctalia Shell
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Noctalia screenshot plugin needs this package
    hyprshot
  ];
}
