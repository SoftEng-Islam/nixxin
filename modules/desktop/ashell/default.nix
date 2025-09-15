{ settings, lib, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    home.file.".config/ashell" = {
      source = ./ashell;
      recursive = true;
      executable = true;
    };
  };
  environment.systemPackages = with pkgs; [ ashell ];
}
