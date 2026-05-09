{
  settings,
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
    (optional development.ai-tools ./ai-tools.nix)
    (optional development.api-tools ./api-tools.nix)
    (optional development.claude-code ./claude-code.nix)
    (optional development.cloud-tools ./cloud-tools.nix)
    (optional development.database ./database.nix)
    (optional development.development-env ./development-env.nix)
    (optional development.postgresql ./postgresql.nix)
    (optional development.languages.enable ./langauges)
  ];
in
{
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
    # nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
  };
}
