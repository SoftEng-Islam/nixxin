{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.office.libreoffice.enable) {
  programs = {
    # required by libreoffice
    java.enable = true;
  };
}
