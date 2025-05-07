{ settings, config, pkgs, ... }: {
  boot = {
    # blacklistedKernelModules = [ "rtl8812au" "rtl8xxxu" "r8188eu" ];
    extraModulePackages = with config.boot.kernelPackages;
      [ rtl8188eus-aircrack ];
  };
  networking.wireless.driver = "rtl8188eus-aircrack";
  environment.systemPackages = with pkgs;
    [
      # RealTek RTL8188eus WiFi driver with monitor mode & frame injection support
      # linuxKernel.packages.linux_zen.rtl8188eus-aircrack
    ];
}
