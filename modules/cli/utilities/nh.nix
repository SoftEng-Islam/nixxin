{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username}.programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = settings.common.dotfilesDir;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
