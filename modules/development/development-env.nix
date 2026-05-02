{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3

    ruby_3_4
    bundler
    bundix

    rustc
    rust-analyzer
    git
    cargo
    cargo-watch
    cargo-audit
    cargo-nextest
    cargo-outdated
    cargo-tauri
    curl
    git
    jq
    just
    rustup
    sccache
    vulkan-loader
    wayland
    libglvnd
    wlroots
    pkg-config
    gobject-introspection
    cargo
    cargo-tauri
    nodejs

    # Optional but helpful for broader GUI app compatibility
    libxkbcommon
    mesa # OpenGL support

    # Provide X11 *libs only* as fallback for apps that probe both
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    at-spi2-atk
    atkmm
    cairo
    dbus
    gdk-pixbuf
    glib
    gobject-introspection
    # gtk3
    gtk4
    harfbuzz
    librsvg
    libsoup_3
    nodejs_latest
    openssl
    pango
    pkg-config
    webkitgtk_4_1

    # https://devenv.sh/
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
