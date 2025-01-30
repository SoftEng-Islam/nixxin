{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bash ];
  home-manager.users.${settings.users.selected.username} = {
    programs.bash = { enable = true; };
  };
}
