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
         * Dark Smooth Rofi Theme
         * Based on adi1090x layout
         * Enhanced for modern dark UI
         */

        /*****----- Configuration -----*****/
        configuration {
          modi: "drun,filebrowser,window";
          show-icons: true;

          display-drun: "Apps";
          display-run: "Run";
          display-filebrowser: "Files";
          display-window: "Windows";

          drun-display-format: "{name}\n<span size='small' alpha='70%'>{generic}</span>";

          window-format: "{c}\n<span size='small' alpha='70%'>Workspace {w}</span>";
        }

        /*****----- Global Properties -----*****/
        * {
          font: "Iosevka Nerd Font 12";
          text-color: #e6e9ef;
          background-color: transparent;
        }

        /*****----- Main Window -----*****/
        window {
          transparency:                "real";
          location: center;
          anchor: center;
          width: 520px;

          border-radius: 14px;
          background-color: #0f1117;
        }

        /*****----- Main Box -----*****/
        mainbox {
          padding: 26px;
          spacing: 18px;
          background-color: transparent;
          children: [ inputbar, mode-switcher, listview];
        }

        /*****----- Inputbar -----*****/
        inputbar {
          spacing: 12px;
          background-color: transparent;
          children: [ textbox-prompt-colon, entry];
        }

        textbox-prompt-colon {
          enabled: true;
          background-color: #161925;
          text-color: #7aa2f7;
          expand: false;
          padding: 12px 16px;
          border: 0px;
          border-radius: 10px;
          str: "";
        }

        entry {
          padding: 12px 16px;
          border-radius: 10px;
          background-color: #161925;
          text-color: #e6e9ef;

          placeholder: "Search…";
          placeholder-color: #9aa5ce;
        }

        /*****----- Listview -----*****/
        listview {
          lines: 6;
          spacing: 10px;
          scrollbar: false;
          background-color: transparent;
        }

        /*****----- Elements -----*****/
        element {
          padding: 14px 16px;
          border-radius: 12px;
          background-color: transparent;
          cursor: pointer;
        }

        element normal.normal {
          background-color: transparent;
        }

        element normal.active {
          background-color: #1a1d2b;
        }

        element selected.normal {
          background-color: #1e293b;
        }

        element selected.active {
          background-color: #2a2f4a;
        }

        element-icon {
          size: 28px;
          margin: 0 10px 0 0;
        }

        element-text {
          markup: true;
          vertical-align: 0.5;
        }

        /*****----- Mode Switcher -----*****/
        mode-switcher {
          spacing: 12px;
          background-color: transparent;
        }

        button {
          padding: 10px 14px;
          border-radius: 10px;
          background-color: #161925;
          text-color: #9aa5ce;
        }

        button selected {
          background-color: #7aa2f7;
          text-color: #0f1117;
        }

        /*****----- Messages -----*****/
        error-message {
          padding: 20px;
          background-color: #1e293b;
          text-color: #f7768e;
        }

        textbox {
          text-color: inherit;
        }

      '');
    };
  };
}
