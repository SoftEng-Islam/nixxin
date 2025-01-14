{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Linux & system call monitoring
    bpftrace # High-level tracing language for Linux eBPF
    ethtool # Utility for controlling network drivers and hardware
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    linux-pam # Pluggable Authentication Modules, a flexible mechanism for authenticating user
    lm_sensors # for `sensors` command
    lsof # list open files
    ltrace # library call monitoring
    man-pages # Linux development manual pages
    shfmt # Shell parser and formatter
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    sysstat # Collection of performance monitoring tools for Linux (such as sar, iostat and pidstat)
  ];
}
