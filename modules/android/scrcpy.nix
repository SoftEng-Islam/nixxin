{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.android.scrcpy.enable) {
  environment.systemPackages = with pkgs; [ scrcpy ];
}
