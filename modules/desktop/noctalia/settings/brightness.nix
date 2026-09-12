{
  brightness = {
    enable_ddcutil = true;
    # ignore_mmids = [];                 # skip these monitors from ddcutil; run: ddcutil --verbose detect
    # minimum_brightness = 0.0;          # never let brightness drop below this floor (0.0 to 1.0)

    # Per-monitor backend override:
    #    monitor.eDP-1 = {
    #    backend = "backlight"             # auto | none | backlight | ddcutil
    #    backlight_device = "intel_backlight"  # explicit sysfs device name or path; run: noctalia msg brightness-list-backlight-devices
    #    [brightness.monitor.DP-1]
    #    backend = "ddcutil"
    #    [brightness.monitor.DP-2]
    #    ddc_bus = 6                       # pin the I2C bus when monitors share an EDID
    # };

    # Samsung Odyssey G5
    monitor.HDMI-A-1 = {
      backend = "ddcutil";
      ddc_bus = 0;
    };

    # Samsung S22C450
    monitor.DP-1 = {
      backend = "ddcutil";
      ddc_bus = 2;
    };
  };
}
