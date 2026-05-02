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

    cmake

    # Optional but helpful for broader GUI app compatibility
    libxkbcommon
    mesa # OpenGL support

    # Provide X11 *libs only* as fallback for apps that probe both
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    at-spi2-atk.dev
    atkmm.dev
    cairo.dev
    dbus.dev
    gdk-pixbuf.dev
    glib.dev
    gobject-introspection.dev
    gtk3.dev
    gtk4.dev
    harfbuzz.dev
    librsvg.dev
    libsoup_3.dev
    nodejs_latest
    openssl.dev
    pango.dev
    pkg-config
    webkitgtk_4_1.dev

    # https://devenv.sh/
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
