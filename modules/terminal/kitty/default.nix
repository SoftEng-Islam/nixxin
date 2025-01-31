{ settings, config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kitty ];
  home-manager.users.${settings.users.selected.username} = {
    home.file.".config/kitty/kitty.conf".text = ''
      # include ~/.local/cache/ignis/material/dark_colors-kitty.conf

      # ---- basic colors ---- #
      # background #${config.lib.stylix.colors.base01}
      # foreground #${config.lib.stylix.colors.base07}

      # ---- Cursor colors ---- #
      # cursor #${settings.style.mainColor}
      # cursor_text_color #${config.lib.stylix.colors.base0A}
      # selection_background #${config.lib.stylix.colors.base04}
      # selection_foreground #${config.lib.stylix.colors.base06}

      # url_color #${config.lib.stylix.colors.base11}
      # cursor #${config.lib.stylix.colors.base11}

      # active_border_color #${config.lib.stylix.colors.base11}
      # active_tab_background #${config.lib.stylix.colors.base01}
      # active_tab_foreground #${config.lib.stylix.colors.base05}
      # inactive_border_color #${config.lib.stylix.colors.base03}
      # inactive_tab_background #${config.lib.stylix.colors.base02}
      # inactive_tab_foreground #${config.lib.stylix.colors.base04}
      # tab_bar_background #${config.lib.stylix.colors.base01}

      # ---- Tab Bar ---- #
      active_tab_font_style   bold
      inactive_tab_font_style normal
      tab_bar_align left
      tab_bar_edge top
      tab_bar_min_tabs 1
      tab_bar_style separator
      tab_separator " ┇ "
      tab_switch_strategy previous
      tab_title_max_length 25
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"

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
      window_padding_width 14
      background_opacity 1
      confirm_os_window_close 0
      allow_clipboard_access clipboard_sanitize
      allow_unsafe_paste yes
      hide_window_decorations yes

      # ---- Key bindings ---- #
      map ctrl+c copy_to_clipboard
      map ctrl+v paste_from_clipboard
      map ctrl+x cut_to_clipboard
      map ctrl+shift+c send_text all \x03

      # Set a color for comments (ensure they stand out clearly in the terminal)
      # You might need to set a specific color for comments in your editor (like Vim or Bash).
      # highlight Comment ctermfg=Green guifg=#${config.lib.stylix.colors.base02}  # Lighter green for comments
    '';
  };
}
