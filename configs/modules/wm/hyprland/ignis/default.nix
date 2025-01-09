{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/ignis".source = ./ignis;

  };
}
