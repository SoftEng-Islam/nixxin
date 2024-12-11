{ pkgs, ... }: {
  # Developer Packages
  environment.systemPackages = with pkgs; [
    at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
    atkmm # C++ wrappers for ATK accessibility toolkit
    bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    cairo # A 2D graphics library with support for multiple output devices
    cairomm # C++ bindings for the Cairo vector graphics library
    direnv # A shell extension that manages your environment
    gdk-pixbuf # A library for image loading and manipulation
    glib # C library of programming buildings blocks
    gobject-introspection-unwrapped
    gobject-introspection # A middleware layer between C libraries and language bindings
    harfbuzz # An OpenType text shaping engine
    # bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    llvmPackages_12.bintools # System binary utilities (wrapper script)
    ninja # Small build system with a focus on speed
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    zlib # Lossless data-compression library

    #__ Databases __#
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine

    #__ C & C++ __#
    clang # A C language family frontend for LLVM (wrapper script)

    #__ Sass (Css) __#
    dart-sass # The reference implementation of Sass, written in Dart
    libsass # A C/C++ implementation of a Sass compiler
    rsass # Sass reimplemented in rust with nom
    grass-sass # A Sass compiler written purely in Rust
    sassc # A front-end for libsass

    #__ Ruby __#
    ruby_3_3 # An object-oriented language for quick and easy programming
    rubyPackages.execjs

    #__ Nodejs & JavaScript Stuff __#
    nodejs_22 # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.pnpm # Fast, disk space efficient package manager
    typescript # Superset of JavaScript that compiles to clean JavaScript output

  ];
}
