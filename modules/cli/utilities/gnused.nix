{settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username}.home.packages = [
    pkgs.gnused
  ];
}
