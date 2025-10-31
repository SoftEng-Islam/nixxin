{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.icons.enable or true) {

  nixpkgs.overlays = [
    (final: prev: {
      catppuccin-papirus-folders = prev.catppuccin-papirus-folders.overrideAttrs
        (finalAttrs: previousAttrs: { doCheck = false; });
    })
  ];

  environment.systemPackages = with pkgs; [
    icon-library # Symbolic icons for your apps
    catppuccin-papirus-folders
    papirus-icon-theme
  ];
}
