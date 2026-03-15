{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.bash = { enable = true; };
  };
}
