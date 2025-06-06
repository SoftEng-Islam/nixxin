{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  environment.systemPackages = with pkgs; [
    aria2
    (writeShellScriptBin "a2c" "aria2c -j 16 -s 16 $@")
  ];
}
