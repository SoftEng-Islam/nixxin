{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = mkIf (settings.modules.development.languages.enable or false) [
    ./clang
    ./go
    ./python
    ./ruby
    ./rust
    ./web
  ];
in {
  imports = lib.flatten _imports;
  config = mkIf (settings.modules.development.languages.enable or false) {
    environment.systemPackages = with pkgs;
      [
        # Command-line benchmarking tool
        # hyperfine
        # insomnia
        # scc
      ];
    # programs.vscode = {
    #   enable = true;
    #   package = pkgs.vscodium;
    #   extensions = with pkgs.vscode-extensions; [
    #     aaron-bond.better-comments
    #     catppuccin.catppuccin-vsc
    #     catppuccin.catppuccin-vsc-icons
    #     eamodio.gitlens
    #     jnoortheen.nix-ide
    #     mkhl.direnv
    #     ms-vscode.hexeditor
    #     tamasfe.even-better-toml
    #   ];
    # };
  };
}
