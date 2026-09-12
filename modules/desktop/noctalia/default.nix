{ settings, pkgs, ... }: {
  imports = [
    ./greeter.nix
    ./noctalia.nix
  ];
}
