{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      bar = {
        barType = "Framed";
        position = "top";
        monitors = [ ];
        density = "comfortable";
        showOutline = false;
        showCapsule = false;
        capsuleOpacity = 1;
        backgroundOpacity = 1.0;
        useSeparateOpacity = true;
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 4;
        frameRadius = 24;
        outerCorners = true;
        hideOnOverview = false;
        displayMode = "always_visible";
        autoHideDelay = 500;
        autoShowDelay = 150;

        widgets = {
          left = [
            {
              id = "NotificationHistory";
              hideWhenZero = false;
              showUnreadBadge = true;
            }
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = false;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              labelMode = "index";
              iconScale = 0.8;
              pillSize = 0.6;
              reverseScroll = false;
              showApplications = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = false;
              unfocusedIconsOpacity = 1;
              emptyColor = "secondary";
              occupiedColor = "secondary";
              focusedColor = "primary";
            }
            {
              id = "KeyboardLayout";
              displayMode = "forceOpen";
              showIcon = true;
            }
            { id = "plugin:pomodoro"; }
            { id = "plugin:screenshot"; }
            {
              id = "plugin:catwalk";
            }
            # { id = "plugin:kaomoji-provider"; }
            { id = "plugin:translator"; }
            { id = "plugin:assistant-panel"; }
            { id = "plugin:network-indicator"; }

            {
              # id = "SystemMonitor";
              compactMode = false;
              usePrimaryColor = true;
              # showMemoryUsage = true;
              # showCpuTemp = true;
              # showCpuUsage = true;
              # showGpuUsage = true;
              # showDiskUsage = true;
              # diskPath = "/";
            }
            {
              # id = "Battery";
              # displayMode = "alwaysShow";
              # showNoctaliaPerformance = true;
              # showPowerProfiles = true;
              # warningThreshold = 30;
            }
            {
              # id = "ActiveWindow";
              # widgetWidth = 290;
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "h:mm AP MMM d";
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = false;
              colorizeIcons = false;
            }
            { id = "plugin:unicode-picker"; }
            { id = "plugin:screen-recorder"; }
            { id = "plugin:privacy-indicator"; }
            { id = "KeepAwake"; }
            { id = "Bluetooth"; }
            { id = "WiFi"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            {
              id = "ControlCenter";
              colorizeDistroLogo = true;
              colorizeSystemIcon = "primary";
              customIconPath = "";
              enableColorization = true;
              icon = "";
              useDistroLogo = true;
            }
          ];
        };
      };
    };
  };
}
