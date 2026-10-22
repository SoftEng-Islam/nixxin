{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.callPackage ./odin.nix { })
  ];

  # odin4 is unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "odin4" ];

  # let your user talk to Samsung devices in Download mode
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666"
  '';
}
