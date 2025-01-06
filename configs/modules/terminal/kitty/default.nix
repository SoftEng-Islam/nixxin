{ settings, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/kitty/kitty.conf".text = ''
      # include ~/.config/kitty/base24.conf

      # The basic colors
      background #282c34
      foreground #abb2bf
      selection_background #abb2bf
      selection_foreground #282c34

      # Cursor colors
      cursor #9151ff
      cursor_text_color #f4a261

      # Kitty window border colors
      # active_border_color #545862
      # inactive_border_color #3f4451

      # OS Window titlebar colors
      wayland_titlebar_color #1e2129
      macos_titlebar_color #1e2129

      # Tab bar colors
      # tab_bar_background #282c34
      tab_bar_background none
      active_tab_background #282c34
      active_tab_foreground #ff5e5e
      inactive_tab_background #3f4859
      inactive_tab_foreground #c49cdb

      # The 16 terminal colors
      # normal
      color0 #282c34
      color1 #e05561
      color2 #8cc265
      color3 #e6b965
      color4 #4aa5f0
      color5 #c162de
      color6 #42b3c2
      color7 #abb2bf

      # bright
      color8 #4f5666
      color9 #ff616e
      color10 #a5e075
      color11 #f0a45d
      color12 #4dc4ff
      color13 #de73ff
      color14 #4cd1e0
      color15 #ffffff

      # extended base16 colors
      color16 #d18f52
      color17 #bf4034
      color18 #2e3440
      color19 #3f4859
      color20 #6c7686
      color21 #d8dee9


      # URL underline color when hovering with mouse
      url_color #0087bd
      url_style curly
      detect_urls yes
      url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
      underline_hyperlinks always
      copy_on_select yes

      # Fonts
      font_family ${settings.TerminalsFontName}
      bold_font auto
      italic_font auto
      bold_italic_font auto
      font_size ${toString settings.TerminalsFontSize}

      terminal_select_modifiers shift
      strip_trailing_spaces never

      #adjust_line_height  30%
      #adjust_column_width 5%
      input_delay 3
      kitty -o allow_remote_control=yes
      mouse_hide_wait 1
      repaint_delay 10
      sync_to_monitor yes
      wayland_enable_ime no
      window_decorations none

      # Cursor
      cursor_shape beam
      cursor_shape_unfocused beam
      cursor_beam_thickness 2.5
      cursor_blink_interval 0.3 ease-in-out
      cursor_trail 1
      cursor_trail_decay 0.1 0.4
      cursor_trail_start_threshold 2
      cursor_stop_blinking_after 0

      # Scrollbar
      scrollback_indicator_opacity 1.0
      scrollbar yes

      # Tab bar
      active_tab_font_style   bold-italic
      inactive_tab_font_style normal
      tab_bar_align left
      tab_bar_edge top
      tab_bar_margin_height 0.0 0.0
      tab_bar_margin_width 0.0
      tab_bar_min_tabs 1
      tab_bar_style separator
      tab_separator " ┇ "
      tab_switch_strategy previous
      tab_title_max_length 25
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"

      # Windows Customization
      #window_margin_width 15
      remember_window_size no
      window_padding_width 14
      background_opacity 1
      confirm_os_window_close 0
      allow_clipboard_access clipboard_sanitize
      allow_unsafe_paste yes
      hide_window_decorations yes

      # Key binding
      # Copy selected text to clipboard with Ctrl+C
      map ctrl+c copy_to_clipboard
      # Paste from clipboard with Ctrl+V
      map ctrl+v paste_from_clipboard
      # Cut selected text to clipboard with Ctrl+X
      map ctrl+x cut_to_clipboard
      # Terminate the terminal with Ctrl+Shift+C
      map ctrl+shift+c send_text all \x03
    '';
  };
}
