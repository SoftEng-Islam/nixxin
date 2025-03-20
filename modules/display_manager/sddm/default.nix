{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./sddm-theme.nix ];
  services = {
    # ---- SDDM ---- #
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.sddm.package = pkgs.plasma5Packages.sddm;
  };
}
