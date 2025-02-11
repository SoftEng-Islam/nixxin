{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _documents = [
    (lib.optional settings.modules.applications.documents.evince.enable
      ./evince.nix)
    (lib.optional settings.modules.applications.documents.okular.enable
      ./okular.nix)
    (lib.optional settings.modules.applications.documents.papers.enable
      ./papers.nix)
    (lib.optional settings.modules.applications.documents.zathura.enable
      ./zathura.nix)
  ];
in mkIf (settings.modules.applications.documents.enable) {
  imports = lib.flatten _documents;
}
