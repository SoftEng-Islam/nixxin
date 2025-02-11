# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.docs.enable) {
  # For Faster Rebuilding Disable These
  documentation = {
    enable = settings.modules.docs.enable;
    doc.enable = settings.modules.docs.doc.enable;
    man = {
      enable = settings.modules.docs.man.enable;
      generateCaches = settings.modules.docs.man.generateCaches;
    };
    dev.enable = settings.modules.docs.dev.enable;
    info.enable = settings.modules.docs.info.enable;
    nixos.enable = settings.modules.docs.nixos.enable;
  };
}
