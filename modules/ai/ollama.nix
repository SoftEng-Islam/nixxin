{ settings, pkgs, ... }: {
  services.ollama = {
    enable = false;
    acceleration = "rocm";
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "10.1.2";
      OLLAMA_VRAM_OVERRIDE = "1";
    };
    #      models = "/opt/ollama/models";
  };
  environment.systemPackages = with pkgs; [ ollama-rocm ];
}
