{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.office.translators.enable) {
    environment.systemPackages = with pkgs; [
      translate-shell
      translatelocally

    ];
  };
}
