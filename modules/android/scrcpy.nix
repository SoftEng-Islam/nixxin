{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.android.scrcpy) {
  environment.systemPackages = with pkgs; [
    scrcpy
    (writeShellScriptBin "scrcpy-run" "scrcpy -S")
  ];
}
