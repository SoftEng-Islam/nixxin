{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.keyboard_remapper.enable) {
  environment.systemPackages = with pkgs; [
    ./Hawck.nix
    ./input-remapper.nix
    ./kmonad.nix
    ./xremap.nix
  ];
}
