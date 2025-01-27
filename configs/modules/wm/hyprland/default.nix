{ inputs, pkgs, lib, settings, ... }: {
  imports = [
    ./packages.nix
    # ./ignis
    ./hyprland
  ];
  services.seatd.enable = lib.mkForce false;
  services.seatd.user = "root";
  programs = {
    uwsm.enable = false;
    hyprlock.enable = true;
    xwayland.enable = false;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;

  environment =
    # let exec = "exec dbus-launch Hyprland";
    # in
    {
      #loginShellInit = ''
      # if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      #    ${exec}
      #  fi
      #'';
      variables = {
        LIBSEAT_BACKEND = "logind";
        HYPRLAND_PLUGIN_PATH = lib.mkString ":" [
          "${pkgs.hyprlandPlugins.hyprspace}/lib"
          "${pkgs.hyprlandPlugins.hyprbars}/lib"
          "${pkgs.hyprlandPlugins.borders-plus-plus}/lib"
          "${pkgs.hyprlandPlugins.hyprtrails}/lib"
        ];
        HYPRCURSOR_THEME = settings.cursorTheme;
        HYPRCURSOR_SIZE = toString settings.cursorSize;

        # HYPRLAND_TRACE = 1; # Enables more verbose logging.

        # HYPRLAND_NO_RT = 1; # Disables realtime priority setting by Hyprland.
        # HYPRLAND_NO_SD_NOTIFY = 1; # If systemd, disables the sd_notify calls.

        # Disables management of variables in systemd and dbus activation environments.
        # HYPRLAND_NO_SD_VARS = 1;

        # HYPRLAND_CONFIG = ""; # Specifies where you want your Hyprland configuration.
      };
    };
  #security.pam.services.hyprlock = {
  # text = "auth include system-auth";
  #text = "auth include login";
  #fprintAuth = if settings.hostName == "nixos" then true else false;
  # enableGnomeKeyring = false;
  #};

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command =
  #         "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
  #       user = settings.username;
  #     };
  #   };
  #   vt = 7;
  # };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      systemd.enableXdgAutostart = true;
      settings = {
        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };
        # extraConfig = "";
      };
    };
    # Scripts for Hyprland
    home.file.".config/hypr/scripts".source = ./hyprland/scripts;
  };
}
