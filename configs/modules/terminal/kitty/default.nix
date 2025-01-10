{ settings, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/kitty/kitty.conf".text = ''
      # include ~/.config/kitty/base24.conf
      # The 16 terminal colors
      # normal
      color0 #1e2129  # Darker background for comments
      color1 #e05561
      color2 #8cc265
      color3 #e6b965
      color4 #4aa5f0
      color5 #c162de
      color6 #42b3c2
      color7 #abb2bf  # Lighter color for regular text

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

      # The basic colors
      background #1e2129  # Changed to a darker background
      foreground #abb2bf  # Light color for text

      # Cursor colors
      cursor #9151ff
      cursor_text_color #f4a261

      # Kitty window border colors
      wayland_titlebar_color #1e2129
      macos_titlebar_color #1e2129

      # Tab bar
      tab_bar_background #31343c
      active_tab_background #282c34
      active_tab_foreground #ff5e5e
      inactive_tab_background #3f4451
      inactive_tab_foreground #744f89
      active_tab_font_style   bold
      inactive_tab_font_style normal
      tab_bar_align left
      tab_bar_edge top
      tab_bar_margin_height 1.0 1.0
      tab_bar_margin_width 1.0
      tab_bar_min_tabs 1
      tab_bar_style separator
      tab_separator " ┇ "
      tab_switch_strategy previous
      tab_title_max_length 25
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"

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

      # Cursor settings
      cursor_shape beam
      cursor_shape_unfocused beam
      cursor_beam_thickness 3
      cursor_blink_interval 0.3 ease-in-out
      cursor_trail 1
      cursor_trail_decay 0.1 0.4
      cursor_trail_start_threshold 2
      cursor_stop_blinking_after 0

      # Scrollbar settings
      scrollback_indicator_opacity 1.0
      scrollbar yes

      # Windows Customization
      remember_window_size no
      window_padding_width 14
      background_opacity 1
      confirm_os_window_close 0
      allow_clipboard_access clipboard_sanitize
      allow_unsafe_paste yes
      hide_window_decorations yes

      # Key bindings for common actions
      map ctrl+c copy_to_clipboard
      map ctrl+v paste_from_clipboard
      map ctrl+x cut_to_clipboard
      map ctrl+shift+c send_text all \x03

      # Set a color for comments (ensure they stand out clearly in the terminal)
      # You might need to set a specific color for comments in your editor (like Vim or Bash).
      highlight Comment ctermfg=Green guifg=#6c7686  # Lighter green for comments
    '';
  };
}
