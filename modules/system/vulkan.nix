{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.drivers.vulkan) {

  environment.systemPackages = with pkgs;
    [

    ];
}
