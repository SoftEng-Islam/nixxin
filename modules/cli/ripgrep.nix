{ settings }:
{
  home-manager.users.${settings.user.username}.programs.ripgrep = {
    enable = true;
  };
}
