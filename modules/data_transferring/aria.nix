{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.data_transferring.aria.enable or true) {
  environment.systemPackages = with pkgs; [
    aria2
    (writeShellScriptBin "a2c" "aria2c -j 16 -s 16 $@")
  ];
}
