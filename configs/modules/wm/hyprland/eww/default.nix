{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ eww ];

  home-manager.users.${settings.username} = {
    #home.file.".config/eww".source = ./eww;
    #home.file.".config/gtklock".source = ./gtklock;
    #home.file.".config/fish".source = ./fish;
  };
}
