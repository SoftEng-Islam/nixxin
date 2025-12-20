{ settings, pkgs, ... }:

{
  home-manager.users.${settings.user.username} = {
    programs.rofi = {
      enable = true;

      theme = builtins.toString (pkgs.writeText "rofi-theme" ''
               /**
         * Modern Glass Rofi Theme
         * Rounded • Centered • Blur-ready
         */

        configuration {
          show-icons: true;
          sidebar-mode: false;
          font: "Roboto 12";
        }

        * {
          background-color: transparent;
          text-color: #e5e7eb;

          accent: #7aa2f7;
          surface: #0f1117cc;   /* translucent background */
          surface-alt: #161925cc;

          selected-bg: #7aa2f722;
          selected-fg: #ffffff;

          urgent-bg: #f7768ecc;
          border-color: #7aa2f755;

          border-radius: 14px;
          padding: 0;
          margin: 0;
        }

        window {
          transparency: "real";
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
          dynamic: false;
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
          text-color: @selected-fg;
        }

        element selected.urgent {
          background-color: @urgent-bg;
          text-color: @selected-fg;
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
