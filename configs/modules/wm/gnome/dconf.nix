{ settings, lib, ... }:
# you can try this command if you have any problem with gnome settings
# dconf reset -f /org/gnome/

# Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
# dconf write /org/gnome/mutter/debug/enable-frame-timing false
# gsettings set org.gnome.mutter check-alive-timeout 0

with lib.gvariant; {
  programs.dconf.enable = true; # dconf
  environment.systemPackages = with pkgs; [
    dconf # dconf is a simple key/value storage system that is heavily optimised for reading.
    dconf-editor # GSettings editor for GNOME

    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
  ];

  home-manager.users.${settings.username} = {
    # To list your enabled GNOME Shell extensions, you can use the gnome-extensions command-line tool, which provides various options for managing extensions.
    # gnome-extensions list --enabled
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "appindicatorsupport@rgcjonas.gmail.com"
        "pomodoro@arun.codito.in"
        "netspeedsimplified@prateekmedia.extension"
      ];
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      style-components = 3;
    };
    dconf.settings = {
      # dconf read /org/freedesktop/Tracker3/Miner/Files/enable-monitors
      "org/freedesktop/Tracker3/Miner/Files/enable-monitors" = {
        enable-monitors = false;
      };

      "org/gnome/desktop/interface" = {
        # show-battery-percentage = true;
        # cursor-theme = "Catppuccin-Mocha-Lavender-Cursors";
        # document-font-name = "JetBrains Mono 12";
        # monospace-font-name = "JetBrains Mono 12";
        # titlebar-font = "JetBrains Mono 12";
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
        idle-delay = mkUint32 settings.idleDelay;
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Alt>q" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        toggle-fullscreen = [ "<Super>f" ];
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
