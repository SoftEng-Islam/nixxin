{ pkgs, ... }: {
  imports = [ ];

  # Collection of useful CLI apps
  environment.systemPackages = with pkgs; [

    iotop # Tool to find out the processes doing the most IO

    du-dust # du + rust = dust. Like du but more intuitive

    duf # Disk Usage/Free Utility

    fd # Simple, fast and user-friendly alternative to find

    file # Program that shows the type of files

    jaq # A command-line JSON processor, Jq clone focused on correctness, speed and simplicity

    xcp # Extended cp(1)
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # Modern, maintained replacement for ls
    fd # Simple, fast and user-friendly alternative to find
    lsd # Next gen ls command
    tree # Command to produce a depth indented directory listing
    less # More advanced file pager than 'more'
    gnugrep # GNU implementation of the Unix grep command

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

    # tea # Gitea official CLI client
    # timer # sleep with progress
    # tio # Serial console TTY
  ];

}
