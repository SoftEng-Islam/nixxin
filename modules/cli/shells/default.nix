{ pkgs, ... }:
{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ zsh ];
  };
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];
}
