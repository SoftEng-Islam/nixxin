{
  settings,
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkIf
    optionals
    optional
    flatten
    ;
  development = settings.modules.development;

  _imports = [
    (optional development.vscode ./vscode.nix)
    (optional development.zedEditor ./zed-editor.nix)
    (optional development.emacs ./emacs.nix)
    (optional development.eclipse ./eclipse.nix)
    (optional development.helix ./helix.nix)
    (optional development.postgresql ./postgresql.nix)
    (optional development.nodejs ./nodejs.nix)
    (optional development.database ./database.nix)
    (optional development.claude-code ./claude-code.nix)
    (optional development.api-tools ./api-tools.nix)
    (optional development.development-env ./development-env.nix)
    (optional development.ai-tools ./ai-tools.nix)
    (optional development.editors ./editors.nix)
    (optional development.shell-tools ./shell-tools.nix)
    (optional development.cloud-tools ./cloud-tools.nix)
  ];
in
{
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
    # nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
  };
}
