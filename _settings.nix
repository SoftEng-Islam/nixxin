{
  lib,
  pkgs ? null,
  ...
}:
let
  # Switch the active profile here.
  activeUser = "softeng";
  userDir = ./. + "/users/${activeUser}";
  userModule = userDir + "/default.nix";
  hardwareModule = userDir + "/hardware.nix";
  userOverrides = import userModule { inherit pkgs; };
  bootstrapProfile = lib.fix (self: userOverrides self);
in
{
  inherit activeUser;
  architecture = bootstrapProfile.system.architecture or "x86_64-linux";

  selectedUser = {
    name = activeUser;
    path = "/users/${activeUser}";
    dir = userDir;
    inherit userModule hardwareModule;
  };

  profile =
    if pkgs == null then
      null
    else
      let
        schema = import ./users/schema/default.nix { inherit pkgs; };
      in
      lib.fix (self: lib.recursiveUpdate (schema self) (userOverrides self));
}
