{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.android.android-studio) {
  environment.systemPackages = with pkgs; [ android-studio ];
}
