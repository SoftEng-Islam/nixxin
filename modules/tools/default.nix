{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.tools.enable) {
  environment.systemPackages = with pkgs; [
    gromit-mpx # Desktop annotation tool
    screenkey # A screencast tool to display your keys inspired by Screenflick

    # ventoy # is marked as insecure, refusing to evaluate.
    zotero
    # zapzap
    # caprine-bin
    # topgrade
    # tldr
    # fscryptctl
    # espanso
    element
    # duplicacy
  ];
}
