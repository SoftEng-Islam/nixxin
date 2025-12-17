{ settings, lib, pkgs, ... }:
# lib.mkIf (settings.modules.cli_tools.enable or false)
{
  imports = [ ./neofetch ./prompt ./shells ./terminals ./utilities ];

  # Enable the nix-index
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
  # programs.nix-index.enableFishIntegration = true;

  # for home-manager, use programs.bash.initExtra instead
  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  environment.variables = {
    # Don't add certain commands to the history file.
    HISTIGNORE = "&:[bf]g:c:clear:history:exit:q:pwd:* --help";

    # Ignore commands that start with spaces and duplicates.
    HISTCONTROL = "ignoreboth";

  };
  environment.systemPackages = with pkgs; [
    bashInteractive

    nanorc # Improved Nano Syntax Highlighting Files
    micro # Modern and intuitive terminal-based text editor
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
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    # powerline # Ultimate statusline/prompt utility
    # powerline-fonts
    # powerline-rs
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # A modern, maintained replacement for ls
    fzf # Command-line fuzzy finder written in Go

    bat # Cat(1) clone with syntax highlighting and Git integration
    dust # du + rust = dust. Like du but more intuitive
    duf # Disk Usage/Free Utility
    file # Program that shows the type of files
    gnugrep # GNU implementation of the Unix grep command
    iotop # Tool to find out the processes doing the most IO
    jaq # A command-line JSON processor, Jq clone focused on correctness, speed and simplicity
    less # More advanced file pager than 'more'
    lsd # Next gen ls command
    tree # Command to produce a depth indented directory listing
    xcp # Extended cp(1)

    # Command-line tools to easily kill processes running on a specified port
    killall
    killport

    gnused # GNU sed, a batch stream editor
    gum # Tasty Bubble Gum for your shell

    ncurses # Free software emulation of curses in SVR4 and more
    nurl # Command-line tool to generate Nix fetcher calls from repository URLs
    ouch # Command-line utility for easily compressing and decompressing files and directories

    procs # Modern replacement for ps written in Rust
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    tea # Gitea official CLI client
    timer # sleep with progress
    tio # Serial console TTY

    pv

    # Fast incremental file transfer utility
    # rsync -ah --progress source/ destination/
    rsync

    glow # markdown previewer in terminal
  ];
}
