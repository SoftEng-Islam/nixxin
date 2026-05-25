{
  settings,
  inputs,
  pkgs,
  ...
}:
{
  # home-manager.users.${settings.user.username} = {
  # };
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    # kiro
    # update.kiro
  ];
}
