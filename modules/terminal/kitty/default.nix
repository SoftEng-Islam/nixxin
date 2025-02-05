{ inputs, settings, pkgs, ... }:
let
  unwrapHex = str: builtins.substring 1 (builtins.stringLength str) str;
  shellIntegrationInit = {
    bash = ''
      if test -n "$KITTY_INSTALLATION_DIR"; then
        source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
      fi
    '';
    zsh = ''
      if test -n "$KITTY_INSTALLATION_DIR"; then
        autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
        kitty-integration
        unfunction kitty-integration
      fi
    '';
  };
in {
  environment.systemPackages = with pkgs; [ kitty ];
  home-manager.users.${settings.users.selected.username} = {
    # manually add kitty shell integration
    programs.bash.initExtra = shellIntegrationInit.bash;
    programs.zsh.initExtra = shellIntegrationInit.zsh;
    xdg.configFile = {
      "kitty/diff.conf".text = ''

        # text
        foreground           #4c4f69
        # base
        background           #eff1f5
        # subtext0
        title_fg             #6c6f85

        # mantle
        title_bg             #e6e9ef
        margin_bg            #e6e9ef

        # subtext1
        margin_fg            #5c5f77
        # mantle
        filler_bg            #e6e9ef

        # 30% red, 70% base
        removed_bg           #e6adbc
        # 50% red, 50% base
        highlight_removed_bg #e08097
        # 40% red, 60% base
        removed_margin_bg    #e397aa

        # 30% green, 70% base
        added_bg             #bad8b8
        # 50% green, 50% base
        highlight_added_bg   #97c890
        # 40% green, 60% base
        added_margin_bg      #e397aa

        # mantle
        hunk_margin_bg       #e6e9ef
        hunk_bg              #e6e9ef

        # 40% yellow, 60% base
        search_bg            #e8ca9f
        # text
        search_fg            #4c4f69
        # 30% sky, 70% base
        select_bg            #a8daf0
        # text
        select_fg            #4c4f69
          ${builtins.readFile ./configs/kitty-diff.conf}
      '';
      "kitty/settings.conf".source = ./configs/settings.conf;
      "kitty/kitty.conf".text = ''
        shell ${pkgs.zsh}/bin/zsh
        include ~/.cache/ignis/material/dark_colors-kitty.conf
        include ~/.config/kitty/settings.conf

        tab_title_template "{fmt.bg._${unwrapHex "#737994"}}{fmt.fg._${
          unwrapHex "#15803D"
        }}  {sup.index} 󰓩 {title[:30]}{bell_symbol}{activity_symbol}  {fmt.fg.default}"
        active_tab_title_template "{fmt.bg.default}{fmt.fg._${
          unwrapHex "#e5c890"
        }}{fmt.bg._${unwrapHex "#e5c890"}}{fmt.fg._${
          unwrapHex "#303446"
        }}{sup.index} 󰓩 {title[:30]}{bell_symbol}{activity_symbol} {fmt.bg.default}{fmt.fg._${
          unwrapHex "#e5c890"
        }}{fmt.bg.default}{fmt.fg.default}"


        # The basic colors
        selection_foreground    #303446
        selection_background    #f2d5cf

        # Cursor colors
        cursor_text_color       #303446

        # URL underline color when hovering with mouse
        url_color               #f2d5cf

        # Kitty window border colors
        active_border_color     #babbf1
        inactive_border_color   #737994
        bell_border_color       #e5c890

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        #active_tab_foreground   #232634
        #active_tab_background   #ca9ee6
        #inactive_tab_foreground #c6d0f5
        #inactive_tab_background #292c3c
        #tab_bar_background      #232634

        # Colors for marks (marked text in the terminal)
        mark1_foreground #303446
        mark1_background #babbf1
        mark2_foreground #303446
        mark2_background #ca9ee6
        mark3_foreground #303446
        mark3_background #85c1dc

        # ---- Fonts ---- #
        font_family ${settings.fonts.terminals.kitty.name}
        bold_font ${settings.fonts.terminals.kitty.bold_font}
        italic_font ${settings.fonts.terminals.kitty.italic_font}
        bold_italic_font ${settings.fonts.terminals.kitty.bold_italic_font}
        font_size ${toString settings.fonts.terminals.kitty.size}

      '';
      "kitty/open-actions.conf".source = ./configs/open-actions.conf;
      "kitty/mime.types".source = ./configs/mime.types;

      "kitty/tab_bar.py" = {
        source = ./configs/tab_bar.py;
        executable = true;
      };

      # scripts
      "kitty/scripts" = {
        recursive = true;
        source = ./scripts;
      };

      # kittens
      "kitty/replace_alt_shift_backspace.py" = {
        source = ./configs/replace_alt_shift_backspace.py;
        executable = true;
      };
      "kitty/custom_pass_keys.py" = {
        source = ./configs/custom_pass_keys.py;
        executable = true;
      };
      "kitty/neighboring_window.py" = {
        source = "${inputs.smart-splits-nvim}/kitty/neighboring_window.py";
        executable = true;
      };
      "kitty/relative_resize.py" = {
        source = "${inputs.smart-splits-nvim}/kitty/relative_resize.py";
        executable = true;
      };
      "kitty/kitty_scrollback_nvim.py" = {
        source =
          "${inputs.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
        executable = true;
      };
      "kitty/smart_scroll.py" = {
        source = "${inputs.kitty-smart-scroll}/smart_scroll.py";
        executable = true;
      };
      "kitty/smart_tab.py" = {
        source = "${inputs.kitty-smart-tab}/smart_tab.py";
        executable = true;
      };
    };
  };
}
