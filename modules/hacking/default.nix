{
  settings,
  lib,
  pkgs,
  pkgs-older,
  ...
}:
let
  inherit (lib) mkIf;

  rocmMode = settings.modules.system.rocm;

  # Hashcat 7 probes HIP at runtime and crashes with ROCm 5.7 on gfx902 APUs.
  # Use hashcat 6.x (OpenCL-only) when rocm = "old".
  hashcatPkg =
    if rocmMode == "old" then
      pkgs-older.hashcat
    else
      pkgs.hashcat.override {
        cudaSupport = false;
        rocmSupport = rocmMode == "new";
      };

  hashcatWrapper = pkgs.writeShellScriptBin "hashcat" ''
    unset LD_LIBRARY_PATH HIP_PATH ROCM_PATH
    exec ${hashcatPkg}/bin/hashcat "$@"
  '';

  hashcatLegacy =
    if rocmMode == "old" then
      null
    else
      pkgs.writeShellScriptBin "hashcat-legacy" ''
        unset LD_LIBRARY_PATH HIP_PATH ROCM_PATH
        exec ${pkgs-older.hashcat}/bin/hashcat "$@"
      '';

in
{
  config = mkIf (settings.modules.hacking.enable) {
    environment.systemPackages =
      with pkgs;
      [
        hashcat
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
      ]
      ++ lib.optional (hashcatLegacy != null) hashcatLegacy;
  };
}
