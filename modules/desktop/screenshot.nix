{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    #  An open-source screenshot software.
    # https://flameshot.org/
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
  environment.systemPackages = with pkgs; [ flameshot slurp ];
}
