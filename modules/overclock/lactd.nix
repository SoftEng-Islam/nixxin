{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.lactd.enable or false) {
  # Linux GPU Configuration Tool for AMD and NVIDIA

  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  systemd.packages = with pkgs; [ lact ];
  environment.systemPackages = with pkgs; [ lact ];
}
