{
  settings,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.kiro = {
      enable = true;
      package = pkgs.update.kiro;
    };
  };
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    # kiro
  ];
}
