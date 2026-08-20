{ pkgs, ... }:

{
  environment.systemPackages = [
    # Cursor — AI-powered code editor
    pkgs.code-cursor
  ];
}
