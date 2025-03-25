{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.editors.vscode.enable ./vscode.nix)
    (lib.optional settings.modules.editors.zedEditor ./zed-editor.nix)
    (lib.optional settings.modules.editors.eclipse ./eclipse.nix)
    (lib.optional settings.modules.editors.helix ./helix.nix)
  ];

  _pkgs = with pkgs; [
    (lib.optional settings.modules.editors.vscodium vscodium)
    (lib.optional settings.modules.editors.gnomeTextEditor gnome-text-editor)
  ];
in {
  imports =
    lib.optionals (settings.modules.editors.enable) lib.flatten _imports;
  config = mkIf (settings.modules.editors.enable) {
    environment.systemPackages = lib.flatten _pkgs;
  };
}
