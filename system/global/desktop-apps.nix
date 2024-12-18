{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # Media Players
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    glide-media-player # Linux/macOS media player based on GStreamer and GTK
    jellyfin-media-player # Jellyfin Desktop Client based on Plex Media Player
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    vlc # Cross-platform media player and streaming server

    # Video Editors
    # kdenlive # Video editor
    # davinci-resolve # Professional video editing, color, effects and audio post-processing
    # davinci-resolve-studio

    testdisk # Data recovery utilities

    # graphics apps
    # lunacy # Free design software that keeps your flow with AI tools and built-in graphics
    drawio # A desktop application for creating diagrams
    blender-hip # 3D Creation/Animation/Publishing System
    # inkscape # Vector graphics editor
    # gimp # GNU Image Manipulation Program
    # figma-linux

    # Developers Applications
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    sqlitebrowser # DB Browser for SQLite
    bruno # Open-source IDE For exploring and testing APIs.

    # community-apps
    telegram-desktop # Telegram Desktop messaging app
    discord # All-in-one cross-platform voice and text chat for gamers
    slack # Desktop client for Slack
    signal-desktop # Private, simple, and secure messenger
    zoom-us # zoom.us video conferencing application
    ferdium # All your services in one place built by the community
    # mumble # Low-latency, high quality voice chat software

    # Browsers
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    # microsoft-edge # The web browser from Microsoft

    # audacity # Sound editor with graphical UI
    gparted # Graphical disk partitioning tool
    # gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # office apps
    # libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
  ];
}
