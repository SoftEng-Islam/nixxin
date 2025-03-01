{ settings, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;
  _pkgs = [
    # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    (optionals settings.modules.office.obsidian pkgs.obsidian)

    # Privacy-first personal knowledge management system that supports complete offline usage, as well as end-to-end encrypted data sync
    (optionals settings.modules.office.siyuan pkgs.siyuan)
  ];
in {
  imports = [ ./documents.nix ./libreoffice.nix ];
  environment.systemPackages = lib.flatten _pkgs;
}
