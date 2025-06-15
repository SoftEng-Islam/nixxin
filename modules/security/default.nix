{ settings, config, lib, pkgs, ... }:

let inherit (lib) mkIf;
in {
  # imports = [ ./gpg_agent.nix ];

  config = mkIf (settings.modules.security.enable) {
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

      # Swaylock needs an entry in PAM to proberly unlock
      pam.services.swaylock.text = ''
        # PAM configuration file for the swaylock screen locker. By default, it includes
        # the 'login' configuration file (see /etc/pam.d/login)
        auth include login
      '';

      # Remove certain resource limits for programs that needs them gone, mostly for heavier emulators.
      pam.loginLimits = [
        {
          domain = "*";
          type = "hard";
          item = "memlock";
          value = "unlimited";
        }
        {
          domain = "*";
          type = "soft";
          item = "memlock";
          value = "unlimited";
        }
      ];

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

    #? [boot.tmp.useTmpfs] What it does:
    # Mounts /tmp as a tmpfs — a RAM-backed filesystem.
    # This means files in /tmp are stored in memory, not on your SSD or disk.
    #* ✅ Pros:
    # Very fast read/write (RAM speed)
    # Good for SSD lifespan (fewer writes)
    # Automatically wiped on reboot (volatile — nothing persists).
    #* 🔄 Why lib.mkDefault true?
    # This makes it the default unless explicitly overridden elsewhere (e.g., in another module or config).
    # tmpfs = /tmp is mounted in ram. Doing so makes temp file management speedy
    # on ssd systems, and volatile! Because it's wiped on reboot.
    boot.tmp.useTmpfs = lib.mkDefault true;
    # If not using tmpfs, which is naturally purged on reboot, we must clean it
    # /tmp ourselves. /tmp should be volatile storage!
    boot.tmp.cleanOnBoot = let cleaningMakesSense = !config.boot.tmp.useTmpfs;
    in cleaningMakesSense;

    boot.kernelParams = [ "tmpfs.size=3G" ];
    # Fix a security hole in place for backwards compatibility. See desc in
    # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
    boot.loader.systemd-boot.editor = false;

    boot.kernel.sysctl = {
      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 0;

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

      ## TCP optimization
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender's initial TCP SYN. Setting 3 = enable TCP Fast Open for
      # both incoming and outgoing connections:
      "net.ipv4.tcp_fastopen" = 3;
      # Bufferbloat mitigations + slight improvement in throughput & latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
    boot.kernelModules = [ "tcp_bbr" ];

    # Change me later!
    # user.initialPassword = "nixos";
    # users.users.root.initialPassword = "nixos";

    environment.systemPackages = with pkgs; [
      openvpn # Robust and highly flexible tunneling application
      protonvpn-cli # Linux command-line client for ProtonVPN
    ];
  };
}
