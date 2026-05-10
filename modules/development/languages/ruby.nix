{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ruby_3_4
    bundler
    solargraph
  ];
}
