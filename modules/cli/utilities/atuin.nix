{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username}.programs.atuin = {
    enable = true;
    package = pkgs.atuin;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
