# schema/check.nix
#
# Strict schema-conformance checker for nixxin.
#
# Guarantees that every users/<name>/default.nix defines EXACTLY the same
# set of leaf option paths as schema/default.nix:
#   - An option added to the schema shows up as "missing" until every user
#     file adds it.
#   - An option removed from the schema shows up as "unknown" until every
#     user file deletes it.
#   - A typo'd or made-up option in a user file is caught the same way, as
#     "unknown" — unless it lives under the `custom.*` escape hatch (see the
#     bottom of schema/default.nix), which is intentionally exempt so users
#     have somewhere sanctioned to add machine-specific extras without
#     touching the shared schema.
#
# This only compares the *shape* (attribute paths) of what each file
# literally writes — not values, and not the merged/final profile.
{ lib }:
let
  # Stop recursing ("this is a leaf") when the value isn't a plain data
  # attrset — i.e. it's a scalar/list, an actual derivation, or something
  # nixpkgs-shaped (package sets, etc). This matters because a handful of
  # schema options are real `pkgs.*` values (fonts, themes, cursors) and we
  # must not try to walk into nixpkgs itself.
  #
  # CAVEAT: this only reliably recognizes single derivations. If you ever
  # assign a raw *package set* as an option value (e.g. the commented-out
  # `system.kernel = pkgs.linuxPackages_zen;` in schema/default.nix), it
  # will NOT be caught by `lib.isDerivation` and this will try to recurse
  # into nixpkgs. Prefer a string/bool "choice" option resolved elsewhere
  # (like `modules.system.rocm`) instead of embedding raw package sets in
  # the schema — that's also more consistent with the rest of this file.
  isLeaf =
    v:
    !(lib.isAttrs v)
    || lib.isDerivation v
    || (v ? recurseForDerivations)
    || (v ? outPath)
    || lib.isFunction v;

  # Namespaces exempt from strict checking — sanctioned freeform user space.
  exemptPrefixes = [ "custom" ];

  isExempt = path: lib.any (p: path == p || lib.hasPrefix "${p}." path) exemptPrefixes;

  collectPaths =
    prefix: attrs:
    lib.concatLists (
      lib.mapAttrsToList (
        name: value:
        let
          path = if prefix == "" then name else "${prefix}.${name}";
        in
        if isLeaf value then [ path ] else collectPaths path value
      ) attrs
    );
in
{
  # userName  : string, for the error message (e.g. "softeng")
  # schemaRaw : the attrset produced by calling schema/default.nix with a
  #             fully-resolved `self` (NOT the merged profile)
  # userRaw   : the attrset produced by calling users/<name>/default.nix
  #             the same way (NOT the merged profile)
  #
  # Returns `true` if they match, otherwise throws with a full report of
  # what's missing and what's unrecognized.
  check =
    {
      userName,
      schemaRaw,
      userRaw,
    }:
    let
      schemaPaths = collectPaths "" schemaRaw;
      userPaths = collectPaths "" userRaw;
      userPathsChecked = lib.filter (p: !isExempt p) userPaths;

      missing = lib.subtractLists userPathsChecked schemaPaths; # schema has it, user must add it
      extra = lib.subtractLists schemaPaths userPathsChecked; # user has it, schema doesn't -> remove it

      section =
        title: paths:
        lib.optionalString (paths != [ ]) ''
          ${title} (${toString (lib.length paths)}):
            - ${lib.concatStringsSep "\n    - " paths}
        '';
    in
    if missing == [ ] && extra == [ ] then
      true
    else
      throw ''
        nixxin: schema drift detected in users/${userName}/default.nix

        ${section "Missing options — present in schema/default.nix, add these to your file" missing}
        ${section "Unknown options — not in schema/default.nix (removed upstream, or a typo); delete these from your file" extra}
        Tip: options under `custom.*` are exempt and can be anything you want.
      '';
}
