{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.office.translators.enable or false) {
    environment.systemPackages = with pkgs;
      [
        # Translate Shell >
        # https://www.soimort.org/translate-shell/
        # Command-line translator using Google Translate, Bing Translator, Yandex.Translate, and Apertium
        #{ Usage }:
        # 1- $ trans en:ar word processor
        # 2- $ trans en:ar "word processor"
        translate-shell
      ];
  };
}
