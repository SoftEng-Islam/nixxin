{
  settings,
  lib,
  pkgs,
  ...
}:
{
  xdg.portal = {
    #   # Enable XDG portals, which allow sandboxed applications
    #   # (e.g., Flatpak or Snap) to interact with the system securely.
    enable = true;

    #   # Add the xdg-desktop-portal package as an extra portal service.
    #   # This package provides key portal services such as file access,
    #   # printing, and screenshots for sandboxed apps.
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    #   # Set the default access configuration for portals.
    #   # The "*" wildcard here allows all sandboxed applications
    #   # to access available portals, providing them with broad access
    #   # to system resources like file dialogs and screen sharing.
    config = {
      common.default = "*";
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        # "org.freedesktop.impl.portal.Filechooser" = [
        #   "kde"
        # ];
      };
    };
  };
}
