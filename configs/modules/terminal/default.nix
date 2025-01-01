{ settings, pkgs, ... }: {
  imports = [
    ./btop
    ./zsh.nix
    ./shell.nix
    # ./alacritty.nix
    # ./tmux.nix
    ./kitty.nix
    ./foot.nix
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # home-manager.users.${settings.username} = {};
}
