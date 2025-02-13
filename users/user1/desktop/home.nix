{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      sessionPath =
        [ "$HOME/.bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.go/bin" ];

      sessionVariables = {
        PAGER = "less";
        LESS = "-R";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
        PIPENV_SHELL_FANCY = "1";
        ERL_AFLAGS = "-kernel shell_history enabled";
      };
    };
  };
}
