{
  settings,
  pkgs,
  inputs,
  ...
}:
{
  # git clone https://github.com/Shanu-Kumawat/quickshell-overview ~/.config/quickshell/overview
  # bind = Super, TAB, exec, qs ipc -c overview call overview toggle

  home-manager.users.${settings.user.username} = {
    xdg.configFile = {
      "quickshell/overview" = {
        source = inputs.quickshell-overview;
        recursive = true;
      };

      "quickshell/overview/config.json".text = builtins.toJSON {
        overview = {
          rows = 2;
          columns = 5;
          scale = 0.16;
          enable = true;
          hideEmptyRows = false;
          closeOnFocusLoss = true;
          useWorkspaceMap = false;
          workspaceMap = [
            0
            10
          ];
          orderRightLeft = false;
          orderBottomUp = false;
          previewsEnabled = true;
          previewMode = "live";
          includeInactiveMonitorPreviews = true;
          previewRecaptureDelayMs = 60;
          showSpecialWorkspaces = false;
          specialWorkspaces = [ ];
          specialWorkspaceColumns = 5;
          emptyWorkspaceWallpaper = "";
          specialEmptyWorkspaceWallpaper = "";
          effects = {
            enableBackdrop = false;
            backdropOpacity = 0.28;
            panelOpacity = 0.92;
            workspaceOpacity = 0.86;
            emptyWorkspaceWallpaperOverlayOpacity = 0.18;
            windowOverlayOpacity = 0.22;
            enableBlur = true;
            glassMode = true;
            glassTintStrength = 0.35;
            glassBorderOpacity = 0.72;
            glassShineOpacity = 0.14;
          };
          workspaceSpacing = 5;
          backgroundPadding = 10;
          workspaceNumberBaseSize = 250;
        };
      };
    };

    systemd.user.services.quickshell-overview = {
      Unit = {
        Description = "quickshell workspace overview widget";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.quickshell}/bin/qs -c overview";
        Restart = "always";
        RestartSec = 1;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };

  # Qt6 environment for Hyprland/Quickshell QML support
  environment.variables = {
    QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";
  };

  environment.systemPackages = with pkgs; [
    quickshell
    qt6.qt5compat
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtquick3d
    qt6.qtsvg
    qt6.qtwayland
  ];
}
