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
    ./postgresql.nix
    ./nodejs.nix
    ./database.nix
    ./api-tools.nix
    ./development-env.nix
    ./ai-tools.nix
    ./editors.nix
    ./shell-tools.nix
    ./cloud-tools.nix
  ];
in
{
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
    # nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
  };
}
