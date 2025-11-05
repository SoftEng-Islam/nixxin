{ settings, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in { imports = optionals (settings.modules.ai.enable) [ ./ollama.nix ]; }
