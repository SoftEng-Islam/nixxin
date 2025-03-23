{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  # you can try this command if you have any problem with gnome settings
  # dconf reset -f /org/gnome/

  # Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
  # dconf write /org/gnome/mutter/debug/enable-frame-timing false
  # gsettings set org.gnome.mutter check-alive-timeout 0

in with lib.gvariant;
mkIf (settings.modules.dconf.enable or true) {
  programs.dconf.enable = true; # dconf
  environment.systemPackages = with pkgs;
    [
      dconf # dconf is a simple key/value storage system that is heavily optimised for reading.
      # dconf-editor # GSettings editor for GNOME
    ];

  home-manager.users.${settings.user.username} = {
    dconf.settings = {

      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = lib.mkDefault "";
      };
      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "icon-view"; # "icon-view", "list-view"
        "migrated-gtk-settings" = true;
        "search-filter-time-type" = "last_modified";
        "search-view" = "list-view";
      };

      "org/gnome/nm-applet" = {
        "disable-connected-notifications" = true;
        "disable-vpn-notifications" = true;
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
        color-scheme = settings.modules.styles.colorScheme;
        cursor-blink = true;
        cursor-blink-time = 500;
        cursor-blink-timeout = 10;
        cursor-size = settings.common.cursor.size;
        cursor-theme = settings.common.cursor.name;
        enable-animations = true;
        # enable-hot-corners

        # ---- Fonts ---- #
        font-name = lib.mkForce settings.modules.fonts.main.name;
        document-font-name = lib.mkForce settings.modules.fonts.main.name;
        font-hinting = lib.mkForce settings.modules.fonts.main.hinting;
        font-rendering = lib.mkForce settings.modules.fonts.main.rendering;
        font-antialiasing =
          lib.mkForce settings.modules.fonts.main.antialiasing;
        font-rgba-order = lib.mkForce settings.modules.fonts.main.rgba_order;

        # gtk-color-palette
        # gtk-color-scheme
        # gtk-enable-primary-paste
        # gtk-im-module
        # gtk-im-preedit-style
        # gtk-im-status-style
        # gtk-key-theme
        gtk-theme = lib.mkForce "${settings.common.gtk.theme}";
        # gtk-timeout-initial
        # gtk-timeout-repeat
        icon-theme = "${settings.modules.styles.icons.nameInDark}";
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
      "org/gnome/desktop/thumbnail-cache" = {
        maximum-age = 200;
        maximum-size = 2048;
      };
      "org/gnome/mutter" = {
        center-new-windows = true;
        check-alive-timeout = 0;
        dynamic-workspaces = false;
        edge-tiling = true;
        experimental-features = "['scale-monitor-framebuffer']";
        num-workspaces = 6;
        workspaces-only-on-primary = true;
      };

      # gsettings reset org.gnome.desktop.input-sources sources
      # gsettings get org.gnome.desktop.input-sources sources
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "eg" ]) ];
        xkb-options = [ "terminate:alt_shift" ];
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/search-providers" = {
        disabled = [
          "org.gnome.Boxes.desktop"
          "org.gnome.Contacts.desktop"
          "org.gnome.Documents.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.Software.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.design.IconLibrary.desktop"
          "org.gnome.seahorse.Application.desktop"
          "org.gnome.Weather.desktop"
        ];
        enabled = [ "org.gnome.Weather.desktop" ];
        sort-order = [
          # "org.gnome.Contacts.desktop"
          # "org.gnome.Documents.desktop"
          # "org.gnome.Nautilus.desktop"
          # "org.gnome.Calendar.desktop"
          # "org.gnome.Calculator.desktop"
          # "org.gnome.Software.desktop"
          # "org.gnome.Settings.desktop"
          # "org.gnome.clocks.desktop"
          # "org.gnome.design.IconLibrary.desktop"
          # "org.gnome.seahorse.Application.desktop"
          # "org.gnome.Weather.desktop"
          # "org.gnome.Boxes.desktop"
        ];
      };

      # Disabling Idle Timeout: If you wish to disable the idle timeout entirely, you can set idle-delay to 0.
      # gsettings get org.gnome.desktop.session idle-delay
      "org/gnome/desktop/session" = {
        # you can set the idle-delay to 300 seconds (5 minutes) or
        # 0 to Disable:
        idle-delay = mkUint32 settings.common.idle.delay;
      };

      "org/gnome/shell/keybindings" = {
        toggle-application-view = [ "<Super>r" ];
        # switch-to-application-1 = [ ];
      };

      "org/gnome/desktop/wm/preferences" = {
        mouse-button-modifier = "<Super>";
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        mic-mute = [ "AudioMicMute" ];
        next = [ "AudioNext" ];
        play = [ "AudioPlay" ];
        previous = [ "AudioPrev" ];
        stop = [ "AudioStop" ];
        volume-down = [ "AudioLowerVolume" ];
        volume-up = [ "AudioRaiseVolume" ];

        home = [ "<Super>e" ];
        www = [ "<Super>w" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Super>Return";
          command = "xterm";
          name = "term";
        };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        power-button-action = "interactive";
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };

      "org/gnome/shell" = {
        # find /nix/store/ -name "*qbittorrent*.desktop"
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "brave-browser.desktop"
          "google-chrome.desktop"
          "microsoft-edge.desktop"
          "obsidian.desktop"
          "org.qbittorrent.qBittorrent.desktop"
          "code.desktop"
          # "firefox.desktop"
          # "discord.desktop"
          # "spotify.desktop"
        ];
      };

      "org/gnome/shell/app-switcher" = { current-workspace-only = false; };
      "system/locale" = { region = "en_US.UTF-8"; };

      # "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      #   terminal = "kitty";
      # };

      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
