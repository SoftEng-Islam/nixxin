{
  settings,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia = {
      enable = true;
    };
    home.file.".config/noctalia/settings.toml" = {
      source = (pkgs.formats.toml { }).generate "noctalia-shell-5-settings.toml" {

        # ─── Audio ────────────────────────────────────────────────────────────
        audio = {
          enable_sounds = true;
          enable_overdrive = true;
        };

        # ─── Backdrop ─────────────────────────────────────────────────────────
        backdrop = {
          enabled = true;
          blur_intensity = 0.05;
          tint_intensity = 0.0;
        };

        # ─── Bar ──────────────────────────────────────────────────────────────
        bar.default = {
          enabled = true;
          auto_hide = false;
          position = "top"; # "top" pr "center" or "left"
          background_opacity = 1.0;
          capsule = false;
          capsule_fill = "on_secondary";
          capsule_opacity = 0.8;
          margin_edge = 0;
          margin_ends = 0;
          # margin_h = 180;
          # margin_v = 10;
          # padding = 6;
          # radius = 0;
          radius_bottom_left = 0;
          radius_bottom_right = 0;
          radius_top_left = 0;
          radius_top_right = 0;
          shadow = false;
          widget_spacing = 8;
          thickness = 48;
          # reserve_space = false;
          attach_panels = true;
          scale = 1.2;
          start = [
            "launcher"
            "notifications"
            "workspaces"
            # "media"
            # "taskbar"
          ];
          center = [
            "clock"
          ];
          end = [
            "tray"
            "clipboard"
            "power_profiles"
            "network"
            "volume"
            "brightness"
            "battery"
            "session"
            "control-center"
          ];
        };

        # ─── Brightness ───────────────────────────────────────────────────────
        brightness = {
          enable_ddcutil = false;
        };

        # ─── Control Center ───────────────────────────────────────────────────
        control_center = {
          compact = false;
          position = "top_right";
          shortcuts = [
            { type = "nightlight"; }
            { type = "power_profile"; }
            { type = "sysmon"; }
            { type = "media"; }
          ];
        };

        # ─── Desktop Widgets ──────────────────────────────────────────────────
        desktop_widgets = {
          enabled = false;
        };

        # ─── Dock ─────────────────────────────────────────────────────────────
        dock = {
          enabled = false;
          auto_hide = true;
          background_opacity = 1.0;
          position = "bottom";
        };

        # ─── Idle ─────────────────────────────────────────────────────────────
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
              timeout = 900;
              # command = "noctalia:screen-lock";
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 1200;
              # command = "noctalia:dpms-off";
              # resume_command = "noctalia:dpms-on";
            };
            suspend = {
              action = "suspend";
              enabled = false;
              lock_before_suspend = true;
              timeout = 1800;
            };
          };
        };

        # Mark setup wizard as already done so v5 doesn't show it on first run
        noctalia_state = {
          setup_wizard_completed = true;
        };

        # ─── Notification ─────────────────────────────────────────────────────
        notification = {
          background_opacity = 1.0;
          layer = "overlay"; # "top" or "overlay"
          position = "bottom_left"; # "top_left"
        };

        # ─── OSD ──────────────────────────────────────────────────────────────
        osd = {
          position = "bottom_right"; # "top_right"
        };

        # ─── Shell (general + ui + nightLight) ────────────────────────────────
        shell = {
          # avatar_path = self.avatar;
          font_family = settings.common.mainFont.name;
          corner_radius_scale = 1.45;
          password_style = "random";
          polkit_agent = false;
          settings_show_advanced = false;
          show_location = false;
          telemetry_enabled = false;

          animation = {
            speed = 1.0;
          };

          panel = {
            attach_clipboard = true;
            attach_launcher = true;
            attach_session = true;
            open_near_click_clipboard = true;
            open_near_click_control_center = true;
            open_near_click_launcher = true;
            transparency_mode = "glass"; # "solid" or "glass"
          };

          screen_corners = {
            enabled = true;
            size = 25;
          };
        };

        # ─── Theme (colorSchemes + templates) ─────────────────────────────────
        theme = {
          mode = "dark";
          source = "wallpaper";
          wallpaper_scheme = "m3-tonal-spot";

          # To use Catppuccin Theme
          # builtin = "Catppuccin";
          # community_palette = "Catppuccin Lavender";
          # source = "community";

          templates = {
            # Keeping minimal set for basic GTK theming:
            builtin_ids = [
              "gtk4"
              "gtk3"
              "qt"
              "starship"
              "wezterm"
            ];
            community_ids = [
              "telegram"
              "yazi"
              "vscode"
              # "zathura"
            ];
          };
        };

        # ─── Wallpaper ────────────────────────────────────────────────────────
        wallpaper = {
          enabled = true;
          directory = "~/Pictures/Wallpapers";
          fill_mode = "crop";

          default = {
            path = "/home/${settings.user.username}/Pictures/Wallpapers/24.jpg";
          };
        };

        # ─── Weather / Location ───────────────────────────────────────────────
        weather = {
          enabled = false;
          auto_locate = false;
          address = "Egypt";
          unit = "celsius";
          refresh_minutes = 30;
        };

        nightlight.enabled = false;
        system.monitor.enabled = true;

        # ─── Widgets ──────────────────────────────────────────────────────────
        widget = {
          # v5 uses Rust's chrono format strings
          clock = {
            format = " {:%A, %B %-e} • {:%I:%M %p} ";
          };

          control-center = {
            glyph = "snowflake";
          };

          launcher = {
            glyph = "grid-dots";
          };

          network = {
            show_label = false;
          };

          notifications = {
            hide_when_no_unread = false;
          };

          volume = {
            show_label = true;
          };

          brightness = {
            show_label = false;
          };

          taskbar = {
            anchor = true;
            capsule_fill = "on_primary";
            capsule_foreground = "primary";
            capsule_padding = 4.0;
            group_by_workspace = true;
            hide_empty_workspaces = false;
            only_active_workspace = false;
            show_all_outputs = false;
            show_workspace_label = false;
          };
          workspaces = {
            display = "id"; # none | id | name
            capsule = true;
            focused_color = "primary";
            empty_color = "on_primary";
            occupied_color = "secondary";
            hide_when_empty = false;
          };
          tray = {
            drawer = false;
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
