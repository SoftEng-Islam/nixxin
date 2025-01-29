{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zed-editor ];
  home-manager.users.${settings.users.selected.username} = {
    programs.zed-editor = { enable = true; };
  };
}
