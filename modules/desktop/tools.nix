{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.desktop.tools or false) {
  environment.systemPackages = with pkgs; [
    gromit-mpx # Desktop annotation tool
    screenkey # A screencast tool to display your keys inspired by Screenflick

    ventoy-bin

    zotero # Collect, organize, cite, and share your research sources
    tldr # Simplified and community-driven man pages
    fscryptctl # Small C tool for Linux filesystem encryption
    espanso # Cross-platform Text Expander written in Rust
    element # Periodic table on the command line
  ];
}
