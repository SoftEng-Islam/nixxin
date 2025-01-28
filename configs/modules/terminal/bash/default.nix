{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bash ];
  home-manager.users.${settings.users.user1.username} = {
    programs.bash = { enable = true; };
  };
}
