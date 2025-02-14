{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.enable) {
  imports = [ ./libreoffice.nix ];
  environment.systemPackages = with pkgs; [

    # ---- Office ---- #
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    zathura # Highly customizable and functional PDF viewer
  ];
}
