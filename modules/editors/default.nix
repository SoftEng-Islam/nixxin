{ settings, lib, pkgs, ... }:

let
  _editors = [
    # (lib.optional settings.system.editors.vscode ./vscode.nix)
    (lib.optional settings.system.editors.zedEditor ./zed-editor.nix)
    (lib.optional settings.system.editors.eclipse ./eclipse.nix)
    (lib.optional settings.system.editors.helix ./helix.nix)
  ];

  _editorsPackages = with pkgs; [
    (lib.optional settings.system.editors.vscode vscode-fhs)
    (lib.optional settings.system.editors.vscodium vscodium-fhs)
    (lib.optional settings.system.editors.gnomeTextEditor gnome-text-editor)
  ];

in {
  environment.systemPackages = lib.flatten _editorsPackages;
  imports = lib.flatten _editors;
}
