{ settings, lib, pkgs, ... }: {
  services.greetd.enable = true;

  # The virtual console (tty) that greetd should use. This option also disables getty on that tty.
  services.greetd.vt = 1;

  services.greetd.settings.default_session = {
    # command = "${lib.getExe pkgs.cage} -s -- ${lib.getExe pkgs.greetd.regreet}";
    # command = "${pkgs.greetd.regreet}/bin/regreet";
    # command = ''
    #   export XDG_DATA_DIRS=${pkgs.gtk4}/share
    #   export XDG_CONFIG_DIRS=/etc/xdg
    #   ${pkgs.greetd.regreet}/bin/regreet
    # '';
    command =
      "env GTK_DATA_PREFIX=${pkgs.gtk4}/share GTK_PATH=${pkgs.gtk4}/lib/gtk-4.0 ${pkgs.greetd.regreet}/bin/regreet";

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
        path = ./orange_sunset.jpg;
        fit = "Fill"; # "Contain", "Fill"
      };
      GTK = { application_prefer_dark_theme = true; };

      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };
  };
  environment.systemPackages = with pkgs; [ gtk4 ];

}
