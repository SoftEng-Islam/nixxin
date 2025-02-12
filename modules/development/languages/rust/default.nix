{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cargo # Downloads your Rust project's dependencies and builds your project
    cargo-tauri # Build smaller, faster, and more secure desktop apps with a web frontend
    rust-analyzer # A modular compiler frontend for the Rust language
    rust-analyzer-unwrapped # Modular compiler frontend for the Rust language
    rustc # A safe, concurrent, practical language (wrapper script)
    rustup # The Rust toolchain installer
    rustfmt # Tool for formatting Rust code according to style guidelines
    clippy # Bunch of lints to catch common mistakes and improve your Rust code
    rust-analyzer # Modular compiler frontend for the Rust language
    (writeScriptBin "rust-doc" ''
      #! ${stdenv.shell} -e
      exec firefox "${rustc.doc}/share/doc/rust/html/index.html"
    '')
  ];
}
