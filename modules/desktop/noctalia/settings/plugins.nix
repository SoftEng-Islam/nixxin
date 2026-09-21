{ inputs, ... }: {
  plugins = {
    enabled = [
      "alexander/screen-toolkit"
      "aristides/udiskie"
      "avivbintangaringga/nix-monitor"
      "icefish/phone-connect"
      "jechton/kimai"
      "jechton/phone-media"
      "jechton/tenpo-ko"
      "nightwatch75/todo"
      "noctalia/kaomoji"
      "noctalia/notes"
      "noctalia/screen_recorder"
      "noctalia/translator"
      "noctalia/wallhaven"
      "yocraft/web-launcher"
      "yuuto/calculator"
      "dotnetrob/cat"
      "nikolaj-zwergius/iio_lock"
      "thepunkoff/pomodoro"
      "mdj2812/mihomo-control"
      "dunarand/bookmarks"
      "samuelskovbakke/calculator-plus"
      "levi/warp"
      "oldirtty/color_picker"
      "umedbazarov/crashes"
      "nzlov/daily-wallpaper"
      "gustav0ar/drive-health"
      "liamwh/emoji-picker"
      "nomadcxx/gamer-mode"
      "tphilippot/git_companion"
      "alexmnrs/github-activity"
      "hy4ri/github-notifications"
      "raycursive/github-prs"
      "k4n4t4/hypr-submap"
      "3ri4ng0ld/ip-monitor"
      "linux-fertxo/hyprland-visual-editor"
      "mellotanica/launcher-pass"
      "alexander/mimir"
      "neyfua/obs-integration"
      "davemhammer/obsidian"
      "emiliovenegas/omp-launcher"
      "decksters-lab/palette-creator"
      "ahmedhossamdev/sticky-notes"
      "cleboost/zed-provider"
      "notfinaldev/youtube-search"
    ];

    # Every source is pinned by Nix (flake inputs or this repo), so noctalia
    # must never try to update them itself.
    auto_update = "none";

    source = [
      {
        enabled = true;
        name = "official";
        kind = "path";
        location = toString inputs.noctalia-official-plugins;
      }
      {
        enabled = true;
        name = "community";
        kind = "path";
        location = toString inputs.noctalia-community-plugins;
      }
      {
        enabled = true;
        name = "local";
        kind = "path";
        location = toString inputs.noctalia-plugins;
      }
    ];
  };
  plugin_settings = {
    "dotnetrob/cat" = {
      panel_open_near_click = false;
      panel_position = "top_left";
    };
    "icefish/phone-connect" = {

      battery_display = "hidden";
    };

    "noctalia/notes" = {
      notes_dir = "~/noctalia/notes";
      panel_open_near_click = true;
    };

    "noctalia/screen_recorder" = {
      directory = "~/noctalia/records";
      replay_duration = 60;
      replay_enabled = true;
      video_source = "focused";
    };

    "yuuto/calculator" = {
      panel_placement = "floating";
      panel_position = "center";
    };
  };
  widget = {
    udiskie = {
      type = "aristides/udiskie:bar";
    };
  };
}
