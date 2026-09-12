{
  lib,
}:

let
  # Load your custom helpers (like importDir)
  myLib = import ./importDir.nix { inherit lib; };

  # Auto-import: recursively collects default.nix files from subdirectories
  collectDefaults =
    dir:
    let
      entries = builtins.readDir dir;
      dirs = lib.filterAttrs (_name: type: type == "directory") entries;
      nested = lib.concatMap (d: collectDefaults (dir + "/${d}")) (lib.attrNames dirs);
      own = lib.optional (entries ? "default.nix" && entries."default.nix" == "regular") (
        dir + "/default.nix"
      );
    in
    own ++ nested;

in
{
  inherit collectDefaults;

  # Export your custom helpers under 'lib' so your other files
  # can easily access `importDir`
  lib = myLib;
}
