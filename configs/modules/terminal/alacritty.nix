{ ... }: {
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
    };
  };
}
