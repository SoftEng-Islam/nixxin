{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _editors = [
    # (lib.optional settings.system.editors.vscode ./vscode)
    (lib.optional settings.modules.applications.editors.zedEditor
      ./zed-editor.nix)
    (lib.optional settings.modules.applications.editors.eclipse ./eclipse.nix)
    (lib.optional settings.modules.applications.editors.helix ./helix.nix)
  ];

  _editorsPackages = with pkgs; [
    (lib.optional settings.modules.applications.editors.vscode vscode)
    (lib.optional settings.modules.applications.editors.vscodium vscodium)
    (lib.optional settings.modules.applications.editors.gnomeTextEditor
      gnome-text-editor)
  ];
in mkIf (settings.modules.applications.editors.enable) {
  environment.systemPackages = lib.flatten _editorsPackages;
  imports = lib.flatten _editors;
}
