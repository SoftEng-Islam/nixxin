{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.webstorm
    notepad-next
  ];
}
