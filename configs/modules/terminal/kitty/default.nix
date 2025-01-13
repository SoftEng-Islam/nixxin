{ settings, config, ... }: {
  home-manager.users.${settings.username} = {
    home.file.".config/kitty/kitty.conf".text = ''
            # include ~/.config/kitty/base24.conf


      # Gruvbox Dark
      # Scheme by Iterm2B24
            background #1d1d1d
            foreground #91816c
            selection_background #91816c
            selection_foreground #1d1d1d
            url_color #8b7b68
            cursor #91816c
            active_border_color #857564
            inactive_border_color #1d1d1d
            active_tab_background #1d1d1d
            active_tab_foreground #91816c
            inactive_tab_background #1d1d1d
            inactive_tab_foreground #8b7b68

            # normal
            color0 #1d1d1d
            color1 #be0e17
            color2 #868715
            color3 #cc871a
            color4 #377274
            color5 #9f4b73
            color6 #568d57
            color7 #978771

            # bright
            color8 #7f7060
            color9 #f63028
            color10 #a9b01d
            color11 #f7b024
            color12 #709585
            color13 #c76f89
            color14 #7db568
            color15 #e5d3a2


            # normal
            color0 #${config.lib.stylix.colors.base01}
            color1 #${config.lib.stylix.colors.base08}
            color2 #${config.lib.stylix.colors.base0B}
            color3 #${config.lib.stylix.colors.base09}
            color4 #${config.lib.stylix.colors.base0C}
            color5 #${config.lib.stylix.colors.base0D}
            color6 #${config.lib.stylix.colors.base0E}
            color7 #${config.lib.stylix.colors.base0F}

            # bright
            color8 #${config.lib.stylix.colors.base02}
            color9 #${config.lib.stylix.colors.base12}
            color10 #${config.lib.stylix.colors.base14}
            color11 #${config.lib.stylix.colors.base13}
            color12 #${config.lib.stylix.colors.base15}
            color13 #${config.lib.stylix.colors.base17}
            color14 #${config.lib.stylix.colors.base16}
            color15 #${config.lib.stylix.colors.base04}

            # extended base16 colors
            color16 #${config.lib.stylix.colors.base0A}
            color17 #${config.lib.stylix.colors.base12}
            color18 #${config.lib.stylix.colors.base00}
            color19 #${config.lib.stylix.colors.base01}
            color20 #${config.lib.stylix.colors.base02}
            color21 #${config.lib.stylix.colors.base03}

            # The basic colors
            background #${config.lib.stylix.colors.base11}
            foreground #${config.lib.stylix.colors.base05}

            # Cursor colors
            cursor #${settings.accentColor}
            cursor_text_color #${config.lib.stylix.colors.base0A}

            # Kitty window border colors
            wayland_titlebar_color #1e2129
            macos_titlebar_color #1e2129

            # Tab bar
            tab_bar_background #${config.lib.stylix.colors.base01}
            active_tab_background #${config.lib.stylix.colors.base11}
            active_tab_foreground ${settings.accentColor}
            inactive_tab_background #${config.lib.stylix.colors.base02}
            inactive_tab_foreground #${config.lib.stylix.colors.base0D}
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
            url_color #${config.lib.stylix.colors.base0B}
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
            highlight Comment ctermfg=Green guifg=#${config.lib.stylix.colors.base02}  # Lighter green for comments
    '';
  };
}
