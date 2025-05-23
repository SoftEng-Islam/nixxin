{ settings, inputs, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
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
  config = mkIf (settings.modules.terminals.kitty.enable or true) {
    environment.systemPackages = with pkgs; [ kitty ];
    home-manager.users.${settings.user.username} = {
      # Manually add kitty shell integration
      programs.bash.initExtra = shellIntegrationInit.bash;
      programs.zsh.initExtra = shellIntegrationInit.zsh;

      xdg.configFile = {
        # "kitty/settings.conf".source = ./settings.conf;
        "kitty/kitty.conf".text = ''
          shell ${pkgs.zsh}/bin/zsh
          # include ~/.config/kitty/settings.conf
          clear_all_shortcuts yes
          kitty_mod ctrl

          # ---- Color scheme ---- #
          foreground #7c7c7c
          background #00080b
          selection_foreground    #101b1f
          selection_background    #9c9c9c
          color0       #00384d
          color8       #517f8d

          #: black

          color1       #c43061
          color9       #ff5a67

          #: red

          color2       #7fc06e
          color10      #9cf087

          #: green

          color3       #f08e48
          color11      #ffcc1b

          #: yellow

          color4       #1c8db2
          color12      #7eb2dd

          #: blue

          color5       #c694ff
          color13      #fb94ff

          #: magenta

          color6       #00cccc
          color14      #00ffff

          #: cyan

          color7       #77929e
          color15      #b7cff9


          # Colors for marks (marked text in the terminal)
          mark1_foreground #242424
          mark1_background #98d3cb
          mark2_foreground #242424
          mark2_background #f2dcd3
          mark3_foreground #242424
          mark3_background #f274bc



          # ---- InActive Tab ---- #
          tab_title_template "{fmt.bg.default}{fmt.fg._${
            unwrapHex "#303446"
          }}{fmt.bg._${unwrapHex "#303446"}}{fmt.fg._${
            unwrapHex "#e5c890"
          }}{sup.index} 󰓩 {title[:30]}{bell_symbol}{activity_symbol} {fmt.bg.default}{fmt.fg._${
            unwrapHex "#303446"
          }}{fmt.bg.default}{fmt.fg.default}"

          # ---- Active Tab ---- #
          active_tab_title_template "{fmt.bg.default}{fmt.fg._${
            unwrapHex "#e5c890"
          }}{fmt.bg._${unwrapHex "#e5c890"}}{fmt.fg._${
            unwrapHex "#303446"
          }}{sup.index} 󰓩 {title[:30]}{bell_symbol}{activity_symbol} {fmt.bg.default}{fmt.fg._${
            unwrapHex "#e5c890"
          }}{fmt.bg.default}{fmt.fg.default}"

          # Cursor colors
          cursor_text_color       #303446

          # URL underline color when hovering with mouse
          url_color               #0087bd

          # OS Window titlebar colors
          wayland_titlebar_color system
          macos_titlebar_color system

          # ---- Fonts ---- #
          font_family ${settings.modules.terminals.kitty.fontFamily}
          bold_font ${settings.modules.terminals.kitty.fontBold}
          italic_font ${settings.modules.terminals.kitty.fontItalic}
          bold_italic_font ${settings.modules.terminals.kitty.fontBoldItalic}
          font_size ${toString settings.modules.terminals.kitty.fontSize}


          input_delay 3
          repaint_delay 10
          sync_to_monitor yes
          wayland_enable_ime no
          mouse_hide_wait 1
          disable_ligatures never
          visual_bell_duration 0.0
          adjust_line_height 0
          adjust_column_width 0

          # Enable proper BiDi & shaping
          bidi_disable no
          text_composition_strategy legacy


          # misc
          map ctrl+shift+f5 load_config_file
          map kitty_mod+k clear_terminal to_cursor active
          map kitty_mod+equal change_font_size all +1.0
          map kitty_mod+minus change_font_size all -1.0
          map kitty_mod+0 change_font_size all 0
          map kitty_mod+c combine : copy_to_clipboard : clear_selection
          map kitty_mod+v paste_from_clipboard
          map kitty_mod+x cut_to_clipboard
          map kitty_mod+shift+c send_text all \x03
          map kitty_mod+escape kitty_shell window

          # ---- Cursor ---- #
          cursor_shape beam
          cursor_shape_unfocused beam
          cursor_beam_thickness 2
          cursor_blink_interval 0.2 ease-in-out
          cursor_trail 1
          cursor_trail_decay 0.1 0.4
          cursor_trail_start_threshold 2
          cursor_stop_blinking_after 0

          # ---- URL ---- #
          # URL underline color when hovering with mouse
          url_style curly
          detect_urls yes
          underline_hyperlinks always
          url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh
          mouse_map left click ungrabbed mouse_handle_click prompt
          mouse_map ctrl+left click ungrabbed mouse_handle_click link

          # ---- Windows Customization ---- #
          remember_window_size no
          window_padding_width 7
          background_opacity 0.75
          confirm_os_window_close 0
          hide_window_decorations yes

          draw_minimal_borders yes
          inactive_text_alpha 0.8
          tab_bar_edge bottom
          window_border_width 0
          window_margin_width 0

          # ---- Tab ---- #
          active_tab_font_style bold
          inactive_tab_font_style normal
          tab_bar_margin_width 7.0
          tab_bar_margin_height 7.0 0
          tab_bar_style custom
          tab_bar_align left
          tab_separator " - "
          map kitty_mod+right next_tab
          map kitty_mod+left  previous_tab
          map kitty_mod+shift+t     new_tab
          map kitty_mod+shift+q     close_tab
          map kitty_mod+.     move_tab_forward
          map kitty_mod+,     move_tab_backward
          map kitty_mod+alt+t set_tab_title

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
      };
    };
  };
}
