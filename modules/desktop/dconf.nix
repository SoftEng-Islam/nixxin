{ settings, lib, pkgs, ... }:
let
  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

  # Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
  # dconf write /org/gnome/mutter/debug/enable-frame-timing false
  # gsettings set org.gnome.mutter check-alive-timeout 0

in with lib.gvariant; {
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs;
    [
      dconf
      # gsettings-desktop-schemas
    ];

  home-manager.users.${settings.user.username} = {
    dconf.settings = {
      "org/gnome/nautilus/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "owner"
          "group"
          "permissions"
          "where"
          "date_modified"
          "date_modified_with_time"
          "date_accessed"
          "recency"
          "starred"
          "detailed_type"
        ];
        default-visible-columns = [ "name" "size" "type" "owner" ];
      };

      "org/gnome/desktop/wm/preferences" = {
        # We don't want buttons because of using ( Hyprland + hyprbars)
        "button-layout" = lib.mkDefault "";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        "speed" = 1;
        "accel-profile" = "adaptive";
        "natural-scroll" = false;
        "double-click" = 600;
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        "delay" = 200;
        "repeat-interval" = 10;
      };

      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "icon-view"; # "icon-view", "list-view"
        "migrated-gtk-settings" = true;
        "search-filter-time-type" = "last_modified";
        "search-view" = "list-view";
      };

      "org/gtk/gtk4/settings/file-chooser" = { "show-hidden" = true; };

      "org/gtk/settings/file-chooser" = {
        "date-format" = "regular";
        "location-mode" = "path-bar";
        "show-hidden" = true;
        "show-size-column" = true;
        "show-type-column" = true;
        "sort-column" = "name";
        "sort-directories-first" = false;
        "sort-order" = "ascending";
        "type-format" = "category";
        "view-type" = "list";
      };

      # To list your enabled GNOME Shell extensions, you can use the gnome-extensions command-line tool, which provides various options for managing extensions.
      # gnome-extensions list --enabled
      "org/gnome/shell" = { disable-user-extensions = true; };
      # dconf read /org/freedesktop/Tracker3/Miner/Files/enable-monitors
      "org/freedesktop/Tracker3/Miner/Files/enable-monitors" = {
        enable-monitors = false;
      };

      # Run this Command In the terminal to get list of options:
      # gsettings list-keys org.gnome.desktop.interface

      # gsettings get org.gnome.desktop.interface font-antialiasing
      # 'grayscale'
      "org/gnome/desktop/interface" = {
        # accent-color
        # avatar-directories
        can-change-accels = false;
        clock-format = "12h";
        clock-show-date = true;
        clock-show-seconds = false;
        clock-show-weekday = true;
        color-scheme = settings.modules.desktop.dconf.colorScheme;
        cursor-blink = true;
        cursor-blink-time = 500;
        cursor-blink-timeout = 10;
        cursor-size = settings.common.cursor.size;
        cursor-theme = settings.common.cursor.name;
        enable-animations = true;
        # enable-hot-corners

        # ---- Fonts ---- #
        font-name = lib.mkForce "${settings.modules.fonts.main.name} ${
            toString settings.modules.fonts.main.size.main
          }";
        document-font-name = lib.mkForce settings.modules.fonts.main.name;
        font-hinting = lib.mkForce settings.modules.fonts.main.hinting;
        font-rendering = lib.mkForce settings.modules.fonts.main.rendering;
        font-antialiasing =
          lib.mkForce settings.modules.fonts.main.antialiasing;
        font-rgba-order = lib.mkForce settings.modules.fonts.main.rgba_order;

        # gtk-color-palette

        # $ gsettings describe org.gnome.desktop.interface gtk-color-scheme
        # $ gsettings get org.gnome.desktop.interface gtk-color-scheme
        # gtk-color-scheme = lib.mkForce "${settings.modules.dconf.colorScheme}";

        # gtk-enable-primary-paste
        # gtk-im-module
        # gtk-im-preedit-style
        # gtk-im-status-style
        # gtk-key-theme
        gtk-theme = lib.mkForce "${settings.common.gtk.theme}";
        # gtk-timeout-initial
        # gtk-timeout-repeat
        icon-theme = "${settings.modules.desktop.dconf.icons.nameInDark}";
        # locate-pointer
        # menubar-accel
        # menubar-detachable
        # menus-have-tearoff
        # monospace-font-name
        # overlay-scrolling
        # scaling-factor
        # show-battery-percentage
        # text-scaling-factor
        # toolbar-detachable
        # toolbar-icons-size
        # toolbar-style
        # toolkit-accessibility
      };
      # gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
      # gsettings set org.gnome.nautilus.preferences thumbnail-limit 104857600
      "org/gnome/desktop/thumbnail-cache" = {
        maximum-age = 200;
        maximum-size = 2048;
      };

      "org/gnome/mutter" = { "check-alive-timeout" = 60000; };
    };
  };
}
