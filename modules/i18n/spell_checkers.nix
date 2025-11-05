{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.i18n.spell_checkers.enable) {
  environment.systemPackages = with pkgs; [
    spell-checkers
    aspell
    aspellDicts.de
    aspellDicts.fr
    aspellDicts.en
    hunspell
    hunspellDicts.en-gb-ise
  ];
}
