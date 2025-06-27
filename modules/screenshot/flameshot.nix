# An open-source screenshot software.
# https://flameshot.org/
{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (flameshot.overrideAttrs (oldAttrs: {
        version = oldAttrs.version + "-unstable-latest";
        src = pkgs.fetchFromGitHub {
          owner = "flameshot-org";
          repo = "flameshot";
          rev = "c1dac52231024174faa68a29577129ebca125dff";
          hash = "sha256-Y9RnVxic5mlRIc48wYVQXrvu/s65smtMMVj8HBskHzE=";
        };
      }))
    ];
  home-manager.users.${settings.user.username} = {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          checkForUpdates = "false";
          disabledTrayIcon = "true";
          contrastOpacity = 96;
          drawColor = "#ff2800";
          drawFontSize = "4";
          saveAsFileExtension = ".png";
          savePath = "/home/${settings.user.username}/Pictures";
          savePathFixed = "true";
          showDesktopNotification = "false";
          showHelp = "false";
          showMagnifier = "true";
          showStartupLaunchMessage = "false";
          squareMagnifier = "true";
          startupLaunch = "true";
          uiColor = "#8aadf4";
        };
      };
    };
  };
}
