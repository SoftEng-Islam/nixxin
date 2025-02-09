{ settings, pkgs, ... }: {
  services.ollama = {
    enable = false;
    acceleration = "rocm";
    environmentVariables = { HSA_OVERRIDE_GFX_VERSION = "10.1.2"; };
    #      models = "/opt/ollama/models";
  };
}
