{ osConfig, inputs, ... }: {
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
    ];

    # Every source is pinned by Nix (flake inputs or this repo), so noctalia
    # must never try to update them itself.
    auto_update = "none";

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
    "jechton/home-assistant" = {
      # Secret file: line 1 the HA URL, line 2 a long-lived access token.
      credentials_file = osConfig.age.secrets.home-assistant-credentials.path;
    };
    "jechton/kimai" = {
      # Secret file: line 1 the Kimai URL, line 2 an API token.
      credentials_file = osConfig.age.secrets.kimai-credentials.path;
      # Panel setting: prefix each project in the picker with its customer name.
      show_client = false;
    };
    "yuuto/calculator" = {
      panel_placement = "floating";
      panel_position = "center";
    };
  };
}
