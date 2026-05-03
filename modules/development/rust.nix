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
  };
}
