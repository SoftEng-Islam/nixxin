{ settings, pkgs, ... }: {
  imports = [
    # ---- Dirs ---- #
    # ./alacritty
    # ./fish
    # ./foot
    ./kitty
    # ./neofetch
    # ./nvim
    # ./wezterm

    # ---- Files ---- #
    ./bash.nix
    ./direnv.nix
    # ./emacs.nix
    # ./eza.nix
    # ./fd.nix
    # ./fzf.nix
    # ./lf.nix
    # ./shell.nix
    # ./starship.nix
    # ./tmux.nix
    ./zsh.nix
    # ./tmux.nix
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager.users.${settings.username} = {
    home.file.".config/fish".source = ./fish;
  };

  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    bashInteractive

    nanorc # Improved Nano Syntax Highlighting Files
    vim # The most popular clone of the VI editor
    zsh # The Z shell

    fzf-zsh # wrap fzf to use in oh-my-zsh
    oh-my-zsh # A framework for managing your zsh configuration
    zsh-abbr # Zsh manager for auto-expanding abbreviations, inspired by fish shell
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autoenv # Automatically sources whitelisted .autoenv.zsh files
    zsh-autopair # Plugin that auto-closes, deletes and skips over matching delimiters in zsh intelligently
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-better-npm-completion
    zsh-completions # Additional completion definitions for zsh
    zsh-f-sy-h
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    # powerline # Ultimate statusline/prompt utility
    # powerline-fonts
    # powerline-rs
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # A modern, maintained replacement for ls
    fzf # Command-line fuzzy finder written in Go
  ];
}
