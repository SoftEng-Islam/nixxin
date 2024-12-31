{ settings, pkgs, ... }: {
  imports = [ ./zsh.nix ./shell.nix ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.${settings.username} = {
    imports = [
      # ./alacritty.nix
      # ./tmux.nix
      ./kitty.nix
      ./foot.nix
    ];
  };
}
