{
  settings,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    packages = with pkgs; [
      #
      # kiro
      update.kiro
    ];
  };
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    # kiro
  ];
}
