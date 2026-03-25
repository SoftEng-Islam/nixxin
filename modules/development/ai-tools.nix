{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # AI Tools for developers
    copilot-cli
    code-cursor

    pkgs.update.antigravity
    pkgs.update.windsurf
  ];
}
