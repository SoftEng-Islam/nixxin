{ pkgs, ... }: {
  # Collection of useful CLI apps
  environment.systemPackages = with pkgs; [
    # sct # X11 CLI Minimal utility to set display colour temperature. EX: sct 2000
    bashInteractive
    bat # Cat(1) clone with syntax highlighting and Git integration
    bluez # Official Linux Bluetooth protocol stack
    bluez-tools # A set of tools to manage bluetooth devices for linux
    bottom
    brightnessctl
    cava
    cheat
    cowsay
    disfetch
    eza
    fastfetch # Like neofetch, but much faster because written in C
    fd
    file # A program that shows the type of files
    findutils
    gh
    gnugrep
    gnused
    gum # Tasty Bubble Gum for your shell
    hexyl
    htop # An interactive process viewer
    hub # Command-line wrapper for git that makes you better at GitHub
    hwinfo
    jq
    killall
    less
    libnotify
    lolcat
    lsd
    lsof # Tool to list open files
    mediainfo # Supplies technical and tag information about a video or audio file
    ncurses
    numbat
    nurl # Command-line tool to generate Nix fetcher calls from repository URLs
    ouch # Command-line utility for easily compressing and decompressing files and directories
    pandoc
    patool
    pciutils
    pinentry-curses
    procs
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    ranger # File manager with minimalistic curses interface
    rar # Utility for RAR archives
    ripgrep
    rsync # Fast incremental file transfer utility
    shell-gpt # Access ChatGPT from your terminal
    starfetch
    tea
    timer
    tio
    tree # Command to produce a depth indented directory listing
    unar # Archive unpacker program
    unrar-free # Free utility to extract files from RAR archives
    unrar-wrapper # Backwards compatibility between unar and unrar
    unzip # An extraction utility for archives compressed in .zip format
    vivid
    w3m
    wlsunset # Wayland compositors supporting wlr-gamma-control-unstable-v1.
    xcp
    yq-go
    zip # Compressor/archiver for creating and modifying zipfiles
    zoxide

  ];
}
