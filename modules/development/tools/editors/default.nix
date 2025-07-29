{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.development.tools.editors.vscode.enable
      ./vscode.nix)
    (lib.optional settings.modules.development.tools.editors.zedEditor
      ./zed-editor.nix)
    (lib.optional settings.modules.development.tools.editors.eclipse
      ./eclipse.nix)
    (lib.optional settings.modules.development.tools.editors.helix ./helix.nix)
  ];

  _pkgs = with pkgs; [
    (lib.optional settings.modules.development.tools.editors.vscodium vscodium)
    (lib.optional settings.modules.development.tools.editors.gnomeTextEditor
      gnome-text-editor)
  ];
in {
  imports = lib.optionals (settings.modules.development.tools.editors.enable or false)
    lib.flatten _imports;
  config = mkIf (settings.modules.development.tools.editors.enable or false) {
    environment.systemPackages = lib.flatten _pkgs;
  };
}
