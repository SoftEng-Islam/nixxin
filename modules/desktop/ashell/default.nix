{ settings, inputs, lib, pkgs, ... }:
lib.mkIf (settings.modules.desktop.ashell.enable or false) {
  home-manager.users.${settings.user.username} = {
    xdg.configFile."ashell/config.toml".text = ''
      # Ashell log level filter, possible values "debug" | "info" | "warn" | "error". Needs reload
      # log_level = "ashell::services=info"
      # log_level = "warn"
      enable_esc_key = false

      # Possible status bar outputs, values could be: All, Active, or a list of outputs
      # All: the status bar will be displayed on all the available outputs, example: outputs = "All"
      # active: the status bar will be displayed on the active output, example: outputs = "Active"
      # list of outputs: the status bar will be displayed on the outputs listed here, example: outputs = { Targets = ["DP-1", "eDP-1"] }
      # if the outputs is not available the bar will be displayed in the active output
      outputs = "All"

      # Bar position, possible values Top | Bottom.
      position = "Top"

      # App launcher command, it will be used to open the launcher,
      # without a value the related button will not appear
      app_launcher_cmd = "${pkgs.rofi}/bin/rofi -modi run -show drun -show-icons"

      # Clipboard command, it will be used to open the clipboard menu,
      # without a value the related button will not appear
      clipboard_cmd = "cliphist-rofi-img | wl-copy"

      # Declare which modules should be used and in which position in the status bar.
      # This is the list of all possible modules
      #  - AppLauncher
      #  - Updates
      #  - Clipboard
      #  - Workspaces
      #  - WindowTitle
      #  - SystemInfo
      #  - KeyboardLayout
      #  - KeyboardSubmap
      #  - Tray
      #  - Clock
      #  - Privacy
      #  - MediaPlayer
      #  - Settings
      [modules]
      # The modules that will be displayed on the left side of the status bar
      left = [ "AppLauncher" ,"Workspaces" ]
      # The modules that will be displayed in the center of the status bar
      center = ["Clock"]
      # The modules that will be displayed on the right side of the status bar
      # The nested modules array will form a group sharing the same element in the status bar
      # You can also use custom modules to extend the normal set of options, see configuration below
      right = [ "SystemInfo", "Tray", "KeyboardLayout", ["Privacy", "Settings"], "CustomNotifications"]

      # [updates]
      # Update module configuration. Without a value the related button will not appear.
      # The check command will be used to retrieve the update list.
      # It should return something like `package_name version_from -> version_to\n`
      # check_cmd = "checkupdates; paru -Qua"
      # The update command is used to init the OS update process
      # update_cmd = 'alacritty -e bash -c "paru; echo Done - Press enter to exit; read" &'

      # Workspaces module configuration, optional
      [workspaces]
      # The visibility mode of the workspaces, possible values are:
      # All: all the workspaces will be displayed
      # MonitorSpecific: only the workspaces of the related monitor will be displayed
      # optional, default All
      visibility_mode = "All"

      # Enable filling with empty workspaces
      # For example:
      # With this flag set to true if there are only 2 workspaces,
      # the workspace 1 and the workspace 4, the module will show also
      # two more workspaces, the workspace 2 and the workspace 3
      # optional, default false
      enable_workspace_filling = true

      # If you want to see more workspaces prefilled, set the number here:
      # max_workspaces = 6
      # In addition to the 4 workspaces described above it will also show workspaces 5 and 6
      # Only works with `enable_workspace_filling = true`

      # WindowTitle module configuration, optional
      [window_title]
      # The information to get from your active window.
      # Possible modes are:
      # - Title
      # - Class
      # optional, default Title
      mode = "Title"

      # Maximum number of chars that can be present in the window title
      # after that the title will be truncated
      # optional, default 150
      truncate_title_after_length = 150

      # keyboardLayout module configuration
      # Maps layout names to arbitrary labels, which can be any text, including unicode symbols as shown below
      # If using Hyprland the names can be found in `hyprctl devices | grep "active keymap"`
      [keyboard_layout.labels]
      "English (US)" = "🇺🇸"
      "Arabic (Egypt)" = "🇸🇦"
      "French" = "🇫🇷"
      # "Russian" = "🇷🇺"
      # "Italian" = "🇮🇹"
      # "Spanish" = "🇪🇸"
      # "German" = "🇩🇪"

      # The system module configuration
      [system_info]
      # System information shown in the status bar
      # The possible values are:
      #  - Cpu
      #  - Memory
      #  - MemorySwap
      #  - Temperature
      #  - { disk = "path" }
      #  - IpAddress
      #  - DownloadSpeed
      #  - UploadSpeed
      # If for example you want to dispay the usage of the root and home partition
      # systemInfo = [ { disk = "/" }, { disk = "/home" } ]
      indicators = ["DownloadSpeed", "UploadSpeed"]

      # CPU indicator thresholds
      # [system.cpu]
      # cpu indicator warning level (default 60)
      # warn_threshold = 60
      # cpu indicator alert level (default 80)
      # alert_threshold = 80

      # Memory indicator thresholds
      # [system.memory]
      # mem indicator warning level (default 70)
      # warn_threshold = 70
      # mem indicator alert level (default 85)
      # alert_threshold = 85

      # Memory swap indicator thresholds
      # [system.temperature]
      # temperature indicator warning level (default 60)
      # warn_threshold = 60
      # temperature indicator alert level (default 80)
      # alert_threshold = 80

      # Disk indicator thresholds
      # [system.disk]
      # disk indicator warning level (default 80)
      # warn_threshold = 80
      # disk indicator alert level (default 90)
      # alert_threshold = 90

      # Clock module configuration
      [clock]
      # clock format see: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
      format = "%a %d %b %I:%M %p"

      # Media player module configuration
      # [media_player]
      # optional, default 100
      # max_title_length = 100

      # Custom modules configuration (you can have multiple)
      [[CustomModule]]
      # The name will link the module in your left/center/right definition
      name = "CustomNotifications"
      # The default icon for this custom module
      icon = ""
      # The command that will be executed on click
      command = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
      # You can optionally configure your custom module to update the UI using another command
      # The output right now follows the waybar json-style output, using the `alt` and `text` field
      # E.g. `{"text": "3", "alt": "notification"}`
      listen_cmd = "swaync-client -swb"
      # You can define behavior for the `text` and `alt` fields
      # Any number of regex can be used to change the icon based on the alt field
      icons.'dnd.*' = ""
      # Another regex can optionally show a red "alert" dot on the icon
      alert = ".*notification"

      # Settings module configuration
      [settings]
      # command used for lock the system
      # without a value the related button will not appear
      # optional, default None
      lock_cmd = "hyprlock &"
      # commands used to respectively shutdown, suspend, reboot and logout
      # all optional, without values the defaults shown here will be used
      logout_cmd = "loginctl kill-user $(whoami)"
      reboot_cmd = "systemctl reboot"
      shutdown_cmd = "shutdown now"
      suspend_cmd = "systemctl suspend"
      # command used to open the sinks audio settings
      # without a value the related button will not appear
      # optional default None
      audio_sinks_more_cmd = "pavucontrol -t 3"
      # command used to open the sources audio settings
      # without a value the related button will not appear
      # optional, default None
      audio_sources_more_cmd = "pavucontrol -t 4"

      # command used to open the network settings
      # without a value the related button will not appear
      # optional, default None
      wifi_more_cmd = "nm-connection-editor"

      # command used to open the VPN settings
      # without a value the related button will not appear
      # optional, default None
      # vpn_more_cmd = "nm-connection-editor"
      # command used to open the Bluetooth settings
      # without a value the related button will not appear
      # optional, default None
      # bluetooth_more_cmd = "blueman-manager"
      # option to remove the airplane button
      # optional, default false
      remove_airplane_btn = true

      [appearance]
      # ---- optional, default iced.rs font
      font_name = "${settings.modules.fonts.main.name}"
      # ---- The style of the main bar, possible values are: Islands | Solid | Gradient, optional, default Islands
      style = "Islands"
      # ---- The opacity of the main bar, possible values are: 0.0 to 1.0 optional, default 1.0
      opacity = 1.0

      # used as a base background color for header module button
      # background_color = "#131313ff"
      # used as a accent color
      primary_color = "#ceb6e0ff"
      # used for darker background color
      secondary_color = "#313131ff"
      # used for success message or happy state
      success_color = "#a6e3a1"
      # used for danger message or danger state (the weak version is used for the warning state
      danger_color = "#ff5353ff"
      # base default text color
      text_color = "#d5d5d5ff"

      # this is a list of color that will be used in the workspace module (one color for each monitor)
      workspace_colors = ["#ffc2c2ff", "#c7feb4ff"]

      # this is a list of color that will be used in the workspace module
      # for the special workspace (one color for each monitor)
      # optional, default None
      # without a value the workspaceColors list will be used
      special_workspace_colors = ["#a6e3a1", "#f38ba8"]

      [appearance.background_color]
      base = "#1e1e2e"
      strong = "#88447eff" # optional default autogenerated from base color
      weak = "#584488ff" # optional default autogenarated from base color
      text = "#ffffff" # optional default base text color

      # menu options
      [appearance.menu]
      # The opacity of the menu, possible values are: 0.0 to 1.0
      # optional, default 1.0
      opacity = 1.0
      # The backdrop of the menu, possible values are: 0.0 to 1.0
      # optional, default 0.0
      backdrop = 0.0
    '';
  };
  environment.systemPackages = with pkgs; [
    # This doesn't work
    pkgs.ashell
    swaynotificationcenter
    networkmanagerapplet
  ];
}
