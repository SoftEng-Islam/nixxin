# ----------------------------------------------
# ---- Security Module Configuration
# ----------------------------------------------
# This Module configures security settings for the system.
# It includes settings for kernel protection, sudo configuration,
# polkit, rtkit, tpm2 support, and system security tweaks.
# It also sets up systemd-boot, kernel parameters, and user namespaces.
{
  settings,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./vpn
    ./gpg_agent.nix
  ];
  config = lib.mkIf (settings.modules.security.enable or false) {
    security = {
      # System security tweaks
      protectKernelImage = true;

      sudo.enable = true;

      # during testing only 550K-650K of the tmpfs where used
      # wrapperDirSize = "10M";

      # don't ask for password for wheel group
      sudo.wheelNeedsPassword = true;

      # show Password as stars in Terminals.
      sudo.extraConfig = ''
        Defaults        env_reset,pwfeedback
      '';

      allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading

      # Enable polkit. polkit-kde-agent needs to be installed and started at boot seperately (will be done with Hyprland)
      polkit.enable = true;

      # rtkit is recommended for pipewire
      rtkit.enable = true;

      isolate.enable = false;

      sudo.configFile = ''
        root   ALL=(ALL:ALL) SETENV: ALL
        %wheel ALL=(ALL:ALL) SETENV: ALL
        softeng ALL=(ALL:ALL) SETENV: ALL
      '';

      # Enable basic tpm2 support
      tpm2 = {
        enable = settings.modules.security.tpm2;
        pkcs11.enable = true;
        tctiEnvironment.enable = true;
      };

      # to create new namespaces.
      unprivilegedUsernsClone = true;

      # So we don't have to do this later...
      acme.acceptTerms = true;
    };

    # Fix a security hole in place for backwards compatibility. See desc in
    # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
    boot.loader.systemd-boot.editor = false;

    boot.kernel.sysctl = {

      # Help the CPU switch between NixOS and Waydroid tasks faster
      # "kernel.sched_latency_ns" = 4000000;
      # "kernel.sched_min_granularity_ns" = 400000;
      # "kernel.sched_wakeup_granularity_ns" = 500000;

      # Ensure the system doesn't "pause" to write logs to the SSD too often
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;

      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 1; # 0 = Disable, 1 = Enable

      ## TCP hardening
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      # Reverse path filtering causes the kernel to do source validation of
      # packets received from all interfaces. This can mitigate IP spoofing.
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      # Do not accept IP source route packets (we're not a router)
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      # Don't send ICMP redirects (again, we're on a router)
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      # Refuse ICMP redirects (MITM mitigations)
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      # Protects against SYN flood attacks
      "net.ipv4.tcp_syncookies" = 1;
      # Incomplete protection again TIME-WAIT assassination
      "net.ipv4.tcp_rfc1337" = lib.mkDefault 1;

      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
      "net.core.rmem_default" = 1048576;
      "net.core.wmem_default" = 1048576;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.ip_forward" = true; # Enable IPv4 forwarding
      "net.ipv6.conf.all.forwarding" = true; # Enable IPv6 forwarding
      # sets the kernel’s TCP keepalive time to 120 seconds. To see the available parameters, run sysctl -a.
      "net.ipv4.tcp_keepalive_time" = 120;

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender's initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      "net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";

      "net.core.somaxconn" = 4096;
      "net.ipv4.tcp_fin_timeout" = 10;

      "kernel.unprivileged_bpf_disabled" = 1;

      "net.ipv4.conf.all.proxy_arp" = 0;
      "net.ipv4.conf.all.log_martians" = 1; # log suspicious packets
    };
    boot.kernelModules = [ "tcp_bbr" ];

    # Change me later!
    # user.initialPassword = "nixos";
    # users.users.root.initialPassword = "nixos";

    networking.firewall.checkReversePath = false;
    # environment.systemPackages = with pkgs; [ resolv_wrapper ];
  };
}
