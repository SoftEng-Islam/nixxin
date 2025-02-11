{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # figma-linux
    # kolourpaint
    # github-desktop
    # blueberry

    # Browsers
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft

    # audacity # Sound editor with graphical UI
    # gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # Office Apps
    # libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    zathura # Highly customizable and functional PDF viewer
  ];
}
