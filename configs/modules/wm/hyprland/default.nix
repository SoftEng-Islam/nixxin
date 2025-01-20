{ inputs, pkgs, settings, ... }: {
  imports = [
    ./packages.nix
    ./ignis

    ./hyprland/source.nix
    ./hyprland/monitor.nix
    ./hyprland/keybinding.nix
    ./hyprland/env.nix
    ./hyprland/exec.nix
    ./hyprland/input.nix
    ./hyprland/binds.nix
    ./hyprland/animations.nix
    ./hyprland/cursor.nix
    ./hyprland/decoration.nix
    ./hyprland/general.nix
    ./hyprland/gestures.nix
    ./hyprland/misc.nix
    ./hyprland/render.nix
    ./hyprland/rules.nix
    # ./hyprland/scripts.nix
    # ./hyprland/hyprlock.nix
    ./hyprland/plugins.nix
  ];
  programs = {
    uwsm.enable = false;
    hyprlock.enable = true;
    xwayland.enable = false;
    hyprland = {
      enable = true;
      withUWSM = false; # Launch Hyprland with the UWSM session manager.
      xwayland.enable = false;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;

  environment = let exec = "exec dbus-launch Hyprland";
  in {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        ${exec}
      fi
    '';
    variables = {
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
  security.pam.services.hyprlock = {
    # text = "auth include system-auth";
    text = "auth include login";
    fprintAuth = if settings.hostName == "nixos" then true else false;
    enableGnomeKeyring = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = settings.username;
      };
    };
    vt = 7;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
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
