{
  settings,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    at-spi2-atk
    atkmm
    cairo
    cargo
    cargo-audit
    cargo-nextest
    cargo-outdated
    cargo-tauri
    cargo-watch
    cmake
    curl
    dbus
    fontconfig
    gdk-pixbuf
    gdk-pixbuf
    glib
    gnumake
    gobject-introspection
    gtk3
    gtk4
    harfbuzz
    jq
    just
    libappindicator-gtk3
    libglvnd
    librsvg
    libsoup_3
    libxkbcommon
    nodejs
    nodejs_latest
    openssl
    pango
    pkg-config
    rust-analyzer
    rustc
    rustup
    sccache
    strace
    wayland
    webkitgtk_4_1
    wlroots

    # Provide X11 *libs only* as fallback for apps that probe both
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

  ];
  environment.variables = {
    RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
    WEBKIT_DISABLE_COMPOSITING_MODE = "0";

    # CMake 4.0 removed backwards compatibility with cmake_minimum_required()
    # values below 3.5. Vendored CMakeLists.txt files inside older crates
    # (e.g. freetype-sys, expat-sys used by wry/tauri) still declare ancient
    # minimum versions and cause a hard build failure under CMake 4.x.
    # This env var (supported since CMake 3.27) silently raises any declared
    # minimum below 3.5 up to 3.5, unblocking those builds without touching
    # the upstream crates or downgrading cmake.
    CMAKE_POLICY_VERSION_MINIMUM = "3.5";
  };
}
