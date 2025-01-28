{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zed-editor ];
  home-manager.users.${settings.users.user1.username} = {
    programs.zed-editor = { enable = true; };
  };
}
