{ pkgs, ... }: {
  # Collection of useful CLI apps
  environment.systemPackages = with pkgs; [
    # file-utilities
    file # Program that shows the type of files
    lsof # Tool to list open files
    rar # Utility for RAR archives
    rsync # Fast incremental file transfer utility
    unar # Archive unpacker program
    unrar-free # Free utility to extract files from RAR archives
    unrar-wrapper # Backwards compatibility between unar and unrar
    zip # Compressor/archiver for creating and modifying zipfiles
    # ---------------------------------
    disfetch
    lolcat
    cowsay
    starfetch
    cava
    killall
    libnotify
    timer
    brightnessctl
    gnugrep
    bat
    eza
    fd
    bottom
    ripgrep
    rsync
    unzip
    w3m
    pandoc
    hwinfo
    pciutils
    numbat
    # ---------------------------------
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
    lsof # A tool to list open files
    ouch

    wlsunset # Wayland compositors supporting wlr-gamma-control-unstable-v1.
    # sct # X11 CLI Minimal utility to set display colour temperature. EX: sct 2000
    shell-gpt # Access ChatGPT from your terminal
    tio
    patool
    cheat
    jq
    hexyl
    procs
    xcp
    nurl # Command-line tool to generate Nix fetcher calls from repository URLs
    hub # Command-line wrapper for git that makes you better at GitHub

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

  ];
}
