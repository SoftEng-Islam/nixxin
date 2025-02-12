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
  home-manager.users.${settings.user.username} = {
    # manually add kitty shell integration
    programs.bash.initExtra = shellIntegrationInit.bash;
    programs.zsh.initExtra = shellIntegrationInit.zsh;
    xdg.configFile = {
      "kitty/settings.conf".source = ./settings.conf;
      "kitty/kitty.conf".text = ''
        shell ${pkgs.zsh}/bin/zsh
        include ~/.cache/ignis/material/dark_colors-kitty.conf
        include ~/.config/kitty/settings.conf

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

        # The basic colors
        selection_foreground    #303446
        selection_background    #f2d5cf

        # Cursor colors
        cursor_text_color       #303446

        # URL underline color when hovering with mouse
        url_color               #f2d5cf

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

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
    };
  };
}
