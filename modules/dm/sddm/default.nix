{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./sddm-theme.nix ];
  services = {
    # ---- SDDM ---- #
    displayManager.sddm.enable = false;
    displayManager.sddm.wayland.enable = false;
    displayManager.sddm.package = pkgs.plasma5Packages.sddm;
  };
}
