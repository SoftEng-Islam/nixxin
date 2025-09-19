{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.development.tools.devenv.enable or false) {
  #  Devenv
  #  https://devenv.sh/
  #  Create devenv.json
  #  https://devenv.sh/docs/getting-started
  #  https://devenv.sh/docs/examples
  #  https://devenv.sh/docs/reference/devenv-json
  #  https://devenv.sh/docs/reference/devenv-yml
  #  https://devenv.sh/docs/features
  #  https://devenv.sh/docs/features/shell-integration
  #  Add 'eval "$(devenv hook zsh)"' to .zshrc
  environment.systemPackages = with pkgs;
    [
      devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    ];
}
