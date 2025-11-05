{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.android.scrcpy.enable or true) {
  environment.systemPackages = with pkgs; [
    # Display and control Android devices over USB or TCP/IP
    scrcpy
    (writeShellScriptBin "scrcpy-run" "scrcpy -S")
  ];
}
