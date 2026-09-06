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
        schema = import ./schema/default.nix { inherit pkgs; };
        finalProfile = lib.fix (self: lib.recursiveUpdate (schema self) (userOverrides self));

        # Strict schema-conformance check (schema/check.nix). Re-applying
        # `schema` / `userOverrides` to the already-resolved `finalProfile`
        # is cheap and safe: it doesn't re-run the fixpoint, it just gives
        # us the literal attrset each file writes, with `self`-references
        # already resolved so nothing throws while we inspect the shape.
        schemaChecker = import ./schema/check.nix { inherit lib; };
        conforms = schemaChecker.check {
          userName = activeUser;
          schemaRaw = schema finalProfile;
          userRaw = userOverrides finalProfile;
        };
      in
      # `assert` forces `conforms`; if it's a `throw` (mismatch found) this
      # is where evaluation aborts with the report.
      assert conforms;
      finalProfile;
}
