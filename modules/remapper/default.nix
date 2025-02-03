{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ./Hawck.nix
    ./input-remapper.nix
    ./kmonad.nix
    ./xremap.nix
  ];
}
