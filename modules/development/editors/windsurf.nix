{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.devin-desktop
  ];
}
