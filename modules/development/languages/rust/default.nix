{ settings, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  # _rust = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override { extensions = [ "rust-src" ]; });
in mkIf (settings.modules.development.languages.rust) {
  home-manager.users.${settings.user.username} = {
    programs.vscode.extensions = with pkgs;
      [ vscode-extensions.rust-lang.rust-analyzer ];
  };
  environment.variables = {
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
    CARGO_HTTP_MULTIPLEXING = "false";
  };
  environment.systemPackages = with pkgs; [
    # _rust
    cargo # Downloads your Rust project's dependencies and builds your project
    cargo-tauri # Build smaller, faster, and more secure desktop apps with a web frontend
    cargo-asm
    cargo-flamegraph
    rust-audit-info
    rustc # A safe, concurrent, practical language (wrapper script)
    rustup # The Rust toolchain installer
    rust-analyzer # A modular compiler frontend for the Rust language
    rust-analyzer-unwrapped # Modular compiler frontend for the Rust language
    rustfmt # Tool for formatting Rust code according to style guidelines
    clippy # Bunch of lints to catch common mistakes and improve your Rust code
    rust-analyzer # Modular compiler frontend for the Rust language
    (writeScriptBin "rust-doc" ''
      #! ${stdenv.shell} -e
      exec firefox "${rustc.doc}/share/doc/rust/html/index.html"
    '')
  ];
}
