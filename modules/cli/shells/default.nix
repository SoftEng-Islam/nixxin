{ pkgs, ... }:
{
  environment = {
    shells = with pkgs; [ zsh ];
  };
  environment.systemPackages = with pkgs; [ dash ];
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];
}
