{
  settings,
  lib,
  pkgs,
  ...
}:
{
  # ── System-level Rust toolchain (lean) ────────────────────────────────────
  # Only the essentials that need to be globally available.
  # The heavy Tauri / GTK / WebKit build-dep stack lives in a project devShell
  # (see: nix develop) — it does NOT belong in the system closure.
  environment.systemPackages = with pkgs; [
    # Toolchain manager — installs/switches stable/nightly/targets via `rustup`
    rustup

    # Static analysis (IDE integration)
    rust-analyzer

    # Compiler cache — drastically speeds up repeated Rust builds
    sccache

    # Common build tools needed for most Rust crates
    pkg-config
    cmake
    gnumake
    just
  ];

  environment.variables = {
    RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
    CMAKE_POLICY_VERSION_MINIMUM = "3.5";
  };

  # ── Tauri dev environment ─────────────────────────────────────────────────
  # Run `nix develop .#tauri` (or add a devShell to your flake) to get:
  #   cargo, cargo-tauri, cargo-watch, cargo-audit, cargo-nextest,
  #   cargo-outdated, gobject-introspection, webkitgtk_4_1, gtk3, gtk4,
  #   libsoup_3, wlroots, libxkbcommon, openssl, pango, harfbuzz, cairo,
  #   glib, gdk-pixbuf, dbus, at-spi2-atk, libappindicator-gtk3, librsvg,
  #   libglvnd, wayland, freetype, libX11/Xcursor/Xrandr/Xi — and all .dev
  #   outputs for PKG_CONFIG_PATH.
  # This keeps all of WebKit (~1.5 GB) out of the system closure.
}
