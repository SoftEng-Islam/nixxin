{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.user1.username} = {
    programs.btop = {
      enable = true;
      settings = {
        # color_theme = "rose-pine";
        # theme_background = false;
      };
    };
    # btop themes
    # home.file.".config/btop/themes".source = ./themes;
  };
  environment.systemPackages = with pkgs;
    [
      btop
      # btop-rocm
    ];
}
