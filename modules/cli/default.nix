{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.cli.enable) {
  imports = [ ./bat.nix ./eza.nix ./fd.nix ./fzf.nix ./lf.nix ./lout.nix ];
  environment.systemPackages = with pkgs; [
    bat # Cat(1) clone with syntax highlighting and Git integration
    du-dust # du + rust = dust. Like du but more intuitive
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
  ];

}
