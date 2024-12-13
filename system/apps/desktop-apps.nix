{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gromit-mpx # Desktop annotation tool
    screenkey # A screencast tool to display your keys inspired by Screenflick
    akira-unstable # Native Linux Design application built in Vala and GTK
    lunacy # Free design software that keeps your flow with AI tools and built-in graphics
    discord # All-in-one cross-platform voice and text chat for gamers
    zoom-us # zoom.us video conferencing application
    audacity # Sound editor with graphical UI
    obs-studio # Free and open source software for video recording and live streaming
    anki # Spaced repetition flashcard program
    gparted # Graphical disk partitioning tool
    telegram-desktop # Telegram Desktop messaging app
    obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
    drawio # A desktop application for creating diagrams

    ferdium # All your services in one place built by the community
    mumble # Low-latency, high quality voice chat software
    signal-desktop # Private, simple, and secure messenger
    slack # Desktop client for Slack
    zoom-us # zoom.us video conferencing application

    #__ Graphic Applications __#
    inkscape
    gimp
    blender-hip # 3D Creation/Animation/Publishing System

    # Download Manager
    motrix # Full-featured download manager
    # uget # Download manager using GTK and libcurl

    # Torrents
    qbittorrent
    qbittorrent-enhanced
    qbittorrent-nox
  ];
}
