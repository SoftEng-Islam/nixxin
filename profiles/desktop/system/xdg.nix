{ pkgs, ... }: {
  environment.variables = {
    # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.softeng.uid}";
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)";
    # XDG_CURRENT_DESKTOP = "Hyprland"; #"GNOME" or "Hyprland";
    XDG_PICTURES_DIR = "~/Pictures";
    XDG_RUNTIME_DIR = "/run/user/1000";
    XDG_SCREENSHOTS_DIR = "~/Pictures/Screenshots";
    XDG_SESSION_TYPE = "wayland";

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
      extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
      configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
    };
  };
  environment.systemPackages = with pkgs; [
    xdg-dbus-proxy # DBus proxy for Flatpak and others
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gnome # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
    libxdg_basedir # Implementation of the XDG Base Directory specification
  ];
}
