{ settings, lib, pkgs, ... }:
{
  # Optimize udev rules
  # services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  # services.udev = {
  #   extraRules = ''
  #     # Reduce USB device timeout
  #     ACTION=="add", SUBSYSTEM=="usb", ATTR{power/autosuspend}="-1"

  #     # Better scheduling for NVMe
  #     # ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  #     # Better scheduling for SSD and HDD
  #     ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/scheduler}="bfq"
  #   '';
  # };
  # Systemd optimizations
  # systemd = {
  #   services.systemd-udevd.serviceConfig = {
  #     TimeoutSec = "30";
  #     Nice = "-10"; # Give udev higher priority
  #   };

  # Optimize journal
  # services.systemd-journald.serviceConfig = {
  #   TimeoutStartSec = "30";
  #   Nice = "-10";
  # };
  # };
}
