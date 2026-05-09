{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetOptions = [
      "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
    ];

    changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetOptions = [
      "--preview 'eza --tree --color=always {} | head -200'"
    ];

    colors = {
      "bg" = "#011628";
      "bg+" = "#143652";
      "fg" = "#CBE0F0";
      "header" = "#2CF9ED";
      "hl" = "#B388FF";
      "hl+" = "#B388FF";
      "info" = "#06BCE4";
      "marker" = "#2CF9ED";
      "pointer" = "#2CF9ED";
      "prompt" = "#2CF9ED";
      "spinner" = "#2CF9ED";
    };
  };
}
