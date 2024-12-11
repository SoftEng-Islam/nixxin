{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ouch # Command-line utility for easily compressing and decompressing files and directories
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    gum # Tasty Bubble Gum for your shell
    bluez # Official Linux Bluetooth protocol stack
    bluez-tools # A set of tools to manage bluetooth devices for linux
    fastfetch # Like neofetch, but much faster because written in C
    file # A program that shows the type of files
    htop # An interactive process viewer
    mediainfo # Supplies technical and tag information about a video or audio file
    ranger # File manager with minimalistic curses interface
    tree # Command to produce a depth indented directory listing
    unzip # An extraction utility for archives compressed in .zip format
    zip # Compressor/archiver for creating and modifying zipfiles

    curl # A command line tool for transferring files with URL syntax
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP

    lsof # A tool to list open files
    lux # Fast and simple video download library and CLI tool written in Go
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)

    wlsunset # Wayland compositors supporting wlr-gamma-control-unstable-v1.
    # sct # X11 CLI Minimal utility to set display colour temperature. EX: sct 2000
    shell-gpt # Access ChatGPT from your terminal
    tio
    patool
    cheat
    jq
    foot
    hexyl
    ouch
    procs
    xcp
    nurl
    htop
    hub
    tea
    gh
    yq-go
    lsd
    zoxide
    pinentry-curses
    fd
    vivid
    ripgrep
    less
    bashInteractive
    gnused
    gnugrep
    findutils
    ncurses

    # CLI Downloads Utility
    aria2
    axel
    curl
    wget2
    media-downloader

  ];
}
