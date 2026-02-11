{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.cpupower.enable or false) {
  environment.systemPackages = with pkgs; [
    cpufrequtils
    perf-tools
    linuxKernel.packages.linux_zen.cpupower
  ];

  systemd.services.cpupower-gui-helper = {
    description = "cpupower-gui system helper";
    documentation = [ "https://github.com/vagnum08/cpupower-gui" ];
    aliases = [ "dbus-org.rnd2.cpupower_gui.helper.service" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "org.rnd2.cpupower_gui.helper";
      ExecStart =
        "${pkgs.cpupower-gui}/lib/cpupower-gui/cpupower-gui-helper";
    };
  };
}
