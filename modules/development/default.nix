{
  settings,
  lib,
  pkgs,
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
    (optional development.databases.enable ./databases)
    (optional development.editors.enable ./editors)
    (optional development.js-engines.enable ./js-engines)
    (optional development.languages.enable ./langauges)

    (optional development.api-tools ./api-tools.nix)
    (optional development.cloud-tools ./cloud-tools.nix)
  ];
in
{
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
    # nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
    environment.systemPackages = with pkgs; [
      python3

      ruby_3_4
      bundler
      bundix

      # https://devenv.sh/
      devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    ];
  };
}
