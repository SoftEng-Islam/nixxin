{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.office.libreoffice or false) {
  programs = {
    # required by libreoffice
    java.enable = true;
  };
  environment.systemPackages = with pkgs;
    [
      libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    ];
}
