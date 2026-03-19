{
  inputs,
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    hypridle.enable = true;
    services.hypridle.settings.general.lock_cmd = "noctalia-shell ipc call lockScreen lock";
  };
  environment.systemPackages = with pkgs; [
    hypridle
  ];
}
