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
          "--greeting 'Hello There!'"
          "--theme 'border=magenta;text=white;prompt=magenta;time=white;action=magenta;button=white;container=black;input=white'"
          "--cmd 'Hyprland > /dev/null 2>&1'"
        ];
        flags = lib.concatStringsSep " " tuigreetOptions;
      in {
        command = "${tuigreet} ${flags}";
        user = "greeter";
      };
    };
  };
}
