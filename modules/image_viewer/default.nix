{ settings, pkgs, ... }: {
  imports = [
    ./eog.nix
    ./feh.nix
    ./loupe.nix
    # ./LXImage-Qt.nix
  ];
}
