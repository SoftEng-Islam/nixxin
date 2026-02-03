{ settings, inputs, lib, config, pkgs, ... }:

{
  imports = [ inputs.noctalia.nixosModules.default ];

  services.noctalia-shell.enable = true;
  services.upower.enable = true;

  # Try to set icon theme
  # environment.sessionVariables = { QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3"; };

  environment.systemPackages = [ pkgs.gpu-screen-recorder ];

  home-manager.users.${settings.user.username} = {
    imports = [ inputs.noctalia.homeModules.default ];

    # programs.niri.settings.binds = {
    #     "Mod+L".action.spawn-sh = "noctalia-shell ipc call lockScreen lock";
    #     "Ctrl+Alt+Delete".action.spawn-sh = "noctalia-shell ipc call sessionMenu toggle";
    #     "XF86MonBrightnessUp" = {
    #         allow-when-locked = true;
    #         action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
    #     };
    #     "XF86MonBrightnessDown" = {
    #         allow-when-locked = true;
    #         action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];
    #     };
    # };

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      colors = {
        primary = {
          foreground = "#e0def4";
          background = "#1f1d2e";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };
        vi_mode_cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };
        search = {
          matches = {
            foreground = "#908caa";
            background = "#26233a";
          };
          focused_match = {
            foreground = "#191724";
            background = "#ebbcba";
          };
        };
        hints = {
          start = {
            foreground = "#908caa";
            background = "#1f1d2e";
          };
          end = {
            foreground = "#6e6a86";
            background = "#1f1d2e";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        footer_bar = {
          foreground = "#e0def4";
          background = "#1f1d2e";
        };
        selection = {
          text = "#e0def4";
          background = "#403d52";
        };
        normal = {
          black = "#26233a";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
        bright = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
      };

      settings = {
        settingsVersion = 0;
        setupCompleted = true;
        bar = {
          barType = "framed";
          position = "top";
          monitors = [ ];
          density = "comfortable";
          showOutline = false;
          showCapsule = true;
          capsuleOpacity = 1;
          backgroundOpacity = 1.0;
          useSeparateOpacity = false;
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
                id = "Workspace";
                # labelMode = "none";
                # characterCount = 2;
                # colorizeIcons = true;
                # followFocusedScreen = false;
                hideUnoccupied = false;
                # showApplications = false;
                # showLabelsOnlyWhenOccupied = false;
              }
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
                # displayMode = "alwaysShow";
                # id = "Battery";
                # showNoctaliaPerformance = true;
                # showPowerProfiles = true;
                # warningThreshold = 30;
              }
              {
                # id = "ActiveWindow";
                # widgetWidth = 290;
              }
            ];
            center = [{
              id = "Clock";
              formatHorizontal = "h:mm AP MMM d";
            }];
            right = [
              { id = "plugin:screen-recorder"; }
              {
                id = "Tray";
                drawerEnabled = false;
                colorizeIcons = false;
              }
              { id = "plugin:privacy-indicator"; }
              {
                id = "NotificationHistory";
                hideWhenZero = false;
                showUnreadBadge = true;
              }
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
        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          cpuPollingInterval = 1000;
          gpuPollingInterval = 3000;
          enableDgpuMonitoring = false;
          memPollingInterval = 1000;
          diskPollingInterval = 30000;
          networkPollingInterval = 1000;
          loadAvgPollingInterval = 3000;
          useCustomColors = false;
          warningColor = "";
          criticalColor = "";
          externalMonitor =
            "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        };
        location = {
          name = "Cairo";
          weatherEnabled = false;
          use12hourFormat = true;
          showWeekNumberInCalendar = false;
          weatherShowEffects = true;
          useFahrenheit = false;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;
          firstDayOfWeek = -1;
          hideWeatherTimezone = false;
          hideWeatherCityName = false;
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "/home/${settings.user.username}/Pictures/wallpapers/";
          monitorDirectories = [ ];
          enableMultiMonitorDirectories = false;
          recursiveSearch = false;
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          randomEnabled = false;
          randomIntervalSec = 1300;
          transitionDuration = 1500;
          transitionType = "random";
          transitionEdgeSmoothness = 5.0e-2;
          panelPosition = "follow_bar";
          hideWallpaperFilenames = false;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "111";
          wallhavenPurity = "100";
          wallhavenRatios = "";
          wallhavenApiKey = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenResolutionHeight = "";
          showHiddenFiles = false;
          viewMode = "single";
          useSolidColor = false;
          solidColor = "#1a1a2e";
          automationEnabled = false;
          wallpaperChangeMode = "random";
          sortOrder = "name";
        };
        appLauncher = {
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          enableClipPreview = true;
          enableClipboardHistory = false;
          position = "center";
          backgroundOpacity = 1.0;
          pinnedExecs = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "xterm -e";
          viewMode = "list";
        };
        controlCenter = {
          position = "top_right";
          shortcuts = {
            left = [
              { id = "ScreenRecorder"; }
              { id = "KeepAwake"; }
              { id = "NightLight"; }
            ];
            right = [ ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = false;
              id = "shortcuts-card";
            }
            {
              enabled = false;
              id = "audio-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        dock = {
          enabled = true;
          position = "bottom";
          displayMode = "auto_hide";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [ ];
          pinnedApps = [ ];
          colorizeIcons = false;
          pinnedStatic = false;
          inactiveIndicators = false;
          deadOpacity = 0.6;
          animationSpeed = 1;
        };
        network = {
          wifiEnabled = true;
          bluetoothRssiPollingEnabled = false;
          bluetoothRssiPollIntervalMs = 10000;
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
        };
        notifications = {
          doNotDisturb = false;
          monitors = [ ];
          location = "top_right";
          alwaysOnTop = false;
          lastSeenTs = 0;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          enabled = true;
          overlayLayer = true;
          backgroundOpacity = 1;
          enableKeyboardLayoutToast = true;
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };
          sounds = {
            enabled = false;
            volume = 0.5;
            separateSounds = false;
            criticalSoundFile = "";
            normalSoundFile = "";
            lowSoundFile = "";
            excludedApps = "discord,firefox,chrome,chromium,edge";
          };
          enableMediaToast = false;
        };
        osd = {
          enabled = true;
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
          enabledTypes = [ 0 1 2 ];
          monitors = [ ];
        };
        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          cavaFrameRate = 30;
          visualizerType = "linear";
          mprisBlacklist = [ ];
          preferredPlayer = "";
          volumeFeedback = false;
        };
        ui = {
          fontDefault = "Ubuntu Sans";
          fontFixed = lib.mkForce "Ubuntu Mono";
          idlfalseibitorEnabled = true;
          tooltipsEnabled = true;
          fontDefaultScale = 1;
          fontFixedScale = 1;
          panelBackgroundOpacity = 0.93;
          panelsAttachedToBar = true;
          settingsPanelMode = "attached";
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          networkPanelView = "wifi";
          bluetoothHideUnnamedDevices = false;
          boxBorderEnabled = false;
        };
        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = false;
        };
        colorSchemes = {
          useWallpaperColors = false;
          predefinedScheme = "Noctalia (default)";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "tonal-spot";
          monitorForColors = "";
        };
        templates = {
          gtk = false;
          qt = false;
          kcolorscheme = false;
          kitty = false;
          ghostty = false;
          foot = false;
          fuzzel = false;
          discord = false;
          discord_vesktop = false;
          discord_webcord = false;
          discord_armcord = false;
          discord_equibop = false;
          discord_lightcord = false;
          discord_dorion = false;
          pywalfox = false;
          enableUserTemplates = false;
          activeTemplates = [ ];
          enableUserTheming = false;
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
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
          startup = "";
          session = "";
        };
        desktopWidgets = {
          enabled = false;
          gridSnap = false;
          monitorWidgets = [ ];
        };
        battery = { chargingMode = 0; };
      };
    };
  };
}
