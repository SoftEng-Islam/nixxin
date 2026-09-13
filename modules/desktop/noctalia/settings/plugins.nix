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
      "noctalia/bongocat"
      "noctalia/kaomoji"
      "noctalia/notes"
      "noctalia/screen_recorder"
      "noctalia/translator"
      "noctalia/wallhaven"
      "yocraft/web-launcher"
      "yuuto/calculator"
    ];

    # Every source is pinned by Nix (flake inputs or this repo), so noctalia
    # must never try to update them itself.
    auto_update = false;

    source = [
      {
        name = "official";
        kind = "path";
        location = toString inputs.noctalia-official-plugins;
      }
      {
        name = "community";
        kind = "path";
        location = toString inputs.noctalia-community-plugins;
      }
      {
        name = "local";
        kind = "path";
        location = toString inputs.noctalia-plugins;
      }
    ];
  };
  plugin_settings = {
    "icefish/phone-connect" = {
      battery_display = "hidden";
    };
    "yuuto/calculator" = {
      panel_placement = "floating";
      panel_position = "center";
    };
    "noctalia/screen_recorder" = {
      directory = "~/noctalia/records";
      video_source = "focused";
      replay_enabled = true;
      replay_duration = 60;
    };
    "noctalia/notes" = {
      notes_dir = "~/noctalia/notes";
      panel_open_near_click = true;
    };
  };
  widget = {
    udiskie = {
      type = "aristides/udiskie:status";
    };
  };
}
