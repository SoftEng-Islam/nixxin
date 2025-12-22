{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.rofi = {
      enable = true;
      plugins = [ pkgs.rofi-calc ];
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
      extraConfig = {
        matching = "fuzzy";
        tokenize = true;
        sort = true;
        sorting-method = "fzf";
        case-sensitive = false;
        drun-display-format = "{name}";
        display-drun = "Apps";
        combi-modes = "drun,window,run";

        # Force Papirus icons
        icon-theme = "Papirus-Dark";
      };
      theme = builtins.toString (pkgs.writeText "rofi-theme" ''
        /**
          * Modern Solid Rofi Theme
          * Centered • Rounded • Large & Readable
          */

        configuration {
          show-icons: true;
          sidebar-mode: false;
          font: "Roboto 14";
        }

        * {
          background-color: transparent;
          text-color: #e6e9ef;

          /* Palette */
          blue: #7aa2f7;
          red:  #f7768e;

          surface: #0f1117;
          surface-alt: #161925;

          selected-bg: #1e293b;
          border-color: #2a2e3f;

          border-radius: 16px;
          padding: 0;
          margin: 0;
        }

        window {
          location: center;
          anchor: center;

          width: 520px;
          height: 600px;

          background-color: @surface;
          border: 1px;
          border-color: @border-color;
          border-radius: 16px;

          children: [ mainbox ];
        }

        mainbox {
          padding: 20px;
          spacing: 16px;
          children: [ inputbar, listview ];
        }

        inputbar {
          background-color: @surface-alt;
          border-radius: 12px;
          padding: 12px 14px;
          spacing: 10px;
        }

        prompt {
          enabled: false;
        }

        entry {
          text-color: @text-color;
          placeholder: "Search…";
        }

        listview {
          background-color: transparent;
          spacing: 8px;
          scrollbar: false;
        }

        element {
          padding: 14px 16px;
          border-radius: 12px;
          background-color: transparent;
          text-color: @text-color;
        }

        element selected.normal {
          background-color: @selected-bg;
          text-color: #ffffff;
          border: 0;
        }

        element selected.urgent {
          background-color: @red;
          text-color: #ffffff;
        }

        element-icon {
          size: 28px;
          margin: 0 10px 0 0;
        }

        element-text {
          markup: true;
          vertical-align: 0.5;
        }
      '');
    };
  };
}
