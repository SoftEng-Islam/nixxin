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
  ];
}
