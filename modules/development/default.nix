{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;
  _pkgs = with pkgs; [
    # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    (lib.optional settings.modules.development.apps.beekeeper beekeeper-studio)
    # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    (lib.optional settings.modules.development.apps.dbeaver dbeaver-bin)
    # DB Browser for SQLite
    (lib.optional settings.modules.development.apps.sqlitebrowser sqlitebrowser)
    # Open-source IDE For exploring and testing APIs.
    (lib.optional settings.modules.development.apps.bruno bruno)
    # cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
    (lib.optional settings.modules.development.apps.insomnia insomnia)
  ];
in {
  imports = optionals (settings.modules.development.enable or false) [
    ./android
    ./databases
    ./languages
    ./tools
    ./web
  ];

  config = mkIf (settings.modules.development.enable) {
    environment.systemPackages = with pkgs;
      [
        devenv
        direnv
        bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
        at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
        atkmm # C++ wrappers for ATK accessibility toolkit
        bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
        cairo # A 2D graphics library with support for multiple output devices
        cairomm # C++ bindings for the Cairo vector graphics library
        gdk-pixbuf # A library for image loading and manipulation
        glib # C library of programming buildings blocks
        glibc
        gobject-introspection # A middleware layer between C libraries and language bindings
        gtksourceviewmm
        harfbuzz # An OpenType text shaping engine
      ] ++ lib.flatten _pkgs;
  };
}
