{ settings, pkgs, ... }: {
  #
  #  Direnv
  #
  #  Create shell.nix
  #  Create .envrc and add "use nix"
  #  Add 'eval "$(direnv hook zsh)"' to .zshrc
  #

  environment.systemPackages = with pkgs; [ direnv ];

  programs.direnv = {
    enable = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  # home-manager.users.${settings.user.username} = {
  #   programs.direnv = { enable = true; };
  # };
}
