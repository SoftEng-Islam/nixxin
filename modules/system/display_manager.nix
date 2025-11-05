# Display/Login manager
{ settings, lib, pkgs, ... }: {
  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = "hyprland";

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = false;

  # Init session with hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
        tuigreetOptions = [
          "--debug /home/${settings.user.username}/.config/tuigreet/debug.log"
          "--remember"
          "--time"
          "--asterisks"
          "--time-format '%I:%M %p | %a - %h | %F'"
          "--greeting 'Just Developer'"
          # Make sure theme is wrapped in single quotes. See https://github.com/apognu/tuigreet/issues/147
          # "--theme 'border=blue;text=cyan;prompt=green;time=red;action=blue;button=white;container=black;input=red'"
          "--theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red'"
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
