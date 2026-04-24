{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.eza = { enable = true; };
  };
}
