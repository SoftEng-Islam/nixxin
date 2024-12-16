{ pkgs, ... }: {
  environment.variables = {
    # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.softeng.uid}";
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    XDG_RUNTIME_DIR = "/run/user/1000";
    XDG_SESSION_TYPE = "wayland";
    # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";
  };
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      config = {
        # common.default = ["gtk"];
        hyprland.default = [ "hyprland" ];
      };
    };
  };
}
