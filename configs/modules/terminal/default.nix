{ settings, pkgs, ... }: {
  imports = [
    ./btop
    ./neovim
    ./nvim
    ./wezterm

    # ./alacritty.nix
    ./foot.nix
    ./zsh.nix
    ./shell.nix
    # ./tmux.nix
    ./kitty.nix
    ./foot.nix
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # home-manager.users.${settings.username} = {};
}
