{ mySettings, ... }: {
  home-manager.users.${mySettings.username} = {
    imports = [
      # ./autostart.nix
      # ./extensions.nix
      # ./settings.nix
    ];
  };
}
