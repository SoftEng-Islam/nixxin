{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    home.file.".config/noctalia/udiskie.toml".text = ''
      [plugins]
      enabled = ["aristides/udiskie"]

      [[plugins.source]]
      name = "nix-community-plugins"
      kind = "path"
      location = "${inputs."noctalia-community-plugins"}"

      [plugin_settings."aristides/udiskie"]
      enable_notifications = false
    '';
  };
}
