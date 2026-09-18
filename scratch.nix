let
  lib = (import <nixpkgs> {}).lib;
  importDir = dir: extraArgs:
    builtins.foldl' (acc: f:
      if f == "default.nix" || !lib.strings.hasSuffix ".nix" f then acc
      else
        let imported = import (dir + "/${f}");
        in acc // (if builtins.isFunction imported then imported ({ inherit lib; } // extraArgs) else imported)
    ) {} (builtins.attrNames (builtins.readDir dir));
in
  builtins.toJSON (importDir ./modules/desktop/hyprland/configs { settings={common={mouse={sensitivity=1; accelProfile="flat"; scrollSpeed=1;}; cursor={name=""; size=1; package=null;};};}; pkgs={}; inputs={}; })
