{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports =
    lib.optionals (settings.modules.remote_desktop.enable) [ ./rdp.nix ];
  environment.systemPackages = with pkgs;
    [
      #  gnome-remote-desktop
    ];
}
