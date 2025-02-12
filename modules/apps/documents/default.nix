{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _documents = [
    (lib.optional settings.modules.apps.documents.evince.enable ./evince.nix)
    (lib.optional settings.modules.apps.documents.okular.enable ./okular.nix)
    (lib.optional settings.modules.apps.documents.papers.enable ./papers.nix)
    (lib.optional settings.modules.apps.documents.zathura.enable ./zathura.nix)
  ];
in mkIf (settings.modules.apps.documents.enable) {
  imports = lib.flatten _documents;
}
