{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firebase-tools
    heroku
  ];
}
