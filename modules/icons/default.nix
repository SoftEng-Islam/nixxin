{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.icons.enable) {
  environment.systemPackages = with pkgs; [
    icon-library # Symbolic icons for your apps
    papirus-folders
    papirus-icon-theme
  ];
}
