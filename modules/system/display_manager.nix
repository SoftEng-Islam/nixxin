# Display/Login manager
{ settings, lib, pkgs, ... }: {

  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = "hyprland";

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = false;

  # gnome polkit and keyring are used for hyprland sessions
  services.gnome.gnome-keyring.enable = true; # User's credentials manager
  security.pam.services.greetd.enableGnomeKeyring = true;
  
  # Init session with hyprland
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.dbus}/bin/dbus-run-session Hyprland";
        user = settings.user.username;
      };
      default_session = let 
        tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        tuigreetOptions = [
          "--remember"
          "--time"
          "--asterisks"
          "--time-format '%I:%M %p | %a - %h | %F'"
          "--greeting 'Just Developer'"
          # Make sure theme is wrapped in single quotes. See https://github.com/apognu/tuigreet/issues/147
          "--theme 'border=blue;text=cyan;prompt=green;time=red;action=blue;button=white;container=black;input=red'"
          "--cmd Hyprland"
        ];
        flags = lib.concatStringsSep " " tuigreetOptions;
      in {
        command = "${tuigreet} ${flags}";
        user = "greeter";
      };
    };
  };
}
