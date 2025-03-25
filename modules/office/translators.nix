{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.office.translators.enable or false) {
    environment.systemPackages = with pkgs; [
      # Translate Shell >
      #
      #{ Usage }:
      # 1-
      # 2-
      translate-shell

      # Translate Shell >
      #
      #{ Usage }:
      # 1-
      # 2-
      translatelocally

    ];
  };
}
