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

      # https://docs.noctalia.dev/getting-started/nixos/#plugins
      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      plugins = {
        sources = [{
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }];
        states = {
          assistant-panel = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          network-indicator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          catwalk = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          translator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          kaomoji-provider = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          keybind-cheatsheet = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          pomodoro = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screen-recorder = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screenshot = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          timer = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          unicode-picker = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 1;
      };

      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      pluginSettings = {
        network-indicator = {
          # ["arrow", "arrow-bar", "arrow-big", "arrow-narrow", "caret", "chevron", "chevron-compact", "fold"]
          arrowType = "fold";
          byteThresholdActive = 1024;
          fontSizeModifier = 1.1;
          forceMegabytes = false;
          iconSizeModifier = 1.1;
          minWidth = 100;
          showNumbers = true;
          spacingInbetween = 1;
          useCustomColors = true;
          colorSilent = "#E91E63";
          colorTx = "#7FFF00";
          colorRx = "#FFC107";
          colorText = "#DEB887";
          colorBackground = "";
        };
        catwalk = {
          # minimumThreshold = 25;
          # hideBackground = true;
        };
        pomodoro = {
          workDuration = 25;
          shortBreakDuration = 5;
          longBreakDuration = 15;
          sessionsBeforeLongBreak = 4;
          autoStartBreaks = true;
          autoStartWork = true;
          compactMode = false;
        };
        # https://github.com/noctalia-dev/noctalia-plugins/tree/main/assistant-panel
        assistant-panel = {
          maxHistoryLength = 100;
          panelDetached = true;
          panelPosition = "right";
          panelHeightRatio = 0.85;
          panelWidth = 520;
          scale = 1;
          ai = {
            provider = "google";
            model = "gemini-2.5-flash";
            apiKeys = { };
            temperature = 0.7;
            systemPrompt =
              "You are a helpful assistant integrated into a Linux desktop shell. Be concise and helpful.";
            maxHistoryLength = 100;
            openaiLocal = false;
            openaiBaseUrl = "https://api.openai.com/v1/chat/completions";
          };
          translator = {
            backend = "google";
            sourceLanguage = "auto";
            targetLanguage = "en";
            realTimeTranslation = true;
            deeplApiKey = "";
          };
        };
      };

      settings = {
        settingsVersion = 0;
        # setupCompleted = true;
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
                emptyColor = "secondary";
                enableScrollWheel = false;
                focusedColor = "primary";
                followFocusedScreen = false;
                groupedBorderOpacity = 1;
                hideUnoccupied = true;
                iconScale = 0.8;
                labelMode = "index";
                occupiedColor = "secondary";
                pillSize = 0.6;
                reverseScroll = false;
                showApplications = false;
                showBadge = true;
                showLabelsOnlyWhenOccupied = false;
                unfocusedIconsOpacity = 1;
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
            center = [{
              id = "Clock";
              formatHorizontal = "h:mm AP MMM d";
            }];
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
          directory = "~/Pictures/wallpapers/";
          monitorDirectories = [ ];
          enableMultiMonitorDirectories = false;
          recursiveSearch = false;
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          randomEnabled = true;
          randomIntervalSec = 10000;
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
          automationEnabled = true;
          wallpaperChangeMode = "random";
          sortOrder = "name";
        };
        appLauncher = {
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          enableClipPreview = true;
          enableClipboardHistory = true;
          position = "center";
          backgroundOpacity = 1.0;
          pinnedExecs = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "xterm -e";
          viewMode = "list";
          autoPasteClipboard = false;
          clipboardWrapText = true;
          # iconMode = "tabler";
          ignoreMouseInput = false;
          pinnedApps = [ ];
          screenshotAnnotationTool = "";
          showCategories = true;
          showIconBackground = false;
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
          size = 2;
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
          fontDefault = settings.common.mainFont.name;
          fontFixed = lib.mkForce settings.modules.fonts.monospace.name;
          idlfalseibitorEnabled = true;
          tooltipsEnabled = true;
          fontDefaultScale = 1;
          fontFixedScale = 1;
          panelBackgroundOpacity = 1;
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
