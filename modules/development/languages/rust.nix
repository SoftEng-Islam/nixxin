{
  settings,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # ── Rust toolchain ────────────────────────────────────────────────────
    cargo
    cargo-audit
    cargo-nextest
    cargo-outdated
    cargo-tauri
    cargo-watch
    rust-analyzer
    rustc
    rustup
    sccache

    # ── Build tools ───────────────────────────────────────────────────────
    cmake
    gnumake
    just
    pkg-config
    gobject-introspection

    # ── General utilities ─────────────────────────────────────────────────
    curl
    jq
    nodejs
    nodejs_latest
    strace

    # ── GTK / GLib stack ─────────────────────────────────────────────────
    # Runtime .so libraries (out output)
    at-spi2-atk
    atkmm
    cairo
    dbus
    fontconfig
    gdk-pixbuf
    glib
    gtk3
    gtk4
    harfbuzz
    libappindicator-gtk3
    libglvnd
    librsvg
    libsoup_3
    libxkbcommon
    openssl
    pango
    wayland
    webkitgtk_4_1
    wlroots

    # Dev outputs — contain the .pc files that pkg-config / cargo build
    # scripts search for via PKG_CONFIG_PATH.  On NixOS, environment.systemPackages
    # only links the default "out" output; .pc files live in "dev" and must be
    # added explicitly so they are symlinked into
    # /run/current-system/sw/lib/pkgconfig/.
    at-spi2-atk.dev # atk.pc  atk-bridge-2.0.pc  atspi-2.pc
    cairo.dev # cairo.pc  cairo-gobject.pc  cairo-ft.pc  …
    dbus.dev # dbus-1.pc
    fontconfig.dev # fontconfig.pc
    gdk-pixbuf.dev # gdk-pixbuf-2.0.pc
    glib.dev # glib-2.0.pc  gobject-2.0.pc  gio-2.0.pc  …
    gtk3.dev # gdk-3.0.pc  gtk+-3.0.pc  gdk-wayland-3.0.pc  …
    harfbuzz.dev # harfbuzz.pc  harfbuzz-gobject.pc
    libappindicator-gtk3.dev # appindicator3-0.1.pc
    libglvnd.dev # gl.pc  egl.pc  glesv2.pc  …
    librsvg.dev # librsvg-2.0.pc
    libsoup_3.dev # libsoup-3.0.pc
    libxkbcommon.dev # xkbcommon.pc  xkbcommon-x11.pc
    openssl.dev # openssl.pc  libssl.pc  libcrypto.pc
    pango.dev # pango.pc  pangocairo.pc  pangoft2.pc  …
    wayland.dev # wayland-client.pc  wayland-server.pc  wayland-egl.pc  …
    webkitgtk_4_1.dev # webkit2gtk-4.1.pc  javascriptcoregtk-4.1.pc  …

    # ── X11 libs (fallback for apps that probe both Wayland and X11) ─────
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
