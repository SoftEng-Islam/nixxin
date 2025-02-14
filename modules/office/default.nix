{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.enable) {
  imports = [ ./documents.nix ./libreoffice.nix ];
  environment.systemPackages = with pkgs;
    [
      obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    ];
}
