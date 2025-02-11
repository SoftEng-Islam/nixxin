# ---- lactd.nix ---- #
{ settings, lib, pkgs, ... }: {
  # Linux GPU Configuration Tool for AMD and NVIDIA
  # We are creating the lact daemon service manually because the provided one hangs
  systemd.services.lactd = {
    enable = false;
    description = "Radeon GPU monitor";
    after = [ "syslog.target" "systemd-modules-load.service" ];

    unitConfig = { ConditionPathExists = "${pkgs.lact}/bin/lact"; };

    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };

    wantedBy = [ "multi-user.target" ];
  };
  environment.systemPackages = with pkgs; [ lact ];
}
