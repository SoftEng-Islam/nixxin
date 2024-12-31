{ settings, ... }: {
  imports = [ ./zsh.nix ];
  home-manager.users.${settings.username} = {
    imports = [
      #  ./alacritty.nix
      # ./tmux.nix
      ./kitty.nix
      ./foot.nix
    ];
  };
}
