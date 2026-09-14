{ inputs, ... }: {
  plugins = {
    enabled = [
      "alexander/screen-toolkit"
      "aristides/udiskie"
      "avivbintangaringga/nix-monitor"
      "icefish/phone-connect"
      "jechton/home-assistant"
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
      "noctalia/bongocat"
      "dotnetrob/cat"
      "thepunkoff/pomodoro"
      "nikolaj-zwergius/iio_lock"
      "mdj2812/mihomo-control"
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
