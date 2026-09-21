{
  theme = {
    mode = "dark"; # dark | light | auto
    source = "wallpaper"; # builtin | wallpaper | community
    builtin = "Rosé Pine"; # Ayu | Catppuccin | Dracula | Eldritch | Gruvbox |
    # Kanagawa | Noctalia | Nord | Rosé Pine | Tokyo-Night
    community_palette = "Oxocarbon"; # fetched from api.noctalia.dev, cached locally
    wallpaper_scheme = "m3-content"; # m3-tonal-spot | m3-content | m3-fruit-salad |
    # m3-rainbow | m3-monochrome | vibrant | faithful |
    # dysfunctional | muted
    pure_black_dark = true; # anchor dark surfaces to true black (OLED); applies to
    # every palette source, not just wallpaper-generated ones

    templates = {
      enable_builtin_templates = true;
      enable_community_templates = true;
      builtin_ids = [
        "btop"
        "gtk3"
        "gtk4"
        "hyprland"
        "qt"
        "scroll"
        "starship"
        "wezterm"
      ]; # opt-in; list ids with: noctalia theme --list-templates
      community_ids = [
        "antigravity"
        "claude-code"
        "codex"
        "brave"
        "discord"
        "telegram"
        "inkscape"
        "libreoffice"
        "micro"
        "obsidian"
        "vscode"
        "zed"
        "steam"
        "obs"
        "siyuan"
        "papirus-icons"
        "bat"
        "fzf"
        "glow"
        "yazi"
      ]; # fetched from api.noctalia.dev/templates, cached locally
    };

    # User-defined templates are declared directly in config.
    # [theme.templates.user.my_app]
    # input_path  = "templates/my-app.css"
    # output_path = "~/.config/my-app/theme.css"
    # post_hook   = "my-app --reload-theme"
  };
}
