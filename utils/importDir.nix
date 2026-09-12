{
  lib,
  ...
}:
with lib;
{
  # Import all .nix files from a directory (excluding default.nix) and merge into one attrset.
  # If a file is a function, it's called with { lib } merged with extraArgs.
  # If it's a plain set, it's used as-is.
  importDir =
    dir: extraArgs:
    builtins.foldl' (
      acc: f:
      if f == "default.nix" || !strings.hasSuffix ".nix" f then
        acc
      else
        let
          imported = import (dir + "/${f}");
        in
        acc // (if builtins.isFunction imported then imported ({ inherit lib; } // extraArgs) else imported)
    ) { } (builtins.attrNames (builtins.readDir dir));
}
