{ pkgs, settings, ... }: {
  # Run Hyprland in a nested session for testing within GNOME:
  # Install waypipe and weston: These tools allow you to run Wayland compositors inside existing Wayland/X11 sessions.
  # Start Nested Hyprland: Inside GNOME, run:
  # `weston --socket=wayland-1 &`
  # `WAYLAND_DISPLAY=wayland-1 Hyprland`
  services.xserver.displayManager.startx.enable = false;
  programs = {
    uwsm.enable = true;
    hyprlock.enable = false;
    xwayland.enable = true;
    hyprland = {
      xwayland.enable = true;
      enable = true;
      withUWSM = true; # Launch Hyprland with the UWSM session manager.
      package = pkgs.hyprland;
      # set the flake package
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # make sure to also set the portal package, so that they are in sync
      # portalPackage =
      #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland.override {
      #     inherit (pkgs) mesa;
      #   };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
    WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
    WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
    NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
  };
  home-manager.users.${settings.username} = {
    # home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hypr/hyprland.conf;
    # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
    # home.file.".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
    # home.file.".config/hypr/scripts/hyprlock-time.sh".source = ./hypr/scripts/hyprlock-time.sh;
    imports = [
      ./hyprland/ags.nix
      ./hyprland/env.nix
      ./hyprland/binds.nix
      ./hyprland/scripts.nix
      ./hyprland/rules.nix
      ./hyprland/settings.nix
      ./hyprland/plugins.nix
      ./hyprland/hyprlock.nix
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      # package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd.enable = false;
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprtrails
      plugins = with pkgs; [
        hyprlandPlugins.borders-plus-plus
        hyprlandPlugins.hyprbars
        hyprlandPlugins.hyprexpo
        hyprlandPlugins.hyprtrails
      ];

      settings = {
        "$mod" = "SUPER";
        monitor = [ ",preferred,auto,1" ];
        bind = [
          # Window/Session actions.
          "$mod, Q, killactive,"
          "$mod Shift , Q, exec, hyprctl kill" # Pick and kill a window
          "$mod, delete, exit,"
          "$mod, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland" # Launch VSCode (editor)
          "$mod, E, exec, nautilus --new-window" # Launch Nautilus (file manager)
          "$mod, Z, exec, Zed" # Launch Zed (editor)
          # "$mod Alt, E, exec, thunar" # Launch Thunar (file manager)
          "$mod, X, exec, gnome-text-editor --new-window" # Launch GNOME Text Editor
          # Launch GNOME Settings
          "Ctrl $mod, V, exec, pavucontrol" # Launch pavucontrol (volume mixer)
          "Ctrl Shift, Escape, exec, gnome-system-monitor" # Launch GNOME System monitor
          "Ctrl $mod, Slash, exec, pkill anyrun || anyrun" # Toggle fallback launcher: anyrun
          "$mod Alt, Slash, exec, pkill anyrun || fuzzel" # Toggle fallback launcher: fuzzel

          ''
            $mod, I, exec, XDG_CURRENT_DESKTOP="gnome" gnome-control-center
          ''

          # Positioning mode
          "$mod Alt, Space, togglefloating,"
          "$mod, F, fullscreen, 0"
          # "$mod, D, fullscreen, 1"
          "$mode SHIFT, F, fullscreen,"

          # Dwindle
          "$mod, O, togglesplit,"
          "$mod, P, pseudo,"

          # Lock screen
          "$mod, Escape, exec, hyprlock"

          # Application shortcuts.
          "$mod, T, exec, kitty" # Launch kitty (terminal)
          "$mod SHIFT, Return, exec, kitty --class floating"

          # Special workspace
          "$mod, S, togglespecialworkspace"
          "$mod SHIFT, S, movetoworkspacesilent, special"

          # Launcher
          # "$mod, A, exec, rofi -show drun -kb-cancel Super_L"
          "$mod SHIFT, A, exec, ags -t launcher"

          # Screenshot
          "$mod SHIFT, z, exec, wl-copy < $(grimshot --notify save area $XDG_PICTURES_DIR/Screenshots/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png'))"

          # Move window focus with vim keys.
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Music control
          "$mod ALT, m, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
          ",XF86AudioMicMute, exec, pulsemixer --id $(pulsemixer --list-sources | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
          ",XF86AudioMute, exec, pulsemixer --id $(pulsemixer --list-sinks | cut -f3 | grep 'Default' | cut -d ',' -f 1 | cut -c 6-) --toggle-mute"
          "$mod ALT, l, exec, hyprmusic next"
          "$mod ALT, h, exec, hyprmusic previous"
          "$mod ALT, p, exec, hyprmusic play-pause"

          # Swap windows with vim keys
          "$mod SHIFT, h, swapwindow, l"
          "$mod SHIFT, l, swapwindow, r"
          "$mod SHIFT, k, swapwindow, u"
          "$mod SHIFT, j, swapwindow, d"

          "$mod SHIFT, c, centerwindow, 1"

          # Move monitor focus.
          "$mod, TAB, focusmonitor, +1"

          #/# bind = Ctrl+Super, ←/→,, # Workspace: focus left/right
          "Ctrl $mod, Right, workspace, +1"
          "Ctrl $mod, Left, workspace, -1"

          # Switch workspaces.
          "$mod, 1,exec,hyprworkspace 1"
          "$mod, 2,exec,hyprworkspace 2"
          "$mod, 3,exec,hyprworkspace 3"
          "$mod, 4,exec,hyprworkspace 4"
          "$mod, 5,exec,hyprworkspace 5"
          "$mod, 6,exec,hyprworkspace 6"
          "$mod, 7,exec,hyprworkspace 7"
          "$mod, 8,exec,hyprworkspace 8"
          "$mod, 9,exec,hyprworkspace 9"
          "$mod, 0,exec,hyprworkspace 10"

          "$mod CTRL, h, workspace, r-1"
          "$mod CTRL, l, workspace, r+1"

          # Scroll through monitor workspaces with mod + scroll
          "$mod, mouse_down, workspace, r-1"
          "$mod, mouse_up, workspace, r+1"
          "$mod, mouse:274, killactive,"

          # Move active window to a workspace.
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
          "$mod CTRL SHIFT, l, movetoworkspace, r+1"
          "$mod CTRL SHIFT, h, movetoworkspace, r-1"

          # Move active window to a workspace silent.
          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          #/# bind = Super+Shift, Page_↑/↓,, # Window: move to workspace left/right
          "$mod Alt, Page_Down, movetoworkspace, +1"
          "$mod Alt, Page_Up, movetoworkspace, -1"
          "$mod Shift, Page_Down, movetoworkspace, +1"
          "$mod Shift, Page_Up, movetoworkspace, -1"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    uwsm # Universal wayland session manager
    # albert # Fast and flexible keyboard launcher
    # ags # A EWW-inspired widget system as a GJS library
    brightnessctl # This program allows you read and control device brightness
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    gtk-engine-murrine # for gtk themes
    # hyprcursor # The hyprland cursor format, library and utilities
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    # hypridle # Hyprland's idle daemon
    # hyprland-protocols # Wayland protocol extensions for Hyprland
    # hyprlang # The official implementation library for the hypr config language
    # hyprlauncher # GUI for launching applications, written in Rust
    # hyprlock # Hyprland's GPU-accelerated screen locking utility
    # hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    # hyprpaper # A blazing fast wayland wallpaper utility
    # hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    # hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    # hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    # hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
  ];
}
