{ pkgs, ... }:
{
  # environment.systemPackages = with pkgs; [ logiops ];

  # systemd.services.logid = {
  #   enable = true;
  #   description = "An unofficial userspace driver for Logitech devices";
  #   serviceConfig = { ExecStart = "${pkgs.logiops}/bin/logid"; };
  #   wantedBy = [ "multi-user.target" ];
  # };

  # environment.etc = {
  #   "logid.cfg" = {
  #     text = ''
  #       devices: ({});
  #     '';
  #   };
  # };
}
