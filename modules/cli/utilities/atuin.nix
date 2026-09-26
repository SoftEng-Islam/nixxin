{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username}.programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
