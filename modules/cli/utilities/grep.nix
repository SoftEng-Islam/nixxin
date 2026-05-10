{ pkgs, ... }:
{
  home-manager.users.${settings.user.username}.home.packages = with pkgs; [
    gnugrep
  ];
}
