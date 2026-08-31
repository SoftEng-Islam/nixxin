{
  settings,
  lib,
  pkgs,
  ...
}:

let
  username = settings.user.username;
in
lib.mkIf (settings.modules.android.waydroid.enable or false) {

  virtualisation = {
    lxc.enable = true;
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
  };

  boot.kernelParams = [ "psi=1" ];
  boot.kernelModules = [ "uhid" ];

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = lib.mkDefault 1;
  };

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";

  # Custom Binderfs overrides
  environment.etc."gbinder.d/waydroid.conf".source = lib.mkForce (
    pkgs.writeText "waydroid.conf" ''
      [Protocol]
      /dev/binder = aidl3
      /dev/vndbinder = aidl3
      /dev/hwbinder = hidl

      [ServiceManager]
      /dev/binder = aidl3
      /dev/vndbinder = aidl3
      /dev/hwbinder = hidl
    ''
  );

  # Allow passwordless sudo using exact Nix store paths
  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "${pkgs.waydroid-nftables}/bin/waydroid";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.util-linux}/bin/mount";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  # Single source of truth for base Waydroid properties
  systemd.tmpfiles.settings."99-waydroid-settings"."/var/lib/waydroid/waydroid_base.prop".C = {
    user = "root";
    group = "root";
    mode = "0644";
    argument = builtins.toString (
      pkgs.writeText "waydroid_base.prop" ''
        # --- Performance Core ---
        sys.use_memfd=true
        ro.hardware.gralloc=gbm
        ro.hardware.egl=mesa
        ro.hardware.vulkan=radv

        # --- GPU & Display ---
        gralloc.gbm.device=/dev/dri/renderD128
        persist.waydroid.width=2560
        persist.waydroid.height=1440
        ro.sf.lcd_density=320

        # --- Camera & Compatibility ---
        ro.hardware.camera=v4l2
        ro.opengles.version=196610
        ro.vndk.lite=true

        # --- OTA Updates ---
        waydroid.system_ota=https://ota.waydro.id/system/lineage/waydroid_x86_64/GAPPS.json
        waydroid.vendor_ota=https://ota.waydro.id/vendor/waydroid_x86_64/MAINLINE.json
        waydroid.tools_version=1.5.4

        # --- Rendering ---
        debug.egl.hw_msaa=0
        ro.hwui.disable_scissor_opt=true

        # --- Dalvik Heap Tuning ---
        dalvik.vm.heapstartsize=16m
        dalvik.vm.heapgrowthlimit=256m
        dalvik.vm.heapsize=1024m
        dalvik.vm.heaptargetutilization=0.5
        dalvik.vm.heapminfree=8m
        dalvik.vm.heapmaxfree=16m

        # --- HWUI GPU Resource Budgets ---
        ro.hwui.texture_cache_size=72
        ro.hwui.layer_cache_size=48
        ro.hwui.drop_shadow_cache_size=6
        ro.hwui.gradient_cache_size=1
        ro.hwui.path_cache_size=32
        ro.hwui.text_large_cache_width=2048
        ro.hwui.text_large_cache_height=1024
        ro.hwui.text_small_cache_width=1024
        ro.hwui.text_small_cache_height=512

        persist.waydroid.suspend=false
      ''
    );
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/misc 0755 root root -"
    "d /home/${username}/Waydroid 0755 ${username} users -"
  ];

  # Declarative bind mounts for Waydroid shared folders
  fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Documents" = {
    device = "/home/${username}/Documents";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.after=waydroid-container.service"
    ];
  };

  fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Download" = {
    device = "/home/${username}/Downloads";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.after=waydroid-container.service"
    ];
  };

  fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Music" = {
    device = "/home/${username}/Music";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.after=waydroid-container.service"
    ];
  };

  fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Pictures" = {
    device = "/home/${username}/Pictures";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.after=waydroid-container.service"
    ];
  };

  fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Movies" = {
    device = "/home/${username}/Videos";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.after=waydroid-container.service"
    ];
  };

  environment.systemPackages = with pkgs; [
    waydroid-nftables
    (pkgs.writeShellApplication {
      name = "waydroid-aid";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        wl-clipboard-rs
        sqlite
        util-linux
        adb-sync
      ];
      text = ''
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell -- sh -c "sqlite3 /data/data/*/*/gservices.db 'select * from main where name = \"android_id\";'" | awk -F '|' '{print $2}' | wl-copy
        echo "Paste clipboard in this website below:"
        echo "https://www.google.com/android/uncertified"

        echo "Waiting for Android to fully boot before mounting shared directories..."
        until [ "$(sudo ${pkgs.waydroid-nftables}/bin/waydroid shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
          sleep 2
        done

        # 1. Create directories natively inside the Android container to bypass host permissions
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell mkdir -p /data/media/0/Documents /data/media/0/Download /data/media/0/Music /data/media/0/Pictures /data/media/0/Movies

        MEDIA_DIR="$HOME/.local/share/waydroid/data/media/0"

        # 2. Parse /proc/mounts to avoid double-mounting and bypass host permission blocks
        grep -q "$MEDIA_DIR/Documents" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Documents" "$MEDIA_DIR/Documents"
        grep -q "$MEDIA_DIR/Download" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Downloads" "$MEDIA_DIR/Download"
        grep -q "$MEDIA_DIR/Music" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Music" "$MEDIA_DIR/Music"
        grep -q "$MEDIA_DIR/Pictures" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Pictures" "$MEDIA_DIR/Pictures"
        grep -q "$MEDIA_DIR/Movies" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Videos" "$MEDIA_DIR/Movies"

        echo "Shared directories mounted successfully!"
      '';
    })
  ];
}
