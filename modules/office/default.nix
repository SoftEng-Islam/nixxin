{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;
  _pkgs = with pkgs; [ (optionals settings.modules.office.siyuan siyuan) ];
in {
  imports = optionals (settings.modules.office.enable or true) [
    ./documents.nix
    ./libreoffice.nix
    ./obsidian.nix
    ./translators.nix
    ./lout.nix
    ./n8n.nix
  ];
  config = mkIf (settings.modules.office.enable or false) {
    environment.systemPackages = with pkgs;
      [
        wlsunset
        gammastep
        gucharmap
        # anki
        anki-bin
      ] ++ lib.flatten _pkgs;
  };
}
