{ settings, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/kitty/vim-mode.lua".text = ''
      local api = vim.api
      local orig_buf = api.nvim_get_current_buf()
      local term_buf = api.nvim_create_buf(false, true)
      api.nvim_set_current_buf(term_buf)
      vim.bo.scrollback = 100000
      local term_chan = api.nvim_open_term(0, {})
      api.nvim_chan_send(term_chan, table.concat(api.nvim_buf_get_lines(orig_buf, 0, -1, true), "\r\n"))
      vim.fn.chanclose(term_chan)
      api.nvim_buf_set_lines(orig_buf, 0, -1, true, api.nvim_buf_get_lines(term_buf, 0, -1, true))
      api.nvim_set_current_buf(orig_buf)
      api.nvim_buf_delete(term_buf, { force = true })
      vim.bo.modified = false
      api.nvim_win_set_cursor(0, {api.nvim_buf_line_count(0), 0})
    '';
    home.file.".config/kitty/kitty.conf".text = ''
      # include ~/.config/kitty/base24.conf

      # The basic colors
      background #282c34
      foreground #abb2bf
      selection_background #abb2bf
      selection_foreground #282c34

      # Cursor colors
      cursor #9151ff
      cursor_text_color #1E1E2E

      # Kitty window border colors
      active_border_color #545862
      inactive_border_color #3f4451

      # OS Window titlebar colors
      wayland_titlebar_color #282c34
      macos_titlebar_color #282c34

      # Tab bar colors
      active_tab_background #282c34
      active_tab_foreground #abb2bf
      inactive_tab_background #3f4451
      inactive_tab_foreground #9196a1
      tab_bar_background #3f4451

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
      color18 #3f4451
      color19 #4f5666
      color20 #9196a1
      color21 #e6e6e6


      # URL underline color when hovering with mouse
      url_color #0087bd
      url_style curly
      detect_urls yes
      url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
      underline_hyperlinks always
      copy_on_select yes

      # Fonts
      font_family CaskaydiaCove Nerd Font Mono
      bold_font auto
      italic_font auto
      bold_italic_font auto
      font_size 12.0




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

      # Scrollbar
      scrollback_indicator_opacity 1.0
      scrollbar yes

      # Tab bar
      tab_bar_edge top
      tab_bar_margin_width 0.0
      tab_bar_margin_height 0.0 0.0
      tab_bar_style slant
      tab_bar_align left
      tab_bar_min_tabs 1
      tab_switch_strategy previous
      tab_fade 0.25 0.5 0.75 1
      tab_separator " ┇"
      tab_powerline_style angled
      tab_activity_symbol none
      tab_title_max_length 30
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
      active_tab_font_style   bold-italic
      inactive_tab_font_style normal

      # Windows Customization
      #window_margin_width 15
      remember_window_size no
      window_padding_width 14
      background_opacity 1
      confirm_os_window_close 0
      allow_clipboard_access clipboard_sanitize
      allow_unsafe_paste yes

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
