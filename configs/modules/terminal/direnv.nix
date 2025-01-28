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
  # home-manager.users.${settings.users.user1.username} = {
  #   programs.direnv = { enable = true; };
  # };
}
