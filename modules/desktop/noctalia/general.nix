{
  settings,
  inputs,
  pkgs,
  ...
}:
{
  services.noctalia-shell.enable = true;
  services.upower.enable = true;

  # Screen recorder plugin needs this.
  environment.systemPackages = [ pkgs.gpu-screen-recorder ];

  home-manager.users.${settings.user.username} = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;

      settings = {
        settingsVersion = 0;
        # setupCompleted = true;

        general = {
          avatarImage = "";
          showScreenCorners = true;
          forceBlackScreenCorners = true;
          dimmerOpacity = 0.2;
          scaleRatio = 1;
          radiusRatio = 1;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1;
          animationDisabled = false;
          compactLockScreen = false;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = false;
          enableShadows = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = true;
          telemetryEnabled = false;
          enableLockScreenCountdown = true;
          lockScreenCountdownDuration = 10000;
          autoStartAuth = false;
          allowPasswordWithFprintd = false;
        };

        nightLight = {
          enabled = false;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
      };
    };
  };
}
