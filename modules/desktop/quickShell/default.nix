{ settings, lib, pkgs, ... }: {
  # git clone https://github.com/Shanu-Kumawat/quickshell-overview ~/.config/quickshell/overview

  home-manager.users.${settings.user.username} = {
    home.file."~/.config/quickshell/overview".source = ./quickshell/overview;
  };

  environment.systemPackages = with pkgs; [ quickshell ];
}
