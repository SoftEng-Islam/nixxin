{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.icons.enable or true) {
  nixpkgs.overlays = [
    (final: prev: {
      # ------------------------------
      # Papirus folder color override
      # ------------------------------
      papirus-icon-theme = prev.papirus-icon-theme.override {
        color = settings.common.icons.folder-color;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    icon-library # Symbolic icons for your apps
    papirus-icon-theme
    adwaita-icon-theme
  ];
}
