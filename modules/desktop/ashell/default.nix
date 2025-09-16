{ settings, lib, pkgs, ... }:

lib.mkIf (settings.modules.desktop.ashell.enable or true) {
  home-manager.users.${settings.user.username} = {
    home.file.".config/ashell/config.toml" = {
      source = ./config.toml;
      recursive = true;
      executable = true;
    };
  };
  environment.systemPackages = with pkgs; [ ashell ];
}
