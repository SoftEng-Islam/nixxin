{ settings, config, pkgs, ... }: {
  boot = {
    blacklistedKernelModules =
      [ "rtl8812au" "rtl8xxxu" "r8188eu" "rtw_8821cu" "rtw_core" ];
    extraModulePackages = with config.boot.kernelPackages; [ rtw_8821cu ];
  };
  networking.wireless.driver = "rtw_8821cu";
  environment.systemPackages = with pkgs;
    [ linuxKernel.packages.linux_zen.rtw88 ];
}
