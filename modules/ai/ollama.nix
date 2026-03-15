{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  _ollama = with pkgs; [
    (lib.optional settings.moudles.ai.ollama.rocm ollama-rocm)
    (lib.optional settings.moudles.ai.ollama.ollama-cuda ollama-cuda)
  ];
in
mkIf (settings.modules.ai.ollama.enable) {
  services.ollama = {
    enable = settings.modules.ai.ollama.enable;
    acceleration = "rocm";
    host = "127.0.0.1";

    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "10.1.2";
      OLLAMA_VRAM_OVERRIDE = "1";
      OLLAMA_KEEP_ALIVE = "10 m";

    };
    # models = "/opt/ollama/models";
  };
  environment.systemPackages = with pkgs; [ ollama ] ++ lib.flatten _ollama;
}
