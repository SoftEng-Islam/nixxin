{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _editors = [
    # (lib.optional settings.system.editors.vscode ./vscode)
    (lib.optional settings.modules.apps.editors.zedEditor ./zed-editor.nix)
    (lib.optional settings.modules.apps.editors.eclipse ./eclipse.nix)
    (lib.optional settings.modules.apps.editors.helix ./helix.nix)
  ];

  _editorsPackages = with pkgs; [
    (lib.optional settings.modules.apps.editors.vscode vscode)
    (lib.optional settings.modules.apps.editors.vscodium vscodium)
    (lib.optional settings.modules.apps.editors.gnomeTextEditor
      gnome-text-editor)
  ];
in mkIf (settings.modules.apps.editors.enable) {
  environment.systemPackages = lib.flatten _editorsPackages;
  imports = lib.flatten _editors;
}
