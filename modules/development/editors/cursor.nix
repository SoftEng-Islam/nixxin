{ pkgs, ... }:

{
  environment.systemPackages = [
    # Cursor — AI-powered code editor
    pkgs.update.code-cursor
  ];
}
