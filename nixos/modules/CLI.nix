{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
