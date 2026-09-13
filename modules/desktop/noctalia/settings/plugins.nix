{ inputs, ... }: {
  plugins = {
    enabled = [
      "alexander/screen-toolkit"
      "aristides/udiskie"
      "icefish/phone-connect"
      "jechton/home-assistant"
      "jechton/kimai"
      "jechton/phone-media"
      "jechton/tenpo-ko"
      "yuuto/calculator"
      "noctalia/notes"
    ];

    # Every source is pinned by Nix (flake inputs or this repo), so noctalia
    # must never try to update them itself.
    auto_update = false;

    source = [
      {
        name = "official";
        kind = "path";
        location = "${pkgs.linkFarm "noctalia-official-plugins" [
          {
            name = "screen_recorder";
            path = "${inputs.noctalia-official-plugins}/screen_recorder";
          }
          {
            name = "timer";
            path = "${inputs.noctalia-official-plugins}/timer";
          }
          {
            name = "notes";
            path = "${inputs.noctalia-official-plugins}/notes";
          }
        ]}";
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
  };
}
