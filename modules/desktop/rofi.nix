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
         * Premium Glassmorphic Rofi Theme
         * Perfectly Integrated with System Colors
         */

        /*****----- Configuration -----*****/
        configuration {
          modi: "drun,filebrowser,window";
          show-icons: true;
          display-drun: "APPS";
          display-run: "RUN";
          display-filebrowser: "FILES";
          display-window: "WINDOWS";
          drun-display-format: "{name}";
          window-format: "{c} · {t}";
        }

        /*****----- Global Properties -----*****/
        * {
          font: "${settings.modules.fonts.main.name} 12";
          background: ${settings.common.surfaceColor};
          foreground: #FFFFFF;
          primary: ${settings.common.primaryColor};
          accent: ${settings.common.primaryColor};
          background-alt: ${settings.common.surfaceColor};
          background-transparent: ${settings.common.surfaceColor}cc; /* Use semi-transparent surface */

          background-color: transparent;
          text-color: @foreground;
        }

        /*****----- Main Window -----*****/
        window {
          transparency: "real";
          location: center;
          anchor: center;
          fullscreen: false;
          width: 600px;
          x-offset: 0px;
          y-offset: 0px;

          enabled: true;
          margin: 0px;
          padding: 0px;
          border: 2px solid;
          border-radius: ${
            toString settings.modules.desktop.hyprland.rounding
          }px;
          border-color: @primary;
          cursor: "default";
          background-color: @background-transparent;
        }

        /*****----- Main Box -----*****/
        mainbox {
          enabled: true;
          spacing: 20px;
          margin: 0px;
          padding: 40px;
          border: 0px solid;
          border-radius: 0px 0px 0px 0px;
          border-color: @primary;
          background-color: transparent;
          children: [ "inputbar", "mode-switcher", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
          enabled: true;
          spacing: 12px;
          margin: 0px;
          padding: 0px;
          border: 0px solid;
          border-radius: 0px;
          border-color: @primary;
          background-color: transparent;
          text-color: @foreground;
          children: [ "prompt", "entry" ];
        }

        prompt {
          enabled: true;
          padding: 12px 16px;
          border-radius: 12px;
          background-color: @primary;
          text-color: @background;
          font: "${settings.modules.fonts.main.name} Bold 12";
        }

        entry {
          enabled: true;
          padding: 12px 16px;
          border-radius: 12px;
          background-color: @background-alt;
          text-color: inherit;
          cursor: text;
          placeholder: "Search applications...";
          placeholder-color: inherit;
        }

        /*****----- Listview -----*****/
        listview {
          enabled: true;
          columns: 1;
          lines: 8;
          cycle: true;
          dynamic: true;
          scrollbar: false;
          layout: vertical;
          reverse: false;
          fixed-height: true;
          fixed-columns: true;

          spacing: 8px;
          margin: 0px;
          padding: 0px;
          border: 0px solid;
          border-radius: 0px;
          border-color: @primary;
          background-color: transparent;
          text-color: @foreground;
          cursor: "default";
        }

        /*****----- Elements -----*****/
        element {
          enabled: true;
          spacing: 12px;
          margin: 0px;
          padding: 10px 15px;
          border: 0px solid;
          border-radius: 12px;
          border-color: @primary;
          background-color: transparent;
          text-color: @foreground;
          cursor: pointer;
        }

        element normal.normal {
          background-color: transparent;
          text-color: @foreground;
        }

        element selected.normal {
          background-color: @primary;
          text-color: @background;
        }

        element-icon {
          background-color: transparent;
          text-color: inherit;
          size: 32px;
          cursor: inherit;
        }

        element-text {
          background-color: transparent;
          text-color: inherit;
          highlight: inherit;
          cursor: inherit;
          vertical-align: 0.5;
          horizontal-align: 0.0;
        }

        /*****----- Mode Switcher -----*****/
        mode-switcher {
          enabled: true;
          spacing: 10px;
          margin: 0px;
          padding: 0px;
          border: 0px solid;
          border-radius: 0px;
          border-color: @primary;
          background-color: transparent;
          text-color: @foreground;
        }

        button {
          padding: 10px;
          border-radius: 10px;
          background-color: @background-alt;
          text-color: inherit;
          cursor: pointer;
        }

        button selected {
          background-color: @primary;
          text-color: @background;
        }

        /*****----- Message -----*****/
        error-message {
          padding: 20px;
          border: 2px solid;
          border-radius: 12px;
          border-color: @primary;
          background-color: @background;
          text-color: @foreground;
        }
        textbox {
          background-color: transparent;
          text-color: @foreground;
          vertical-align: 0.5;
          horizontal-align: 0.0;
          highlight: none;
        }
      '');
    };
  };
}
