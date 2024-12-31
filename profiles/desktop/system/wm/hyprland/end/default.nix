{ settings, impurity, ... }:
let
  username = settings.username;
  homeDirectory = "/home/${settings.username}";
in {
  imports = [
    # Cachix
    # ./cachix.nix
    ## Dotfiles (manual)
    ./dotfiles.nix
    # Stuff
    ./ags.nix
    ./anyrun.nix
    ./browser.nix
    ./dconf.nix
    ./hyprland.nix
    ./mimelist.nix
    # ./starship.nix
    ./sway.nix
    ./theme.nix
  ];

  home = {
    inherit username homeDirectory;
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
    sessionPath = [ "$HOME/.local/bin" ];
  };

  xdg.userDirs = { createDirectories = true; };

  gtk = {
    gtk3 = {
      bookmarks = [
        "file://${homeDirectory}/Downloads"
        "file://${homeDirectory}/Documents"
        "file://${homeDirectory}/Pictures"
        "file://${homeDirectory}/Music"
        "file://${homeDirectory}/Videos"
        "file://${homeDirectory}/.config"
        "file://${homeDirectory}/.config/ags"
        "file://${homeDirectory}/.config/hypr"
        "file://${homeDirectory}/GitHub"
        # "file:///mnt/Windows"
      ];
    };
  };
}
