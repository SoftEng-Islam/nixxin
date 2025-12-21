{ settings, pkgs, ... }:

{
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
      };
      theme = builtins.toString (pkgs.writeText "rofi-theme" ''
        /**
         * Modern Solid Rofi Theme
         * Rounded • Centered • Opaque
         */

        configuration {
          show-icons: true;
          sidebar-mode: false;
          font: "Roboto 12";
        }

        * {
          background-color: transparent;
          text-color: #e6e9ef;

          /* Core colors */
          blue: #7aa2f7;
          red:  #f7768e;

          surface: #0f1117;        /* fully opaque */
          surface-alt: #161925;    /* input background */

          selected-bg: #1e3a8a;   /* blue base */
          selected-accent: #f7768e;

          border-color: #2a2e3f;

          border-radius: 14px;
          padding: 0;
          margin: 0;
        }

        window {
          location: center;
          anchor: center;

          width: 420px;
          height: 480px;

          background-color: @surface;
          border: 1px;
          border-color: @border-color;
          border-radius: 14px;

          children: [ mainbox ];
        }

        mainbox {
          padding: 18px;
          spacing: 14px;
          children: [ inputbar, listview ];
        }

        inputbar {
          background-color: @surface-alt;
          border-radius: 10px;
          padding: 10px 12px;
          spacing: 8px;
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
          spacing: 6px;
          scrollbar: false;
        }

        element {
          padding: 10px 12px;
          border-radius: 10px;
          background-color: transparent;
          text-color: @text-color;
        }

        element selected.normal {
          background-color: @selected-bg;
          text-color: #ffffff;
          border: 0px 0px 0px 3px;
          border-color: @selected-accent;   /* red accent stripe */
        }

        element selected.urgent {
          background-color: @red;
          text-color: #ffffff;
        }

        element-icon {
          size: 20px;
          margin: 0 8px 0 0;
        }

        element-text {
          vertical-align: 0.5;
        }
      '');
    };
  };
}
