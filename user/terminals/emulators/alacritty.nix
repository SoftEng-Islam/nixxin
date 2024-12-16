{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors.primary.background = "#1d2021";
      scrolling.history = 10000;
      # draw_bold_text_with_bright_colors = true;
      window = {
        opacity = 0.95;
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };
      font = {
        size = 13;
        draw_bold_text_with_bright_colors = true;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        bold.family = "JetBrains Mono";
        italic.family = "JetBrains Mono";
      };
      imports = [
        (pkgs.fetchurl {
          url =
            "https://raw.githubusercontent.com/catppuccin/alacritty/3c808cbb4f9c87be43ba5241bc57373c793d2f17/catppuccin-mocha.yml";
          hash = "sha256-28Tvtf8A/rx40J9PKXH6NL3h/OKfn3TQT1K9G8iWCkM=";
        })
      ];
    };
  };
}
