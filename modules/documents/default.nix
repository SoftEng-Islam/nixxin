{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _documents = [
    (lib.optional settings.modules.documents.evince.enable ./evince.nix)
    (lib.optional settings.modules.documents.okular.enable ./okular.nix)
    (lib.optional settings.modules.documents.papers.enable ./papers.nix)
    (lib.optional settings.modules.documents.zathura.enable ./zathura.nix)
  ];
in mkIf (settings.modules.documents.enable) {
  imports = lib.flatten _documents;
}
