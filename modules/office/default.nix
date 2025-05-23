{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;

  _pkgs = with pkgs; [ (optionals settings.modules.office.siyuan siyuan) ];
in {
  imports = optionals (settings.modules.office.enable or false) [
    ./documents.nix
    ./libreoffice.nix
    ./obsidian.nix
    ./translators.nix
  ];
  config = mkIf (settings.modules.office.enable or false) {
    environment.systemPackages = lib.flatten _pkgs;
  };
}
