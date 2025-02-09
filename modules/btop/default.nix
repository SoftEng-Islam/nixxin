{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    # programs.btop = {
    #   enable = true;
    #   settings = {
    #     # color_theme = "rose-pine";
    #     # theme_background = false;
    #   };
    # };
    # ---- Themes ---- #
    home.file.".config/btop/btop.conf".source = ./btop.conf;
    # home.file.".config/btop/themes".source = ./themes;
  };
  environment.systemPackages = with pkgs;
    [
      btop
      # btop-rocm
    ];
}
