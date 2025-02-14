{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.resources_monitoring.enable) {
  home-manager.users.${settings.user.username} = {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "rose-pine";
        theme_background = false;
      };
    };
    # ---- Themes ---- #
    # home.file.".config/btop/btop.conf".source = ./btop.conf;
    home.file.".config/btop/themes".source = ./themes;
  };
  environment.systemPackages = with pkgs; [
    btop
    # btop-rocm

    resources # Monitor your system resources and processes
  ];
}
