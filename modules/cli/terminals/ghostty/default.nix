{
  config,
  pkgs,
  lib,
  ...
}: {
  # Use xdg.configFile instead of home.file for better semantics
  xdg.configFile."ghostty/config".source = ./config;
}
