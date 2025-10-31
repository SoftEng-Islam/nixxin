{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.remote_desktop.rdp.enable) {
  environment.systemPackages = with pkgs; [
    remmina # graphical
    freerdp # command-line
  ];
  # Allow outbound RDP (client to Windows)
  networking.firewall.enable = true;
  # Only needed if this PC should *receive* RDP connections (rare)
  # networking.firewall.allowedTCPPorts = [ 3389 ];
  networking.firewall.allowedTCPPorts = [ 139 445 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
  services.samba = {
    enable = false;
    openFirewall = true;
    settings = {
      shared = {
        path = "/data";
        browseable = true;
        writable = true;
        "guest ok" = "yes"; # Optional: allows access without a password
      };
    };
  };

}
