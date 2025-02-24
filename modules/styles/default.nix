{ settings, lib, pkgs, ... }:

let inherit (lib) mkIf;
in mkIf (settings.modules.styles.enable) {
  imports = [
    # ./icons
    ./styles

    #  ./wallpapers
  ];
}
