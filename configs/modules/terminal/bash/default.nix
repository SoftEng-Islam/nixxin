{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bash ];
  home-manager.users.${settings.username} = {
    programs.bash = { enable = true; };
  };
}
