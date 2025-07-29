{ settings, inputs, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.development.languages.rust) {

  # What is rust-overlay?
  #
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  home-manager.users.${settings.user.username} = {
    # programs.vscode.profiles.default.extensions = with pkgs; [ vscode-extensions.rust-lang.rust-analyzer ];
  };

  environment.variables = {
    # Enables Rust backtraces for debugging.
    RUST_BACKTRACE = "1";

    #
    # CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";

    #
    # CARGO_NET_GIT_FETCH_WITH_CLI = "true";

    #
    # CARGO_HTTP_MULTIPLEXING = "false";

    # Allow cargo to download crates
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

    # Enable colored cargo and rustc output
    TERMINFO = "${pkgs.ncurses.out}/share/terminfo";
  };
  environment.systemPackages = with pkgs; [
    rust-bin.stable.latest.default

    # ! I don't need These Packages while we have ^ rust-overlay
    # rustup # The Rust toolchain installer
    # rust-analyzer # A modular compiler frontend for the Rust language
    # rust-analyzer-unwrapped # Modular compiler frontend for the Rust language
    # rust-audit-info # Command-line tool to extract the dependency trees embedded in binaries by cargo-auditable
    # rustc # A safe, concurrent, practical language (wrapper script)
    # rustfmt # Tool for formatting Rust code according to style guidelines
    # cargo # Downloads your Rust project's dependencies and builds your project
    # cargo-asm
    # cargo-flamegraph
    # cargo-tauri # Build smaller, faster, and more secure desktop apps with a web frontend
    # clippy # Bunch of lints to catch common mistakes and improve your Rust code

    # To Open Rust Docs In Your Default Browser
    (writeScriptBin "rust-book" ''
      #! ${stdenv.shell} -e
      echo "Opening Rust documentation..."
      exec ${
        toString settings.common.webBrowser
      } ${rustc.doc}/share/doc/docs/html/book/index.html >/dev/null 2>/dev/null </dev/null & disown
    '')
  ];
}
