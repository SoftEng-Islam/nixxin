{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustfmt # Tool for formatting Rust code according to style guidelines
    clippy # Bunch of lints to catch common mistakes and improve your Rust code
    rust-analyzer # Modular compiler frontend for the Rust language
    (writeScriptBin "rust-doc" ''
      #! ${stdenv.shell} -e
      exec firefox "${rustc.doc}/share/doc/rust/html/index.html"
    '')
  ];
}
