{ inputs, settings, config, pkgs, ... }:
let
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
  # environment.sessionVariables.PYTHONPATH = [ "${pkgs.kitty}/lib/kitty" ];
  home-manager.users.${settings.users.selected.username} = {
    # manually add kitty shell integration
    programs.bash.initExtra = shellIntegrationInit.bash;
    programs.zsh.initExtra = shellIntegrationInit.zsh;
    xdg.configFile = {
      "kitty/diff.conf".text = ''
        ${builtins.readFile ./configs/kitty-diff.conf}
      '';
      "kitty/kitty.conf".text = ''
        shell ${pkgs.zsh}/bin/zsh
        include ~/.cache/ignis/material/dark_colors-kitty.conf

        clear_all_shortcuts yes
        kitty_mod ctrl

        # HACK: send alt+shift+h instead of alt+shift+backspace only when in shell (zsh)
        map alt+shift+backspace kitten replace_alt_shift_backspace.py alt+shift+backspace

        disable_ligatures never

        # ---- URL ---- #
        # URL underline color when hovering with mouse
        url_style curly
        detect_urls yes
        url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
        underline_hyperlinks always
        copy_on_select no

        # ---- Fonts ---- #
        font_family ${settings.fonts.terminals.kitty.name}
        bold_font auto
        italic_font auto
        bold_italic_font auto
        font_size ${toString settings.fonts.terminals.kitty.size}


        # ---- Cursor ---- #
        cursor_shape beam
        cursor_shape_unfocused beam
        cursor_beam_thickness 3
        cursor_blink_interval 0.3 ease-in-out
        cursor_trail 1
        cursor_trail_decay 0.1 0.4
        cursor_trail_start_threshold 2
        cursor_stop_blinking_after 0

        # ---- Scrollbar ---- #
        scrollback_indicator_opacity 1.0
        scrollbar yes

        # ---- Windows Customization ---- #
        remember_window_size no
        window_padding_width 7
        # background_opacity 0.75
        background_opacity 1
        confirm_os_window_close 0
        allow_clipboard_access clipboard_sanitize
        allow_unsafe_paste yes
        hide_window_decorations yes


        # Set a color for comments (ensure they stand out clearly in the terminal)
        # You might need to set a specific color for comments in your editor (like Vim or Bash).
        highlight Comment ctermfg=Green guifg=#15803D  # Lighter comments

        # misc
        map ctrl+shift+f5 load_config_file
        map kitty_mod+k clear_terminal to_cursor active
        map kitty_mod+equal change_font_size all +1.0
        map kitty_mod+minus change_font_size all -1.0
        map kitty_mod+0 change_font_size all 0
        map kitty_mod+c combine : copy_to_clipboard : clear_selection
        #map ctrl+c copy_to_clipboard
        map kitty_mod+v paste_from_clipboard
        #map ctrl+v paste_from_clipboard
        map kitty_mod+x cut_to_clipboard
        map kitty_mod+shift+c send_text all \x03
        map kitty_mod+escape kitty_shell window
        # TODO: use ctrl+f
        # map ctrl+f kitten custom_pass_keys.py ctrl+f show_scrollback

        # scrolling
        map kitty_mod+page_up kitten smart_scroll.py scroll_page_up ctrl+shift+page_up
        map kitty_mod+page_down kitten smart_scroll.py scroll_page_down ctrl+shift+page_down
        map kitty_mod+u kitten smart_scroll.py scroll_page_up ctrl+shift+u
        map kitty_mod+d kitten smart_scroll.py scroll_page_down ctrl+shift+d
        map kitty_mod+home kitten smart_scroll.py scroll_home ctrl+shift+home
        map kitty_mod+end kitten smart_scroll.py scroll_end ctrl+shift+end

        # windows
        map ctrl+up neighboring_window up
        map ctrl+down neighboring_window down
        map ctrl+left neighboring_window left
        map ctrl+right neighboring_window right
        map --when-focus-on var:IS_NVIM ctrl+up
        map --when-focus-on var:IS_NVIM ctrl+down
        map --when-focus-on var:IS_NVIM ctrl+left
        map --when-focus-on var:IS_NVIM ctrl+right

        map ctrl+shift+up kitten custom_pass_keys.py ctrl+shift+up move_window top
        map ctrl+shift+down kitten custom_pass_keys.py ctrl+shift+down move_window bottom
        map ctrl+shift+left kitten custom_pass_keys.py ctrl+shift+left move_window left
        map ctrl+shift+right kitten custom_pass_keys.py ctrl+shift+right move_window right

        map ctrl+shift+alt+up kitten relative_resize.py up 3
        map ctrl+shift+alt+down kitten relative_resize.py down 3
        map ctrl+shift+alt+left kitten relative_resize.py left 3
        map ctrl+shift+alt+right kitten relative_resize.py right 3
        map --when-focus-on var:IS_NVIM ctrl+shift+alt+up
        map --when-focus-on var:IS_NVIM ctrl+shift+alt+down
        map --when-focus-on var:IS_NVIM ctrl+shift+alt+left
        map --when-focus-on var:IS_NVIM ctrl+shift+alt+right

        map ctrl+f4 kitten custom_pass_keys.py ctrl+f4 focus_visible_window
        map ctrl+shift+f4 kitten custom_pass_keys.py ctrl+shift+f4 swap_with_window

        map ctrl+n kitten custom_pass_keys.py ctrl+n next_window
        map ctrl+p kitten custom_pass_keys.py ctrl+p previous_window
        map ctrl+shift+n kitten custom_pass_keys.py ctrl+shift+n move_window_forward
        map ctrl+shift+p kitten custom_pass_keys.py ctrl+shift+p move_window_backward
        map ctrl+enter move_window_to_top
        map ctrl+shift+enter new_window_with_cwd
        map ctrl+shift+alt+enter detach_window
        map kitty_mod+w close_window

        # tabs
        map alt+1 kitten smart_tab.py goto_tab 1 alt+1
        map alt+2 kitten smart_tab.py goto_tab 2 alt+2
        map alt+3 kitten smart_tab.py goto_tab 3 alt+3
        map alt+4 kitten smart_tab.py goto_tab 4 alt+4
        map alt+5 kitten smart_tab.py goto_tab 5 alt+5
        map alt+6 kitten smart_tab.py goto_tab 6 alt+6
        map alt+7 kitten smart_tab.py goto_tab 7 alt+7
        map alt+8 kitten smart_tab.py goto_tab 8 alt+8
        map alt+9 kitten smart_tab.py goto_tab 9 alt+9
        map alt+0 kitten smart_tab.py goto_tab -1 alt+0

        map kitty_mod+q close_tab
        map ctrl+, previous_tab
        map ctrl+. next_tab
        map ctrl+shift+, move_tab_backward
        map ctrl+shift+. move_tab_forward
        # map ctrl+t kitten custom_pass_keys.py ctrl+t set_tab_title
        map ctrl+shift+t new_tab_with_cwd
        map ctrl+shift+alt+t detach_tab

        # layouts
        map kitty_mod+f toggle_layout stack
        map kitty_mod+r>m goto_layout stack
        map kitty_mod+r>t goto_layout tall:bias=50;full_size=1
        map kitty_mod+r>f goto_layout fat:bias=50;full_size=1
        map kitty_mod+r>s goto_layout splits
        map kitty_mod+r>left layout_action increase_num_full_size_windows
        map kitty_mod+r>right layout_action decrease_num_full_size_windows

        # hints
        map kitty_mod+h>l open_url_with_hints
        map kitty_mod+h>n kitten hints --type=linenum --linenum-action=tab nvim +{line} {path}
        map kitty_mod+h>y kitten hints --type hyperlink
        map kitty_mod+h>f kitten hints --type path
        map kitty_mod+h>shift+F kitten hints --type path --program -

        # leader
        map kitty_mod+l>c launch --type overlay zsh -i -c "cht"
        map kitty_mod+l>s kitty_scrollback_nvim --nvim-args kitty-scrollback
        map kitty_mod+l>o kitty_scrollback_nvim --config ksb_builtin_last_cmd_output

        action_alias kitty_scrollback_nvim kitten $XDG_DATA_HOME/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py

        update_check_interval 0
        visual_window_select_characters ABCDEFGHIJKLMNOPQRSTUVWXYZ
        shell_integration no-rc no-cursor enabled
        touch_scroll_multiplier 6.0
        close_on_child_death no
        listen_on unix:@kitty
        allow_remote_control yes
        confirm_os_window_close 2
        enabled_layouts fat:bias=50;full_size=1,tall:bias=50;full_size=1,stack,splits
        focus_follows_mouse yes
        open_url_with default
        placement_strategy top-left
        copy_on_select no
        strip_trailing_spaces smart

        draw_minimal_borders yes
        inactive_text_alpha 0.8
        tab_bar_edge bottom
        window_border_width 1px
        window_margin_width 0

        scrollback_pager_history_size 256
        # TODO: use kitty_scrollback_nvim as scrollback_pager
        # scrollback_pager ~/.config/kitty/scripts/nvim-scrollback.sh 'INPUT_LINE_NUMBER' 'CURSOR_LINE' 'CURSOR_COLUMN'

        # Tab-bar
        active_tab_font_style bold
        inactive_tab_font_style normal
        tab_bar_margin_width 7.0
        tab_bar_margin_height 7.0 0
        tab_bar_style custom
        tab_bar_align left
        tab_separator " "

        # Theme
        # modify_font cell_height 135%

        # - Use additional nerd symbols
        # See https://github.com/be5invis/Iosevka/issues/248
        # See https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
        # IEC Power Symbols
        symbol_map U+23FB-U+23FE Symbols Nerd Font
        # Octicons
        symbol_map U+2665 Symbols Nerd Font
        # Octicons
        symbol_map U+26A1 Symbols Nerd Font
        # IEC Power Symbols
        symbol_map U+2B58 Symbols Nerd Font
        # Pomicons
        symbol_map U+E000-U+E00A Symbols Nerd Font
        # Powerline
        symbol_map U+E0A0-U+E0A2 Symbols Nerd Font
        # Powerline Extra
        symbol_map U+E0A3 Symbols Nerd Font
        # Powerline
        symbol_map U+E0B0-U+E0B3 Symbols Nerd Font
        # Powerline Extra
        symbol_map U+E0B4-U+E0C8 Symbols Nerd Font
        # Powerline Extra
        symbol_map U+E0CA Symbols Nerd Font
        # Powerline Extra
        symbol_map U+E0CC-U+E0D4 Symbols Nerd Font
        # Font Awesome Extension
        symbol_map U+E200-U+E2A9 Symbols Nerd Font
        # Weather Icons
        symbol_map U+E300-U+E3E3 Symbols Nerd Font
        # Seti-UI + Custom
        symbol_map U+E5FA-U+E6A6 Symbols Nerd Font
        # Devicons
        symbol_map U+E700-U+E7C5 Symbols Nerd Font
        # Codicons
        symbol_map U+EA60-U+EBEB Symbols Nerd Font
        # Font Awesome
        symbol_map U+F000-U+F2E0 Symbols Nerd Font
        # Font Logos
        symbol_map U+F300-U+F32F Symbols Nerd Font
        # Octicons
        symbol_map U+F400-U+F532 Symbols Nerd Font
        # Material Design
        symbol_map U+F0001-U+F1AF0 Symbols Nerd Font
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
