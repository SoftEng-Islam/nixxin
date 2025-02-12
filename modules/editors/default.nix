{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    # (lib.optional settings.system.editors.vscode ./vscode)
    (lib.optional settings.modules.editors.zedEditor ./zed-editor.nix)
    (lib.optional settings.modules.editors.eclipse ./eclipse.nix)
    (lib.optional settings.modules.editors.helix ./helix.nix)
  ];

  _pkgs = with pkgs; [
    (lib.optional settings.modules.editors.vscode vscode)
    (lib.optional settings.modules.editors.vscodium vscodium)
    (lib.optional settings.modules.editors.gnomeTextEditor gnome-text-editor)
  ];
in mkIf (settings.modules.editors.enable) {
  environment.systemPackages = lib.flatten _pkgs;
  imports = lib.flatten _imports;
}
