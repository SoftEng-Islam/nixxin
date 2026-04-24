{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-text-editor
    jetbrains.webstorm
  ];
}
