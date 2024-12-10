{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

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
