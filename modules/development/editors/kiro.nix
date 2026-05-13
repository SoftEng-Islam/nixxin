{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    kiro-flake.packages.x86_64-linux.kiro-desktop
  ];
}
