{ ... }: {
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
  # programs.kitty = {
  #   enable = true;
  #   shellIntegration.enableZshIntegration = true;
  # theme = "Catppuccin-Mocha";
  # font = {
  #   size = 10;
  #   name = "JetBrains Mono";
  # };
  # settings = {
  #   active_tab_font_style = "bold";
  #   bold_font = "auto";
  #   bold_italic_font = "auto";
  #   cursor_blink_interval = "-1";
  #   cursor_shape = "underline";
  #   cursor_stop_blinking_after = 0;
  #   cursor_underline_thickness = "1.5";
  #   disable_ligatures = "never";
  #   editor = "nvim";
  #   font_family = settings.font;
  #   font_size = settings.fontSize;
  #   hide_window_decorations = "titlebar-only";
  #   inactive_tab_font_style = "normal";
  #   inactive_text_alpha = "1.0";
  #   italic_font = "auto";
  #   placement_strategy = "center";
  #   resize_in_steps = "yes";
  #   scrollback_lines = 10000;
  #   touch_scroll_multiplier = "1.0";
  #   wheel_scroll_multiplier = "5.0";
  #   window_margin_width = 0;
  #   window_padding_width = 15;
  #   scrollback_pager = ''
  #     nvim +"source /home/serpentian/.config/kitty/vim-mode.lua"
  #   '';
  #   allow_remote_control = "yes";
  #   enable_audio_bell = "no";
  #   visual_bell_duration = "0.1";
  #   copy_on_select = "clipboard";
  #   selection_foreground = "none";
  #   selection_background = "none";
  #   # colors
  #   background_opacity = "0.9";
  # };
  # keybindings = {
  #   "ctrl+shift+v" = "paste_from_clipboard";
  #   "ctrl+shift+s" = "paste_from_selection";
  #   "ctrl+shift+c" = "copy_to_clipboard";
  #   "shift+insert" = "paste_from_selection";

  #   "ctrl+shift+up" = "scroll_line_up";
  #   "ctrl+shift+down" = "scroll_line_down";
  #   "ctrl+shift+k" = "scroll_line_up";
  #   "ctrl+shift+j" = "scroll_line_down";
  #   "ctrl+shift+page_up" = "scroll_page_up";
  #   "ctrl+shift+page_down" = "scroll_page_down";
  #   "ctrl+shift+home" = "scroll_home";
  #   "ctrl+shift+end" = "scroll_end";
  #   "ctrl+shift+h" = "show_scrollback";

  #   "ctrl+shift+enter" = "new_window";
  #   "ctrl+shift+n" = "new_os_window";
  #   "ctrl+shift+w" = "close_window";
  #   "ctrl+shift+]" = "next_window";
  #   "ctrl+shift+[" = "previous_window";
  #   "ctrl+shift+f" = "move_window_forward";
  #   "ctrl+shift+b" = "move_window_backward";
  #   "ctrl+shift+`" = "move_window_to_top";
  #   "ctrl+shift+1" = "first_window";
  #   "ctrl+shift+2" = "second_window";
  #   "ctrl+shift+3" = "third_window";
  #   "ctrl+shift+4" = "fourth_window";
  #   "ctrl+shift+5" = "fifth_window";
  #   "ctrl+shift+6" = "sixth_window";
  #   "ctrl+shift+7" = "seventh_window";
  #   "ctrl+shift+8" = "eighth_window";
  #   "ctrl+shift+9" = "ninth_window";
  #   "ctrl+shift+0" = "tenth_window";
  # };
  # };
  home.file.".config/kitty/kitty.conf".text = ''
    # include ~/.cache/ignis/material/dark_colors-kitty.conf

      # The basic colors
      foreground           #CDD6F4
      background           #1E1E2E
      selection_foreground #1E1E2E
      selection_background #F5E0DC
      # Cursor colors
      cursor            #F5E0DC
      cursor_text_color #1E1E2E

      # URL underline color when hovering with mouse
      url_color #0087bd
      url_style curly
      detect_urls yes
      url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
      underline_hyperlinks always
      copy_on_select yes

      # Tab bar colors
      active_tab_foreground   #11111B
      active_tab_background   #CBA6F7
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #181825
      # tab_bar_background      #11111B

      # Fonts
      font_family CaskaydiaCove Nerd Font Mono
      bold_font auto
      italic_font auto
      bold_italic_font auto
      font_size 12.0


      input_delay 3
      repaint_delay 10
      sync_to_monitor yes
      wayland_enable_ime no
      mouse_hide_wait 1

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
      tab_bar_style fade # fade slant separator powerline
      tab_bar_align left
      tab_bar_min_tabs 1
      tab_switch_strategy previous
      tab_fade 0.25 0.5 0.75 1
      tab_separator " ┇"
      tab_powerline_style angled
      tab_activity_symbol none
      tab_title_max_length 30
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
      active_tab_foreground   #000
      active_tab_background   #eee
      active_tab_font_style   bold-italic
      inactive_tab_foreground #444
      inactive_tab_background #999
      inactive_tab_font_style normal

      # Windows Customization
      window_margin_width 15
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
}
