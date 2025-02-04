{ settings, pkgs, ... }:
let
  waydroidGbinderConf = pkgs.writeText "waydroid.conf" ''
    [Protocol]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl

    [ServiceManager]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl
  '';
in {
  # Additional configurations, notes and post-installation steps
  # in https://nixos.wiki/wiki/WayDroid or https://wiki.nixos.org/wiki/Waydroid
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  # ---- Installation ---- #
  # After you have downloaded both system and vendor image, extract them.
  # Now move both vendor.img and system.img to `/etc/waydroid-extra/images/`
  # Lastly, in your terminal enter this command `sudo waydroid init -f`
  # https://sourceforge.net/projects/waydroid/files/images/
  # aria2c https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_x86_64/lineage-18.1-20250201-MAINLINE-waydroid_x86_64-vendor.zip/download
  # aria2c https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-18.1-20250201-GAPPS-waydroid_x86_64-system.zip/download

  # Additional configurations and notes:
  # 1. You may need to adjust settings if you have an NVIDIA card or an RX 6800 series:
  #    - Edit /var/lib/waydroid/waydroid_base.prop and set:
  #      ro.hardware.gralloc=default
  #      ro.hardware.egl=swiftshader
  # 2. For Linux kernel 5.18 and later, set sys.use_memfd=true in waydroid_base.prop
  # 3. Add wl-clipboard to system packages for clipboard support:
  #    environment.systemPackages = with pkgs; [ wl-clipboard ];

  # Post-installation steps:
  # - Run 'sudo waydroid init' to fetch WayDroid images.
  # - You can add "-s GAPPS -f" to the init command for GApps support.
  # - Start the WayDroid container with 'sudo systemctl start waydroid-container'.
  # - Begin a WayDroid session with 'waydroid session start'.

  # Fixing Waydroid Binder Issues on NixOS
  # Step 1: Manually Mount binderfs
  # sudo mkdir -p /dev/binderfs
  # sudo mount -t binder none /dev/binderfs
  # ls /dev/binderfs/
  # It should show:
  # binder  hwbinder  vndbinder

  # ---- Start the container ---- #
  # Start the Waydroid LXC container
  # $ sudo systemctl start waydroid-container
  #
  # You'll know it worked by checking the journal You should see "Started Waydroid Container".
  # $ sudo journalctl -u waydroid-container
  #
  # Start Waydroid session
  # You'll know it is finished when you see the message "Android with user 0 is ready".
  # $ waydroid session start

  # ------------------------------- #
  # ------------------------------- #

  # ---- General usage ---- #
  # Start Android UI
  # $ waydroid show-full-ui
  #
  # List Android apps
  # $ waydroid app list
  #
  # Start an Android app
  # $ waydroid app launch <application name>
  #
  # Install an Android app
  # $ waydroid app install </path/to/app.apk>
  #
  # Enter the LXC shell
  # $ sudo waydroid shell
  #
  # Overrides the full-ui width
  # $ waydroid prop set persist.waydroid.width 608

  # ------------------------------- #
  # ------------------------------- #

  # ---- Update Android ---- #
  # $ sudo waydroid upgrade

  # ------------------------------- #
  # ------------------------------- #

  # ---- GPU Adjustments ---- #
  # In case you have an NVIDIA card or an RX 6800 series, you'll need to disable GBM and mesa-drivers:
  # /var/lib/waydroid/waydroid_base.prop
  #- ro.hardware.gralloc=default
  #- ro.hardware.egl=swiftshader

  # ------------------------------- #
  # ------------------------------- #

  # ---- Linux 5.18+ ---- #
  # Linux 5.18 and later removed ashmem in favor of memfd, so you may need to tell Waydroid (1.2.1 and later) to use the new module:
  # /var/lib/waydroid/waydroid_base.prop
  #- sys.use_memfd=true

  fileSystems."/dev/binderfs" = {
    device = "none";
    fsType = "binder";
    options = [ "defaults" ];
  };

  environment.etc."gbinder.d/waydroid.conf".source = waydroidGbinderConf;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  systemd.services.waydroid-container = {
    description = "Waydroid Container";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.waydroid}/bin/waydroid -w container start";
      ExecStop = "${pkgs.waydroid}/bin/waydroid container stop";
      ExecStopPost = "${pkgs.waydroid}/bin/waydroid session stop";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/misc 0755 root root -" # for dnsmasq.leases
  ];
  environment.systemPackages = with pkgs; [
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    wl-clipboard
  ];
}
