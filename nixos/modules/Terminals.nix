{ pkgs, ... }: {
  #__ Terminals __#
  environment.systemPackages = with pkgs; [
    powerline
    powerline-fonts
    powerline-rs
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # A modern, maintained replacement for ls
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    fish # Smart and user-friendly command line shell
    fzf # Command-line fuzzy finder written in Go
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    nanorc # Improved Nano Syntax Highlighting Files
    tmux
  ];
}

