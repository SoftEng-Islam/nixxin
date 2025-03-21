{ settings, lib, pkgs, ... }: {
  services.greetd.enable = true;

  # The virtual console (tty) that greetd should use. This option also disables getty on that tty.
  services.greetd.vt = 1;

  services.greetd.settings.default_session = {
    command = "${lib.getExe pkgs.cage} -s -- ${lib.getExe pkgs.greetd.regreet}";
    # command = "${pkgs.greetd.regreet}/bin/regreet";
    # command = ''
    #   export XDG_DATA_DIRS=${pkgs.gtk4}/share
    #   export XDG_CONFIG_DIRS=/etc/xdg
    #   ${pkgs.greetd.regreet}/bin/regreet
    # '';
    # command = "${pkgs.greetd.regreet}/bin/regreet";
    # command = "Hyprland --config /etc/greetd/hyprland.conf";

    user = "greeter";
  };

  programs.regreet.enable = true;
  programs.regreet.package = pkgs.greetd.regreet;

  programs.regreet.theme.name = settings.common.gtk.theme;
  programs.regreet.theme.package = settings.common.gtk.package;

  programs.regreet.font.size = 16;
  programs.regreet.font.name = settings.common.mainFont.name;
  programs.regreet.font.package = settings.common.mainFont.package;

  programs.regreet.iconTheme.name = settings.common.icons.nameInDark;
  programs.regreet.iconTheme.package = settings.common.icons.package;

  programs.regreet.cursorTheme.name = settings.common.cursor.name;
  programs.regreet.cursorTheme.package = settings.common.cursor.package;

  programs.regreet = {
    # https://github.com/rharish101/ReGreet/blob/main/regreet.sample.toml
    # settings = (lib.importTOML ./regreet.toml) // {};
    settings = {
      background = {
        # Path to the background image
        path = ./orange_sunset.jpg;
        # How the background image covers the screen if the aspect ratio doesn't match
        # Available values: "Fill", "Contain", "Cover", "ScaleDown"
        # Refer to: https://docs.gtk.org/gtk4/enum.ContentFit.html
        # NOTE: This is ignored if ReGreet isn't compiled with GTK v4.8 support.
        fit = "Fill"; # "Contain", "Fill"
      };

      # The entries defined in this section will be passed to the session as environment variables when it is started
      env = {
        ENV_VARIABLE = ''
          GTK_DATA_PREFIX=${pkgs.gtk4}/share
          GTK_PATH=${pkgs.gtk4}/lib/gtk-4.0
          GTK_USE_PORTAL=0
          GDK_DEBUG=no-portals'';
      };

      GTK = {
        # Whether to use the dark theme
        application_prefer_dark_theme = true;

        # Cursor theme name
        # cursor_theme_name = "Adwaita";

        # Font name and size
        # font_name = "Cantarell 16";

        # Icon theme name
        # icon_theme_name = "Adwaita";

        # GTK theme name
        # theme_name = "Adwaita";
      };
      commands = {
        # The command used to reboot the system
        reboot = [ "systemctl" "reboot" ];

        # The command used to shut down the system
        poweroff = [ "systemctl" "poweroff" ];

        # The command prefix for X11 sessions to start the X server
        # x11_prefix = [ "startx" "/usr/bin/env" ];
      };

      appearance = {
        # The message that initially displays on startup
        greeting_msg = "Welcome back!";
      };

      widget.clock = {
        # strftime format argument
        # See https://docs.rs/jiff/0.1.14/jiff/fmt/strtime/index.html#conversion-specifications
        format = "%a %H:%M";

        # How often to update the text
        resolution = "500ms";

        # Override system timezone (IANA Time Zone Database name, aka /etc/zoneinfo path)
        # Remove to use the system time zone.
        timezone = "America/Chicago";

        # Ask GTK to make the label at least this wide. This helps keeps the parent element layout and width consistent.
        # Experiment with different widths, the interpretation of this value is entirely up to GTK.
        label_width = 150;
      };
    };
  };
  environment.etc."greetd/hyprland.conf".text = ''
    exec-once = regreet; hyprctl dispatch exit
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
  '';
  environment.systemPackages = with pkgs; [ gtk4 ];
}
