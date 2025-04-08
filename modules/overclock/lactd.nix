{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.lactd.enable or false) {
  # Linux GPU Configuration Tool for AMD and NVIDIA
  # We are creating the lact daemon service manually because the provided one hangs
  # systemd.services.lactd = {
  #   enable = true;
  #   description = "Radeon GPU monitor";
  #   after = [ "syslog.target" "systemd-modules-load.service" ];
  #   unitConfig = { ConditionPathExists = "${pkgs.lact}/bin/lact"; };
  #   serviceConfig = {
  #     User = "root";
  #     ExecStart = "${pkgs.lact}/bin/lact daemon";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  systemd.services.lact = {
    enable = true;
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
  };
  environment.systemPackages = with pkgs; [ lact ];
}
