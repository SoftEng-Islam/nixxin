{ settings, config, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.development.enable or false) [
    ./android
    ./databases
    ./languages
    ./tools
    ./web
  ];
  config = lib.mkIf (settings.modules.development.enable or false) {

    environment.systemPackages = with pkgs; [
      bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
      at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
      atkmm # C++ wrappers for ATK accessibility toolkit
      bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
      cairo # A 2D graphics library with support for multiple output devices
      cairomm # C++ bindings for the Cairo vector graphics library
      gdk-pixbuf # A library for image loading and manipulation
      glib # C library of programming buildings blocks
      glibc # GNU C Library
      gobject-introspection # A middleware layer between C libraries and language bindings
      gtksourceviewmm # C++ wrapper for gtksourceview
      harfbuzz # An OpenType text shaping engine
      nginx # Reverse proxy and lightweight webserver
      caddy # Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS

      # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
      beekeeper-studio

      # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
      dbeaver-bin

      # DB Browser for SQLite
      sqlitebrowser

      # Open-source IDE For exploring and testing APIs.
      bruno

      # cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
      insomnia
    ];
  };
}
