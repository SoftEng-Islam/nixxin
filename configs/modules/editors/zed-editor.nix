{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zed-editor ];
  home-manager.users.${settings.username} = {
    programs.zed-editor = { enable = true; };
  };
}
