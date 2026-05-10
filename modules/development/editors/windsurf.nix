{ pkgs, ... }:

{
  environment.systemPackages = [
    # Windsurf — AI-powered code editor by Codeium
    pkgs.update.windsurf
  ];
}
