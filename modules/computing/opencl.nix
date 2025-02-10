{ settings, lib, pkgs, ... }: {
  environment.variables = {
    # Optional: For Polaris cards (Radeon 500 series) OpenCL support
    ROC_ENABLE_PRE_VEGA = "1";
  };
  environment.systemPackages = with pkgs; [ ];
  home-manager.users."${settings.users.selected.username}" = { };
}
