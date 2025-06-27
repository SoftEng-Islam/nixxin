{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.camera.enable) {
  programs = {
    droidcam.enable = true; # camera
  };
  environment.systemPackages = with pkgs; [ droidcam ];
}
