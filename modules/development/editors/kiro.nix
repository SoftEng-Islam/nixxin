{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    inputs.kiro-flake.packages.x86_64-linux.kiro-desktop
  ];
}
