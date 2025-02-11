{ settings, lib, pkgs, ... }: {
  imports = [ ./ai ./databases ./languages ./tools ];

  environment.systemPackages = with pkgs; [
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
    gobject-introspection-unwrapped
    gobject-introspection.dev
    gtksourceviewmm
    harfbuzz # An OpenType text shaping engine
    # jetbrains-toolbox

    # Developers Applications
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    sqlitebrowser # DB Browser for SQLite
    bruno # Open-source IDE For exploring and testing APIs.
    # insomnia
  ];
}
