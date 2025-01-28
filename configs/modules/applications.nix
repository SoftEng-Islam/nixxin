{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # figma-linux
    # kolourpaint
    # github-desktop
    # blueberry
    d-spy
    icon-library

    # Media Players
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    # clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    # glide-media-player # Linux/macOS media player based on GStreamer and GTK
    # jellyfin-media-player # Jellyfin Desktop Client based on Plex Media Player
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    vlc # Cross-platform media player and streaming server

    # Video Editors
    kdenlive # Video editor
    # davinci-resolve # Professional video editing, color, effects and audio post-processing
    # davinci-resolve-studio # Professional video editing, color, effects and audio post-processing
    # shotcut

    # ---- Utilities ---- #
    # testdisk # Data Recovery Utilities
    resources # Monitor your system resources and processes

    # Graphics Apps
    lunacy # Free design software that keeps your flow with AI tools and built-in graphics
    drawio # A desktop application for creating diagrams
    blender-hip # 3D Creation/Animation/Publishing System
    gimp # GNU Image Manipulation Program
    # inkscape # Vector graphics editor
    # figma-linux # Unofficial Electron-based Figma desktop app for Linux
    # darktable # Virtual lighttable and darkroom for photographers

    # Developers Applications
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    sqlitebrowser # DB Browser for SQLite
    bruno # Open-source IDE For exploring and testing APIs.
    # insomnia

    # Community Apps
    ferdium # All your services in one place built by the community
    discord # All-in-one cross-platform voice and text chat for gamers
    # mumble # Low-latency, high quality voice chat software
    # revolt-desktop # Open source user-first chat platform
    # signal-desktop # Private, simple, and secure messenger
    # slack # Desktop client for Slack
    telegram-desktop # Telegram Desktop messaging app
    # vesktop # Alternate client for Discord with Vencord built-in
    # zoom-us # zoom.us video conferencing application

    # Browsers
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft

    # audacity # Sound editor with graphical UI
    # gromit-mpx # Desktop annotation tool
    gparted # Graphical disk partitioning tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # Office Apps
    # libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    zathura # Highly customizable and functional PDF viewer
  ];
}
