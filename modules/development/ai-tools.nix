{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # AI Tools for developers
    pkgs.update.code-cursor
    pkgs.update.antigravity
    pkgs.update.windsurf
  ];
}
