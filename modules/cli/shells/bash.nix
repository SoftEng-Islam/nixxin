{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bash ];
  home-manager.users.${settings.user.username} = {
    programs.bash = { enable = true; };
  };
}
