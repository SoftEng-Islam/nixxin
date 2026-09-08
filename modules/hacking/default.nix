{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  inherit (lib) mkIf;
  rocm-hashcat = pkgs.writeShellScriptBin "hashcat" ''
    export HSA_OVERRIDE_GFX_VERSION=9.0.0
    export LD_LIBRARY_PATH="${pkgs.rocmPackages.clr}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH"
    exec ${pkgs.hashcat}/bin/hashcat "$@"
  '';
in
{
  config = mkIf (settings.modules.hacking.enable) {
    environment.systemPackages = with pkgs; [
      hashcat
      rocm-hashcat
      hashcat-utils
      john
      johnny
      aircrack-ng
      wireshark
      airgorah
      xterm
      macchanger
      hcxdumptool
      hcxtools
      netcat
      netop
      cowpatty
      wavemon
      linssid
      wifite2
      thc-hydra
      vault-medusa
      medusa
    ];
  };
}
