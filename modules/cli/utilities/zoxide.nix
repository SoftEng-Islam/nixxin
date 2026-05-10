{ settings, ... }:
{
  home-manager.users.${settings.user.username}.programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
