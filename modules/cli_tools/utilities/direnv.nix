{ settings, pkgs, ... }: {
  #
  #  Direnv
  #
  #  Create shell.nix
  #  Create .envrc and add "use nix"
  #  Add 'eval "$(direnv hook zsh)"' to .zshrc
  #

  programs.direnv = {
    enable = settings.modules.cli_tools.utilities.direnv.enable or false;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  environment.systemPackages = with pkgs; [ direnv ];
}
