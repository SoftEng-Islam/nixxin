{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.ai.enable) { imports = [ ./ollama.nix ]; }
