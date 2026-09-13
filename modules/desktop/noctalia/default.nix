{
  settings,
  pkgs,
  inputs,
  lib,
  forge,
  ...
}:
with forge.lib;
{
  imports = [
    ./greeter.nix
  ];

  home-manager.users.${settings.user.username} = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    home.file = {
      "noctalia/captures/.keep".text = "";
      "noctalia/records/.keep".text = "";
      "noctalia/covers/anime/.keep".text = "";
      "noctalia/covers/manga/.keep".text = "";
      "noctalia/videos/.keep".text = "";
      "noctalia/notes/.keep".text = "";
      # Install Noctalia plugins from inputs
      "noctalia/plugins/notes".source = "${inputs.noctalia-official-plugins}/notes";
      "noctalia/plugins/bongocat".source = "${inputs.noctalia-official-plugins}/bongocat";
    };
    programs.noctalia = {
      enable = true;
      settings = (
        importDir ./settings {
          inherit
            pkgs
            lib
            settings
            inputs
            ;
        }
      );
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
    udiskie
  ];
}
