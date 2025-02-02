{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Linux & system call monitoring
    binutils # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    bpftrace # High-level tracing language for Linux eBPF
    ethtool # Utility for controlling network drivers and hardware
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    geoclue2 # Geolocation framework and some data providers
    linux-pam # Pluggable Authentication Modules, a flexible mechanism for authenticating user
    lm_sensors # for `sensors` command, Tools for reading hardware sensors
    lsof # list open files
    ltrace # library call monitoring
    man
    man-db
    man-pages # Linux development manual pages
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    shfmt # Shell parser and formatter
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    sysstat # Collection of performance monitoring tools for Linux (such as sar, iostat and pidstat)
    udevil # Mount without password
    usbutils # Tools for working with USB devices, such as lsusb
    whois # Intelligent WHOIS client from Debian
    busybox # Tiny versions of common UNIX utilities in a single small executable
    fdupes # Identifies duplicate files residing within specified directories
  ];
}
