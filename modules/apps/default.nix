{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.apps.enable) {
  environment.systemPackages = with pkgs; [
    kolourpaint # Paint program

    audacity # Sound editor with graphical UI
    gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # ---- Office ---- #
    libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    zathura # Highly customizable and functional PDF viewer
  ];
}
