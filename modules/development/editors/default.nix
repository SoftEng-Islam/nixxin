{ settings, lib, ... }:
let
  inherit (lib)
    optionals
    optional
    flatten
    ;
  editors = settings.modules.development.editors;
  _imports = [
    (optional editors.helix.enable ./helix.nix)
    (optional editors.vscode.enable ./vscode.nix)
    (optional editors.webstorm.enable ./webstorm.nix)
    (optional editors.zed-editor.enable ./zed-editor.nix)
  ];
in
{
  imports = optionals (editors.enable or false) flatten _imports;
}
