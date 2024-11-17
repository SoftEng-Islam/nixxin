{

  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "softeng";
    homeDirectory = "/home/softeng";
    stateVersion = "24.05";
  };
}
