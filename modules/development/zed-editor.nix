{
  settings,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nil
    nixd
    zed-editor
    package-version-server
  ];
  home-manager.users.${settings.user.username} = {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      extraPackages = [ pkgs.nixd ];

      extensions = [
        "opencode"
        "env"
        "git-firefly"
        "gleam"
        "graphql"
        "helm"
        "html"
        "just"
        "nix"
        "one-dark-pro"
        "rust"
        "sql"
        "toml"
        "twig"
        "nix"
        "html"
        "toml"
        "git firefly"
        "sql"
        "latex"
        "make"
        "scss"
        "csv"
        "ruff"
        "python-lsp"
        "env"
        "kanso"
        "macos-classic"
        "material-icon-theme"
        "vue"
        "prisma"
        "ini"
      ];
      userSettings = {
        languages = {
          Python = {
            tab_size = 4;
            formatter = "language_server";
            format_on_save = "on";
          };

          Lua = {
            tab_size = 2;
            formatter = "language_server";
            format_on_save = "on";
          };

          Nix = {
            # Ensure you are using the LSP you prefer
            language_servers = [ "nixd" ];
            formatter.external = {
              command = "nixpkgs-fmt";
              arguments = [ ];
            };
            format_on_save = "on";
          };
        };
        features = {
          edit_prediction_provider = "copilot";
        };
        theme = {
          mode = "dark";
          light = "macOS Classic Light";
          dark = "macOS Classic Dark";
        };
        icon_theme = {
          mode = "dark";
          light = "Material Icon Theme";
          dark = "Material Icon Theme";
        };
        node = {
          path = lib.getExe pkgs.nodejs;
          npm_path = lib.getExe' pkgs.nodejs "npm";
        };
        lsp.nixd = {
          initialization_options = {
            nix = {
              flake = {
                # This suppresses the error by allowing nixd to fetch inputs automatically
                autoArchive = true;
              };
            };
          };
        };
        lsp = {
          rust-analyzer = {
            initialization_options = {
              check = {
                command = "clippy"; # rust-analyzer.check.command (default: "check")
              };
              inlayHints = {
                maxLength = null;
                lifetimeElisionHints = {
                  enable = "skip_trivial";
                  useParameterNames = true;
                };
                closureReturnTypeHints = {
                  enable = "always";
                };
              };
            };
          };
        };
        file_scan_exclusions = [
          "**/.ruff_cache"
          "**/__pycache__"
          "**/*.egg-info"
          "**/dist"
          "**/.pre-commit-config.yaml"
          "**/.devenv.flake.nix"
          "**/.devenv"
          "**/.direnv"
          "**/.helix"
          "**/*.lock"
          "**/.envrc"
          # default values below
          "**/.git"
          "**/.svn"
          "**/.hg"
          "**/CVS"
          "**/.DS_Store"
          "**/Thumbs.db"
          "**/.classpath"
          "**/.settings"
        ];
        auto_update = false;
        autosave = "off";
        collaboration_panel.button = false;
        # features.inline_completion_provider = "none";

        inlay_hints.enabled = true;
        journal.hour_format = "hour24";
        lsp.nil.initialization_options.formatting.command = [ "nixfmt" ];
        notification_panel.button = true;
        relative_line_numbers = true;
        show_whitespaces = "boundary";
        tabs.git_status = true;

        terminal = {
          blinking = "on";
          copy_on_select = true;
          font_family = "CaskaydiaCove Nerd Font";
          font_size = 14;
        };
        # --- Appearance ---
        buffer_font_family = "CaskaydiaCove Nerd Font";

        buffer_font_size = 15;
        buffer_font_weight = 300;
        buffer_line_height = "comfortable";
        current_line_highlight = "all";
        selection_highlight = true;
        ui_font_family = "CaskaydiaCove Nerd Font";
        ui_font_size = 18;
        ui_font_weight = 400;
        buffer_font_fallbacks = [
          "CaskaydiaCove Nerd Font"
        ];

        # --- Behavior ---
        auto_indent_on_paste = true;
        auto_signature_help = true;
        cursor_blink = true;
        hide_mouse = "on_typing_and_movement";
        hover_popover_delay = 350;
        hover_popover_enabled = true;
        middle_click_paste = true;
        show_completion_documentation = true;
        show_completions_on_input = true;
        show_edit_predictions = true;
        show_wrap_guides = true;
        use_autoclose = true;
        use_auto_surround = true;
        vim_mode = false;
        wrap_guides = [ ];

        # --- Features And Telemetry ---

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        # --- Gutter ---
        gutter = {
          breakpoints = true;
          code_actions = true;
          folds = true;
          line_numbers = true;
          runnables = true;
        };

        indent_guides = {
        };

        # --- Indent Guides ---
        indent_guides = {
          active_line_width = 1;
          background_coloring = "disabled";
          coloring = "indent_aware"; # "fixed" or "indent_aware"
          enabled = true;
          line_width = 1;
        };

        # --- Scrollbar ---
        scrollbar = {
          axes = {
            horizontal = true;
            vertical = true;
          };
          cursors = true;
          diagnostics = "all";
          git_diff = true;
          search_results = true;
          selected_symbol = true;
          selected_text = true;
          show = "auto";
        };

        # --- Title Bar ---
        title_bar = {
          show_branch_icon = false;
          show_onboarding_banner = true;
          show_user_picture = true;
        };

        # --- Toolbar ---
        toolbar = {
          agent_review = false;
          breadcrumbs = true;
          quick_actions = true;
          selections_menu = true;
        };
      };
      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            ctrl-shift-t = "workspace::NewTerminal";
            ctrl-r = "projects::OpenRecent";
          };
        }
        {
          context = "Terminal";
          bindings = {
            ctrl-c = "terminal::Copy";
            ctrl-v = "terminal::Paste";
          };
        }
      ];
    };
  };
}
