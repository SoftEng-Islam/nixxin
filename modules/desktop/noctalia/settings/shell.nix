{ settings, ... }: {
  shell = {
    corner_radius_scale = 2; # 0 = square, 1 = default, 2 = extra rounded
    font_family = "${settings.common.mainFont.name}";
    time_format = " {:%A %e, %B %m, %Y • %I:%M %p} "; # default shell UI time format
    date_format = "%A, %x"; # default shell UI date format
    offline_mode = false; # block all outgoing HTTP when true
    # panel_anchor_bar   = "main";        # bar panels attach to without a source bar; omit = first enabled bar
    telemetry_enabled = false; # send an anonymous startup ping
    niri_overview_type_to_launch_enabled = false; # opt in to type-to-launch from niri overview
    polkit_agent = false;
    password_style = "default"; # default | random
    settings_show_advanced = true; # show advanced settings by default in Settings
    # settings_window_translucent = false;  # translucent settings window background
    show_location = true; # hide weather location text in shell UI when false
    #app_icon_colorize   = false;        # recolor application icons across the shell
    #app_icon_color      = "on_surface"; # ColorSpec role or #hex when colorize is enabled
    clipboard_enabled = true; # false disables clipboard panel, history, and compositor clipboard hooks
    clipboard_history_max_entries = 100; # unpinned history cap (10-10000); pinned entries are extra
    # A Wayland selection is served by the app that owns it, so it dies when that app exits.
    # With this on, the shell claims it back so the item stays pasteable. Caveat: a password
    # manager that clears the clipboard by exiting looks identical to any other app closing,
    # so its secret can be kept alive too. Apps advertising x-kde-passwordManagerHint are
    # already excluded; set this to false if you rely on one that does not.
    clipboard_keep_from_closed_apps = true; # keep the last copied item pasteable after the app you copied it from closes
    clipboard_auto_paste = "auto"; # off | auto | ctrl_v | ctrl_shift_v | shift_insert
    clipboard_image_action_command = ""; # image preview action: gimp {path}, or satty -f - via stdin
    # IPC example:
    # noctalia msg clipboard-clear
    shared_gl_context = true; # startup-only; false isolates GPU contexts for broken drivers
    # lang                = "en"
    # avatar_path         = "~/Pictures/avatar.png"
    privacy = {
      mic_filter_regex = ""; # microphone app names to ignore in privacy indicators and OSD
      cam_filter_regex = ""; # camera app names to ignore in privacy indicators and OSD
      screen_filter_regex = ""; # screen-sharing app names to ignore in privacy indicators and OSD
    };
    animation = {
      enabled = true;
      speed = 1.2; # 0.5 = 2× slower, 2.0 = 2× faster
    };

    shadow = {
      direction = "down"; # center, up, down, left, right, up_left, up_right, down_left, down_right
      alpha = 0.65; # multiplied by each component's background opacity
    };

    panel = {
      transparency_mode = "soft"; # solid | soft | glass; controls floating-panel opacity and card translucency
      borders = true; # panel shell outline and in-panel section cards
      shadow = true; # cast the global [shell.shadow] from panel surfaces
      launcher_placement = "floating"; # attached | floating
      clipboard_placement = "floating"; # attached | floating
      control_center_placement = "floating"; # attached | floating
      wallpaper_placement = "floating"; # attached | floating
      session_placement = "floating"; # attached | floating
      launcher_position = "center"; # auto | center | top_left | … (floating only)
      clipboard_position = "center"; # auto | center | top_left | … (floating only)
      open_near_click_control_center = false; # for attached/floating placement, follow the bar click instead of bar-center
      open_near_click_launcher = false; # for attached/floating placement, follow the bar click instead of bar-center
      open_near_click_clipboard = false; # for attached/floating placement, follow the bar click instead of bar-center
      open_near_click_wallpaper = false; # for attached/floating placement, follow the bar click instead of bar-center
      open_near_click_session = false; # for attached/floating placement, follow the bar click instead of bar-center
    };
    launcher = {
      categories = true; # show category filters in the launcher
      show_icons = true; # show application icons in launcher results
      show_app_origin_indicator = true; # show package origin indicators on application results
      compact = false; # use smaller icons and tighter result rows
      app_grid = false; # show app icon grid view when results are apps only
      sort_by_usage = true; # sort apps by usage frequency
      pinned = [ ]; # e.g. ["firefox", "code", "kitty"] (launcher only)
      fetch_exchange_rates = true; # refresh currency rates from third-party sources
      provider_prefix = "/"; # common prefix character for provider trigger words (e.g. "/" or ".")
      auto_paste = "auto"; # off | auto | ctrl_v | ctrl_shift_v | shift_insert (copy activations)

      # For each provider: prefix = trigger word (empty falls back to its built-in default; triggers on
      # provider_prefix + trigger, e.g. "/emo"). global = true also surfaces it in unprefixed search.
      providers = {
        calculator = {
          prefix = "calc";
          global = true; # also show calculator results in unprefixed search
        };
        emoji = {
          prefix = "emo";
        };
        session = {
          prefix = "session";
          global = false; # set true to include session actions in unprefixed search
        };
        wallpaper = {
          prefix = "wall";
        };
        windows = {
          prefix = "win";
        };
      };
    };
    mpris = {
      blacklist = [ ]; # ignore MPRIS players by bus/identity/desktop entry token
    };
  };
}
