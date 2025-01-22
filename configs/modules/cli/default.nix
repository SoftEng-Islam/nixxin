{ pkgs, ... }: {
  imports = [ ./curl ./git ./wifi ];

  # Collection of useful CLI apps
  environment.systemPackages = with pkgs; [
    iotop # io monitoring
    iftop # network monitoring

    calc # C-style arbitrary precision calculator

    # misc
    sshfs

    # utils
    du-dust
    duf
    fd
    file
    jaq

    xcp # Extended cp(1)
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # Modern, maintained replacement for ls
    fd # Simple, fast and user-friendly alternative to find
    lsd # Next gen ls command
    tree # Command to produce a depth indented directory listing
    less # More advanced file pager than 'more'
    gnugrep # GNU implementation of the Unix grep command
    killall

    gnused # GNU sed, a batch stream editor
    gum # Tasty Bubble Gum for your shell
    jq # Lightweight and flexible command-line JSON processor

    ncurses # Free software emulation of curses in SVR4 and more
    nurl # Command-line tool to generate Nix fetcher calls from repository URLs
    ouch # Command-line utility for easily compressing and decompressing files and directories
    # procs # Modern replacement for ps written in Rust
    # psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    # ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    # tea # Gitea official CLI client
    # timer # sleep with progress
    # tio # Serial console TTY
  ];

}
