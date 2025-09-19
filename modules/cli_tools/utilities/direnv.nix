{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.cli_tools.utilities.direnv.enable or false) {
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

  environment.variables = { DIRENV_LOG_FORMAT = ""; };

  environment.systemPackages = with pkgs;
    [
      direnv # Shell extension that manages your environment
    ];
}
