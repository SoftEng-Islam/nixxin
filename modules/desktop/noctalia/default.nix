{
  settings,
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # NOTE: The old v4 sub-module imports (bar.nix, notifications.nix, etc.) are
  # no longer needed — v5 uses a single flat settings.toml file.
  # The v4 files are kept in ./v4/ for reference only.

  home-manager.users.${settings.user.username} = {
    home.file.".config/noctalia/settings.toml" = {
      source = (pkgs.formats.toml { }).generate "noctalia-shell-5-settings.toml" {

        # ─── Audio ────────────────────────────────────────────────────────────
        # v4: audio.volumeStep=5, volumeOverdrive=false, volumeFeedback=false
        audio = {
          enable_overdrive = false; # v4: volumeOverdrive = false
          enable_sounds = false;    # v4: notifications.sounds.enabled = false
        };

        # ─── Backdrop ─────────────────────────────────────────────────────────
        backdrop = {
          blur_intensity = 0.05;
          enabled = true;
          tint_intensity = 0.0;
        };

        # ─── Bar ──────────────────────────────────────────────────────────────
        # v4: position="top", density="comfortable", backgroundOpacity=1.0,
        #     barType="Framed", floating=false, marginVertical=4, marginHorizontal=4,
        #     frameThickness=4, frameRadius=24, showCapsule=false
        # NOTE: v4 plugins in the bar (pomodoro, screenshot, catwalk, translator,
        #       assistant-panel, network-indicator) are NOT available in v5 — skipped.
        # NOTE: v4 left/center/right → v5 start/center/end
        bar.default = {
          background_opacity = 1.0;   # v4: backgroundOpacity = 1.0
          capsule = false;             # v4: showCapsule = false
          margin_edge = 4;             # v4: marginVertical = 4
          margin_ends = 4;             # v4: marginHorizontal = 4
          padding = 4;
          position = "top";            # v4: position = "top"
          radius = 24;                 # v4: frameRadius = 24
          shadow = false;

          # v4 left: NotificationHistory, Workspace, KeyboardLayout + plugins
          # v4 center: Clock
          # Combined into start:
          start = [
            "launcher"      # moved up for easy access
            "clock"         # v4 center: Clock
            "workspaces"    # v4 left: Workspace
            "media"         # v4 right: MediaMini
          ];

          center = [ ];

          # v4 right: Tray, KeepAwake, Bluetooth, WiFi, Volume, Brightness, ControlCenter
          end = [
            "tray"            # v4: Tray
            "power_profiles"  # v4: KeepAwake (closest v5 equivalent)
            "notifications"   # v4: NotificationHistory (moved to end in v5 convention)
            "network"         # v4: WiFi + Bluetooth
            "volume"          # v4: Volume
            "brightness"      # v4: Brightness
            "battery"         # v4: Battery (was disabled in v4 but kept in bar)
            "control-center"  # v4: ControlCenter
          ];

          widget_spacing = 8;
        };

        # ─── Brightness ───────────────────────────────────────────────────────
        # v4: brightnessStep=5, enforceMinimum=true, enableDdcSupport=false
        brightness = {
          enable_ddcutil = false; # v4: enableDdcSupport = false
        };

        # ─── Control Center ───────────────────────────────────────────────────
        # v4: compact=false, position="top_right"
        # v4 shortcuts: ScreenRecorder, KeepAwake, NightLight
        # v4 cards: profile-card (enabled), media-sysmon-card (enabled)
        control_center = {
          compact = false; # v4: compact = false
          position = "top_right"; # v4: position = "top_right"

          # v4: shortcuts.left = [ScreenRecorder, KeepAwake, NightLight]
          # v5 uses flat list of {type} objects
          shortcuts = [
            { type = "nightlight"; }    # v4: NightLight
            { type = "power_profile"; } # v4: KeepAwake
            { type = "sysmon"; }        # v4: media-sysmon-card → system monitor
            { type = "media"; }         # v4: media-sysmon-card → media
          ];
        };

        # ─── Desktop Widgets ──────────────────────────────────────────────────
        # v4: desktopWidgets.enabled = false
        desktop_widgets = {
          enabled = false;
        };

        # ─── Dock ─────────────────────────────────────────────────────────────
        # v4: enabled=false, position="bottom", displayMode="auto_hide",
        #     backgroundOpacity=1, colorizeIcons=false
        dock = {
          auto_hide = true;          # v4: displayMode = "auto_hide"
          background_opacity = 1.0;  # v4: backgroundOpacity = 1
          enabled = false;           # v4: enabled = false
          position = "bottom";       # v4: position = "bottom"
        };

        # ─── Idle ─────────────────────────────────────────────────────────────
        # v4 listener: [{timeout=900, lock}, {timeout=1200, dpms off + resume dpms on}]
        # v4 general: lockOnSuspend=true
        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "suspend"
          ];
          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 900; # v4: listener[0].timeout = 900
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 1200; # v4: listener[1].timeout = 1200
            };
            suspend = {
              action = "suspend";
              enabled = true;
              lock_before_suspend = true; # v4: lockOnSuspend = true
              timeout = 1800;
            };
          };
        };

        # Mark setup wizard as already done so v5 doesn't show it on first run
        noctalia_state = {
          setup_wizard_completed = true;
        };

        # ─── Notification ─────────────────────────────────────────────────────
        # v4: location="top_left", backgroundOpacity=1, overlayLayer=true,
        #     lowUrgencyDuration=3, normalUrgencyDuration=8, criticalUrgencyDuration=15
        notification = {
          background_opacity = 1.0; # v4: backgroundOpacity = 1
          layer = "overlay";         # v4: overlayLayer = true
          position = "top_left";     # v4: location = "top_left"
        };

        # ─── OSD ──────────────────────────────────────────────────────────────
        # v4: location="top_right", autoHideMs=2000, overlayLayer=true
        osd = {
          position = "top_right"; # v4: location = "top_right"
        };

        # ─── Shell (general + ui + nightLight) ────────────────────────────────
        # v4 general: showScreenCorners=true, animationSpeed=1, animationDisabled=false,
        #   compactLockScreen=false, showSessionButtonsOnLockScreen=true,
        #   enableShadows=true, allowPanelsOnScreenWithoutBar=true, telemetryEnabled=false
        # v4 ui: fontDefault=mainFont, fontFixed=monospace, panelBackgroundOpacity=1,
        #   panelsAttachedToBar=true, settingsPanelMode="attached"
        # v4 nightLight: enabled=false
        shell = {
          font_family = settings.common.mainFont.name; # v4: ui.fontDefault → settings.common.mainFont.name
          password_style = "random";
          polkit_agent = false;
          settings_show_advanced = false;
          show_location = false;
          telemetry_enabled = false; # v4: telemetryEnabled = false

          animation = {
            speed = 1.0; # v4: animationSpeed = 1
          };

          panel = {
            attach_clipboard = true;         # v4: panelsAttachedToBar = true
            attach_launcher = true;
            attach_session = true;
            transparency_mode = "solid";     # v4: panelBackgroundOpacity=1 → solid (no transparency)
          };

          screen_corners = {
            enabled = true; # v4: showScreenCorners = true
            size = 8;
          };
        };

        # ─── Theme (colorSchemes + templates) ─────────────────────────────────
        # v4 colorSchemes: useWallpaperColors=false, predefinedScheme="Noctalia (default)",
        #   darkMode=true, generationMethod="tonal-spot"
        # v4 templates: gtk=false, qt=false, kcolorscheme=false (all off)
        theme = {
          source = "wallpaper";              # v4: color source driving theme
          wallpaper_scheme = "m3-tonal-spot"; # v4: generationMethod = "tonal-spot"

          templates = {
            # v4: all templates were disabled (gtk=false, qt=false, kcolorscheme=false…)
            # Keeping minimal set for basic GTK theming:
            builtin_ids = [
              "gtk4"
              "gtk3"
              "qt"
              "starship"
            ];
            community_ids = [ ]; # v4: all community templates were disabled
          };
        };

        # ─── Wallpaper ────────────────────────────────────────────────────────
        # v4: directory="~/Pictures/wallpapers/", randomEnabled=true,
        #     randomIntervalSec=3600, transitionDuration=1500,
        #     transitionType="random", fillMode="crop"
        wallpaper = {
          directory = "~/Pictures/Wallpapers"; # v4: directory = "~/Pictures/wallpapers/"

          default = {
            path = "/home/${settings.user.username}/Pictures/Wallpapers/24.jpg";
          };
        };

        # ─── Weather / Location ───────────────────────────────────────────────
        # v4: location.name="Cairo", weatherEnabled=false, use12hourFormat=true
        weather = {
          auto_locate = false; # v4: weatherEnabled=false
        };

        # ─── Widgets ──────────────────────────────────────────────────────────
        # Fine-grained widget settings translated from v4 bar widget config
        widget = {
          # v4 Clock: formatHorizontal="h:mm AP MMM d"
          # v5 uses Rust's chrono format strings
          clock = {
            format = " {:%A, %B %-e} • {:%I:%M %p} "; # equivalent to v4 "h:mm AP MMM d"
          };

          control-center = {
            glyph = "snowflake"; # kept from previous v5 config
          };

          launcher = {
            glyph = "grid-dots";
          };

          # v4: network-indicator plugin had showNumbers=true; v5 built-in network widget
          network = {
            show_label = false;
          };

          # v4: NotificationHistory with showUnreadBadge=true, hideWhenZero=false
          notifications = {
            hide_when_no_unread = false;
          };

          volume = {
            show_label = false;
          };

          brightness = {
            show_label = false;
          };

          # v4 Workspace: labelMode="index", hideUnoccupied=false,
          #   emptyColor="mTertiary", occupiedColor="secondary", focusedColor="primary"
          workspaces = {
            display = "none";         # minimal label display like v4 index mode
            empty_color = "on_primary";
            occupied_color = "primary";
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Noctalia Shell
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Noctalia screenshot plugin needs this package
    hyprshot
  ];
}
