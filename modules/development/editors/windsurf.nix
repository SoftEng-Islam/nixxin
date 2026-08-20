{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.devin-desktop
  ];
}
