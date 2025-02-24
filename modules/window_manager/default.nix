{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [ ./hyprland ];

  services.seatd.enable = lib.mkForce false;
  # services.seatd.user = "root";
}
