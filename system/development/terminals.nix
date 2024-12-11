{ pkgs, ... }: {
  networking.firewall.allowedTCPPortRanges = [
    # wezterm tls server
    {
      from = 60000;
      to = 60010;
    }
  ];

  programs = {
    zsh = {
      enable = true;
      autosuggestions.async = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      enableGlobalCompInit = true;
      ohMyZsh.enable = true;
      zsh-autoenv.enable = true;
      # autosuggestions.strategy = ;
      interactiveShellInit = ''
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      '';
    };
  };

  #__ Terminals __#
  environment.systemPackages = with pkgs; [
    neovim # Vim text editor fork focused on extensibility and agility
    vim # The most popular clone of the VI editor

    tmux # Terminal multiplexer
    fzf-zsh # wrap fzf to use in oh-my-zsh
    oh-my-zsh # A framework for managing your zsh configuration
    zsh # The Z shell
    zsh-abbr
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autoenv
    zsh-autopair
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-better-npm-completion
    zsh-completions # Additional completion definitions for zsh
    zsh-f-sy-h
    zsh-fzf-tab
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh

    # wezterm
    wezterm # GPU-accelerated cross-platform terminal emulator and multiplexer

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

