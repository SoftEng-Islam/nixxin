{ settings, lib, pkgs, ... }: {
  # Tools and configs to Analyze/Trace The system
  services = {
    # sysprof profiling daemon.
    # sysprof is a system-wide profiler that collects performance data.
    # It can be used to analyze the performance of applications and the system.
    # It is useful for debugging performance issues and optimizing applications.
    # It can be used to profile applications, system services, and the kernel.
    sysprof.enable = true;
  };
  environment.systemPackages = with pkgs; [
    cpuid
    trace-cmd

    # Requirements PC Diagnose
    lshw # Provide detailed information on the hardware configuration of the machine
    lshw-gui
    lm_sensors
    smartmontools
    dmidecode
    pciutils
    coreutils
  ];
}
