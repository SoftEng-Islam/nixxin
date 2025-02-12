{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zed-editor ];
  home-manager.users.${settings.user.username} = {
    programs.zed-editor = { enable = true; };
  };
}
