{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #__ Rust __#
    cargo # Downloads your Rust project's dependencies and builds your project
    cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
    rust-analyzer # A modular compiler frontend for the Rust language
    rust-analyzer-unwrapped # Modular compiler frontend for the Rust language
    rustc # A safe, concurrent, practical language (wrapper script)
    rustup # The Rust toolchain installer
  ];
}
