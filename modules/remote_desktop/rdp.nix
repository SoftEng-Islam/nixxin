{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.remote_desktop.rdp.enable) {
  environment.systemPackages = with pkgs; [
    remmina # graphical
    freerdp # command-line
    barrier # Optional: mouse/keyboard sharing
  ];
  # Allow outbound RDP (client to Windows)
  networking.firewall.enable = true;
  # Only needed if this PC should *receive* RDP connections (rare)
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      shared = {
        path = "/data";
        browseable = true;
        writable = true;
        "guest ok" = true; # Optional: allows access without a password
      };
    };
  };

}
