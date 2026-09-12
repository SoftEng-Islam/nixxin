{
  system.monitor = {
    enabled = true; # sample CPU, memory, network, load, temperature, GPU VRAM, and disk statistics
    cpu_poll_seconds = 2.0; # CPU usage, CPU temperature, and load average
    cpu_freq_activity_threshold = 2.5; # GHz; value tint starts when CPU clock crosses this
    cpu_freq_critical_threshold = 4.5; # GHz; full highlight at/above this
    gpu_poll_seconds = 5.0; # GPU temperature and VRAM usage
    memory_poll_seconds = 2.0; # RAM usage
    network_poll_seconds = 3.0; # network throughput
    disk_poll_seconds = 10.0; # disk usage and swap usage; graph widgets use the fastest poll above
  };
}
