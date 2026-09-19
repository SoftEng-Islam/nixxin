{ pkgs, ... }:
{
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ zsh ];
  };
  environment.systemPackages = with pkgs; [ dash ];
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];
}
