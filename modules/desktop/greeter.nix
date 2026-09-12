{
  settings,
  pkgs,
  ...
}:
{
  services.displayManager.noctalia-greeter = with pkgs.unstable; {
    enable = true;
    package = noctalia-greeter;
    settings = {
      session.default = "Hyprland";
      appearance.scheme = "Synced";
      output.name = "HDMI-A-1";
      cursor.size = settings.common.cursor.size;
      keyboard.layout = "us";
    };
    cursorTheme = {
      package = settings.common.cursor.package;
      name = settings.common.cursor.name;
    };
  };
}
