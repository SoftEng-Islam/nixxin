{
  pkgs,
  noctalia-v5,
  additionalConfig,
  ...
}:
let
  toml = pkgs.formats.toml { };

  # V5 picks/cycles wallpapers from a directory (single-file paths land in their
  # own store path, so dirOf would just return /nix/store). Point at the repo
  # assets dir so the whole tree gets copied as one store path.
  wallpaperDir = "${../../../assets}";

  config = {
    shell = {
      ui_scale = 1.0;
      polkit_agent = true;
      panel = {
        background_blur = true;
        attach_control_center = true;
        attach_wallpaper = true;
      };
    };

    theme = {
      mode = "dark";
      source = "wallpaper";
      wallpaper_scheme = "m3-tonal-spot";
    };

    wallpaper = {
      enabled = true;
      directory = wallpaperDir;
      fill_mode = "crop";
    };

    notification = {
      enable_daemon = true;
      layer = "top";
      background_opacity = 0.8;
    };

    osd.position = "top_right";

    weather = {
      enabled = false;
      address = "Paris";
      unit = "celsius";
      refresh_minutes = 30;
    };

    nightlight.enabled = false;

    system.monitor.enabled = true;

    idle.behavior = {
      lock = {
        timeout = 180;
        command = "noctalia:screen-lock";
        enabled = true;
      };
      screen-off = {
        timeout = 360;
        command = "noctalia:dpms-off";
        resume_command = "noctalia:dpms-on";
      };
    };

    bar.main = {
      position = "top";
      thickness = 34;
      radius = 12;
      margin_h = 180;
      margin_v = 10;
      padding = 14;
      widget_spacing = 6;
      scale = 1.2;
      shadow = true;
      reserve_space = true;
      attach_panels = true;
      background_opacity = 0.6;
      capsule = true;
      capsule_opacity = 0.8;

      start = [
        "control-center"
        "workspaces"
        "media"
      ];
      center = [
        "clock"
      ];
      end = [
        "tray"
        "notifications"
        "network"
        "bluetooth"
        "volume"
        "session"
      ];
    };
  };
in
{
  programs.noctalia-shell.enable = false;

  home.packages = [
    noctalia-v5.packages.${pkgs.system}.default
  ];

  xdg.configFile."noctalia/config.toml".source = toml.generate "noctalia-config.toml" config;
}
