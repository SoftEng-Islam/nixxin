{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _editors = [
    # (lib.optional settings.system.editors.vscode ./vscode)
    (lib.optional settings.modules.editors.zedEditor ./zed-editor.nix)
    (lib.optional settings.modules.editors.eclipse ./eclipse.nix)
    (lib.optional settings.modules.editors.helix ./helix.nix)
  ];

  _editorsPackages = with pkgs; [
    (lib.optional settings.modules.editors.vscode vscode)
    (lib.optional settings.modules.editors.vscodium vscodium)
    (lib.optional settings.modules.editors.gnomeTextEditor gnome-text-editor)
  ];
in mkIf (settings.modules.editors.enable) {
  environment.systemPackages = lib.flatten _editorsPackages;
  imports = lib.flatten _editors;
}
