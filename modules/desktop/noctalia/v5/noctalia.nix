{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "noctalia") {
    home.packages = with pkgs; [
      adw-gtk3
      adwaita-icon-theme
      bazaar
      # noctalia gtk4 color schema integration
      glib
      jellyfin-tui
      kdePackages.breeze-icons
      kdePackages.qt6ct
      libsForQt5.qt5ct
      networkmanagerapplet
      # noctalia schema installation
      python3
      cliphist
      wl-clipboard
    ] ++desktop.extraHomePackages ++desktop.noctalia.extraHomePackages ++(
      if desktop.noctalia.package == pkgs.noctalia-shell-5 then
        [ desktop.noctalia.package ]
      else
        []
    );
    home.file.".config/qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      };
    };
    home.file.".config/qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,50,0,0,0,0,0,Regular"'';
      };
    };
    devlive.programs.eza.enable = true;
    devlive.programs.wezterm = {
      enable = true;
      defaultTerminalEmulator = true;
      settings.color_scheme = "Noctalia";
      settings.window_background_opacity = 0.8;
    };
    # File manager
    devlive.programs.yazi = {
      enable = true;
      plugins = {
        gvfs = pkgs.yaziPlugins.gvfs;
        mount = pkgs.yaziPlugins.mount;
        recycle-bin = pkgs.yaziPlugins.recycle-bin;
        wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      };
    };
    # Document viewer
    devlive.programs.zathura.enable = true;
    # System monitor
    programs.bottom.enable = true;
    # Image preview
    programs.imv.enable = true;
    # Media player
    programs.mpv.enable = true;
    programs.noctalia-shell = lib.mkIf (desktop.noctalia.package == pkgs.noctalia-shell) {
      enable = true;
      package = desktop.noctalia.package.override { calendarSupport = true; };
      settings = {
        appLauncher = {
          enableClipboardHistory = true;
          position = "follow_bar";
          terminalCommand = "devlive-desktop-terminal -e";
          viewMode = "grid";
        };
        bar = {
          density = "comfortable";
          monitors = [
            "eDP-1"
          ];
          position = "left";
          widgets = {
            center = [
              {
                id = "SystemMonitor";
              }
            ];
            left = [
              {
                icon = "rocket";
                id = "CustomButton";
                leftClickExec = "noctalia-shell ipc call launcher toggle";
              }
              {
                id = "Clock";
                usePrimaryColor = false;
              }
              {
                id = "Workspace";
                followFocusedScreen = true;
                hideUnoccupied = false;
              }
            ];
            right = [
              {
                id = "MediaMini";
              }
              {
                id = "Tray";
                pinned = [
                  "nm-applet"
                  "opensnitch-ui"
                  "udiskie"
                ]
                ++ (
                  if config.devlive.services.tailscale.enable then
                    [ "systray_*" ]
                  else []
                )
                ++ (
                    if desktop.enableTelegram then
                      [ "Telegram Desktop" ]
                    else []
                )
                ++ (
                    if desktop.enableWhatsApp then
                      [ "ZapZap" ]
                    else []
                );
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "ControlCenter";
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                enableColorization = false;
                icon = "noctalia";
                useDistroLogo = true;
              }
            ];
          };
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Noctalia (default)";
        };
        dock = {
          backgroundOpacity = 0.8;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          compactLockScreen = true;
          enableShadows = false;
          lockScreenMonitors = [ "eDP-1" ];
          lockScreenBlur =  1;
          showScreenCorners = true;
          showSessionButtonsOnLockScreen = false;
        };
        idle = {
          enabled = true;
          screenOffTimeout = 600;
          lockTimeout = 660;
          suspendTimeout = 1800;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "echo nope";
          customCommands = "[]";
        };
        location = {
          name = "Kuta, Indonesia";
        };
        notifications = {
          location = "bottom_left";
          monitors = [
            "eDP-1"
          ];
        };
        templates = {
          gtk = true;
          qt = true;
          kcolorscheme = true;
          alacritty = config.programs.alacritty.enable;
          kitty = config.programs.kitty.enable;
          ghostty = config.programs.ghostty.enable;
          foot = config.programs.foot.enable;
          wezterm = config.programs.wezterm.enable;
          fuzzel = false;
          discord = false;
          pywalfox = false;
          vicinae = false;
          walker = false;
          code = config.devlive.programs.vscode.enable;
          spicetify = false;
          telegram = desktop.enableTelegram;
          cava = false;
          yazi = config.programs.yazi.enable;
          emacs = false;
          niri = if (desktop.noctalia.compositor == "niri") then true else false;
          hyprland = if (desktop.noctalia.compositor == "hyprland") then true else false;
          mango = false;
          zathura = config.programs.zathura.enable;
          zed = false;
          zenBrowser = false;
          helix = false;
          enableUserTemplates = false;
        };
        ui = {
          fontDefault = "DejaVu Sans";
          fontFixed = "FiraCode Nerd Font Mono";
          panelBackgroundOpacity = 0.8;
        };
      };
    };
    home.file.".config/noctalia/settings.toml" = lib.mkIf (desktop.noctalia.package == pkgs.noctalia-shell-5) {
      source = (pkgs.formats.toml {}).generate "noctalia-shell-5-settings.toml" {
        bar.default = {
          background_opacity = 1.0;
          center = [
            "cpu"
            "temp"
            "ram"
          ];
          margin_edge = 16;
          margin_ends = 16;
          position = "left";
          start = [
            "launcher"
            "clock"
            "wallpaper"
            "workspaces"
          ];
          thickness = 48;
          widget_spacing = 8;
        };

        control_center = {
          compact = false;
        };

        dock = {
          auto_hide = true;
          background_opacity = 1.0;
          enabled = true;
        };

        notification = {
          background_opacity = 1.0;
          position = "bottom_left";
        };

        osd = {
          position = "bottom_right";
        };

        shell = {
          font_family = "Liberation Sans";
          telemetry_enabled = false;

          panel = {
            attach_clipboard = true;
            attach_launcher = true;
            attach_session = true;
            transparency_mode = "solid";
          };

          screen_corners = {
            enabled = true;
          };
        };

        theme = {
          source = "wallpaper";

          templates = {
            builtin_ids = [
              "gtk3"
              "gtk4"
              "kcolorscheme"
              "niri"
              "qt"
              "starship"
              "wezterm"
            ];
            community_ids = [
              "telegram"
              "yazi"
              "vscode"
              "zathura"
            ];
          };
        };

        wallpaper = {
          directory = "~/Pictures/Wallpapers";

          default = {
            path = "${config.home.homeDirectory}/Pictures/Wallpapers/wallhaven_j38o75.jpg";
          };
        };

        weather = {
          auto_locate = true;
        };

        widget = {
          control-center = {
            glyph = "snowflake";
          };
        };
      };
    };
    # Enable zen browser transparency and custom layout
    programs.zen-browser.profiles.default.settings = lib.mkIf config.devlive.programs.zen-browser.enable {
      "browser.tabs.inTitlebar" = if (desktop.noctalia.compositor == "hyprland") then 0 else 2;
      "zen.view.compact.hide-tabbar" = true;
      "zen.view.compact.hide-toolbar" = false;
      "zen.view.grey-out-inactive-windows" = false;
      "zen.widget.linux.transparency" = true;
    };
    wayland.windowManager.hyprland = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        source = [
          "${config.xdg.configHome}/hypr/autostart.conf"
          "${config.xdg.configHome}/hypr/binds.conf"
          "${config.xdg.configHome}/hypr/common.conf"
          "${config.xdg.configHome}/hypr/env.conf"
          "${config.xdg.configHome}/hypr/input.conf"
          "${config.xdg.configHome}/hypr/laf.conf"
          "${config.xdg.configHome}/hypr/permissions.conf"
          "${config.xdg.configHome}/hypr/rules.conf"
          "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf"
        ]
        ++(if config.programs.ghostty.enable then [ "${config.xdg.configHome}/hypr/rules-ghostty.conf" ] else [])
        ++(if config.programs.wezterm.enable then [ "${config.xdg.configHome}/hypr/rules-wezterm.conf" ] else []);
      };
    };

    xdg.configFile."hypr/autostart.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/autostart.conf;
    };
    xdg.configFile."hypr/binds.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/binds.conf;
    };
    xdg.configFile."hypr/common.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/common.conf;
    };
    xdg.configFile."hypr/env.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/env.conf;
    };
    xdg.configFile."hypr/input.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/input.conf;
    };
    xdg.configFile."hypr/laf.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/laf.conf;
    };
    xdg.configFile."hypr/permissions.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/permissions.conf;
    };
    xdg.configFile."hypr/rules.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/rules.conf;
    };
    xdg.configFile."hypr/rules-ghostty.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland" && config.programs.ghostty.enable) {
      source = ./config/hypr/rules-ghostty.conf;
    };
    xdg.configFile."hypr/rules-wezterm.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland" && config.programs.wezterm.enable) {
      source = ./config/hypr/rules-wezterm.conf;
    };

    xdg.configFile."niri/animations.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/animations.kdl;
    };
    xdg.configFile."niri/config.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/config.kdl;
    };
    xdg.configFile."niri/binds.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = (
        if (desktop.noctalia.package == pkgs.noctalia-shell) then
          ./config/niri/binds-noctalia-4.kdl
        else
          ./config/niri/binds-noctalia-5.kdl
      );
    };
    xdg.configFile."niri/input.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/input.kdl;
    };
    xdg.configFile."niri/output.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/output.kdl;
    };
    xdg.configFile."niri/layer-rule.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = (
        if (desktop.noctalia.package == pkgs.noctalia-shell) then
          ./config/niri/layer-rule-noctalia-4.kdl
        else
          ./config/niri/layer-rule-noctalia-5.kdl
      );
    };
    xdg.configFile."niri/layout.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/layout.kdl;
    };
    xdg.configFile."niri/spawn-at-startup.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = (
        if (desktop.noctalia.package == pkgs.noctalia-shell) then
          ./config/niri/spawn-at-startup-noctalia-4.kdl
        else
          ./config/niri/spawn-at-startup-noctalia-5.kdl
      );
    };
    xdg.configFile."niri/window-rule.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/window-rule.kdl;
    };
    xdg.configFile."niri/workspace.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/workspace.kdl;
    };

    services.flameshot = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          useGrimAdapter = true;
        };
      };
    };
    services.tailscale-systray.enable = lib.mkIf (config.devlive.services.tailscale.enable) true;
    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "devlive-desktop-terminal -e yazi";
        };
      };
      tray = "always";
    };
    services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    devlive.services.xwayland-satellite.enable = true;
    systemd.user.services.networkmanagerapplet = {
      Unit = {
        Description = "NetworkManager applet";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";
      "image/vnd.djvu" = "org.pwmt.zathura.desktop";

      "image/bmp" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/pjpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/x-bmp" = "imv.desktop";
      "image/x-pcx" = "imv.desktop";
      "image/x-png" = "imv.desktop";
      "image/x-portable-anymap" = "imv.desktop";
      "image/x-portable-bitmap" = "imv.desktop";
      "image/x-portable-graymap" = "imv.desktop";
      "image/x-portable-pixmap" = "imv.desktop";
      "image/x-tga" = "imv.desktop";
      "image/x-xbitmap" = "imv.desktop";
      "image/heic" = "imv.desktop";
    };
  };
}
