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

  home-manager.users.${settings.user.username}.programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
    config = {
      global = {
        load_dotenv = true;
        hide_env_diff = true;
        # log_format = "$(tput setaf 1)%e$(tput sgr0)";
      };
    };
  };
}
