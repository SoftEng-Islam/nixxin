{ pkgs, ... }: {
  # Collection of useful CLI apps
  environment.systemPackages = with pkgs; [

    # untrunc working_file.mp4 not_working.mp4
    untrunc-anthwlock # Restore a truncated mp4/mov (improved version of ponchio/untrunc)

    # sct # X11 CLI Minimal utility to set display colour temperature. EX: sct 2000
    bashInteractive
    bat # Cat(1) clone with syntax highlighting and Git integration
    bluez # Official Linux Bluetooth protocol stack
    bluez-tools # A set of tools to manage bluetooth devices for linux
    bottom # Cross-platform graphical process/system monitor with a customizable interface
    brightnessctl # This program allows you read and control device brightness
    cava # Console-based Audio Visualizer for Alsa
    cheat # Create and view interactive cheatsheets on the command-line
    cowsay # Program which generates ASCII pictures of a cow with a message

    starfetch # CLI star constellations displayer
    disfetch # Yet another *nix distro fetching program, but less complex
    fastfetch # Like neofetch, but much faster because written in C

    xcp # Extended cp(1)
    zoxide # Fast cd command that learns your habits
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # Modern, maintained replacement for ls
    fd # Simple, fast and user-friendly alternative to find
    lolcat # Rainbow version of cat
    lsd # Next gen ls command
    tree # Command to produce a depth indented directory listing
    less # More advanced file pager than 'more'
    gnugrep # GNU implementation of the Unix grep command
    killall

    findutils # GNU Find Utilities
    gnused # GNU sed, a batch stream editor
    gum # Tasty Bubble Gum for your shell
    hexyl # Command-line hex viewer
    htop # An interactive process viewer
    hwinfo # Hardware detection tool from openSUSE
    jq # Lightweight and flexible command-line JSON processor
    libnotify # Library that sends desktop notifications to a notification daemon

    ncurses # Free software emulation of curses in SVR4 and more
    numbat # High precision scientific calculator with full support for physical units
    nurl # Command-line tool to generate Nix fetcher calls from repository URLs
    ouch # Command-line utility for easily compressing and decompressing files and directories
    pandoc # Conversion between documentation formats
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    pinentry-curses # GnuPG’s interface to passphrase input
    procs # Modern replacement for ps written in Rust
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    ranger # File manager with minimalistic curses interface
    rar # Utility for RAR archives
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    tea # Gitea official CLI client
    timer # sleep with progress
    tio # Serial console TTY
    unar # Archive unpacker program
    vivid # Generator for LS_COLORS with support for multiple color themes
    wlsunset # Wayland compositors supporting wlr-gamma-control-unstable-v1.
    yq-go # Portable command-line YAML processor
  ];
}
