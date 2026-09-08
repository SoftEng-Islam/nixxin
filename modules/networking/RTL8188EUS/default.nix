{
  settings,
  lib,
  config,
  pkgs,
  ...
}:
#! ===============================================
#! [IMPORTANT] NetworkManager configuration
#! ===============================================
#* Add these lines below to "NetworkManager.conf" and ADD YOUR ADAPTER MAC below [keyfile] This will make the Network-Manager ignore the device, and therefore don't cause problems.
# =============================
# [device]
# wifi.scan-rand-mac-address=no

# [ifupdown]
# managed=false

# [connection]
# wifi.powersave=0

# [main]
# plugins=keyfile

# [keyfile]
# unmanaged-devices=mac:A7:A7:A7:A7:A7
# =============================
lib.mkIf (settings.modules.networking.rtl8188eus or false) {
  # TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS], ID 2357:010c
  #
  # No out-of-tree driver needed. The in-tree rtl8xxxu driver has
  # supported monitor mode + frame injection on this chip since
  # ~kernel 6.5, and we're well past that now (7.2.0). Only
  # blacklist the OTHER in-tree driver (r8188eu, a separate staging
  # driver for the same chip) so it doesn't grab the device instead
  # of rtl8xxxu.
  boot.blacklistedKernelModules = [ "r8188eu" ];
}
