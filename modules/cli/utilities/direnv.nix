{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.cli.utilities.direnv.enable or false) {
  #
  #  Direnv
  #  https://direnv.net/
  #  Create shell.nix
  #  Create .envrc and add "use nix"
  #  Add 'eval "$(direnv hook zsh)"' to .zshrc
  #

  programs.direnv = {
    enable = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  environment.variables = {
    DIRENV_LOG_FORMAT = "";
  };

  # `programs.direnv.enable` already provides the package.
}
