{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3

    ruby_3_4
    bundler
    bundix

    at-spi2-atk.dev
    atkmm.dev
    cairo.dev
    cargo
    cargo-audit
    cargo-nextest
    cargo-outdated
    cargo-tauri
    cargo-watch
    cmake
    curl
    dbus.dev
    fontconfig
    gdk-pixbuf.dev
    glib
    glib.dev
    gnumake
    gobject-introspection.dev
    gtk3.dev
    gtk4.dev
    harfbuzz.dev
    jq
    just
    libappindicator-gtk3
    libglvnd
    librsvg.dev
    libsoup_3.dev
    libxkbcommon
    mesa # OpenGL support
    nodejs
    nodejs_latest
    openssl.dev
    pango.dev
    pkg-config
    rust-analyzer
    rustc
    rustup
    sccache
    strace
    vulkan-loader
    wayland
    webkitgtk_4_1.dev
    wlroots
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr

    # https://devenv.sh/
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
