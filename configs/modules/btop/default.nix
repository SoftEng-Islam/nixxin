{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.btop = {
      enable = true;
      settings = {
        # color_theme = "Default";
        # theme_background = false;
      };
    };
  };
  environment.systemPackages = with pkgs;
    [
      btop
      # btop-rocm
    ];
}
