{ settings, config, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/fuzzel/fuzzel.ini" = {
      executable = true;
      text = ''
        font="${config.stylix.fonts.serif.name}"
      '';
    };
  };
}
