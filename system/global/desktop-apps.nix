{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Developers Applications
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    sqlitebrowser # DB Browser for SQLite
    bruno # Open-source IDE For exploring and testing APIs.

    # community-apps
    discord # All-in-one cross-platform voice and text chat for gamers
    # zoom-us # zoom.us video conferencing application
    ferdium # All your services in one place built by the community
    # mumble # Low-latency, high quality voice chat software
    # signal-desktop # Private, simple, and secure messenger
    slack # Desktop client for Slack
    telegram-desktop # Telegram Desktop messaging app

    # Browsers
    brave # Privacy-oriented browser for Desktop and Laptop computers
    firefox # Web browser built from Firefox source tree
    firefox-beta # Web browser built from Firefox Beta Release source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft

    # anki # Spaced repetition flashcard program
    audacity # Sound editor with graphical UI
    gparted # Graphical disk partitioning tool
    gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # office apps
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    # rnote # Simple drawing application to create handwritten notes
    xournalpp # Xournal++ is a handwriting Notetaking software with PDF annotation support
  ];
}
