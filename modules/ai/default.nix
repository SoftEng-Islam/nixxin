{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals mkIf;
in
{
  imports = optionals (settings.modules.ai.enable) [
    ./ollama.nix
    ./claude-code.nix
    ./gemini-cli.nix
  ];

  # What this does?
  # environment.persistence."/persist" = {
  #   users.${settings.user.username} = {
  #     directories = [
  #       ".gemini"
  #       ".claude"
  #     ];
  #     files = [
  #       ".claude.json"
  #     ];
  #   };
  # };
}
