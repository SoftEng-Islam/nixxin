{
  settings,
  lib,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.callPackage ./blender/default.nix { })
  ];
}
