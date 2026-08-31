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

  # ==========================================
  # 1. Base Virtualisation & Kernel
  # ==========================================
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

  # ==========================================
  # 2. Networking & Network Permissions
  # ==========================================
  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";

  # ==========================================
  # 3. Binderfs Overrides
  # ==========================================
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

  # ==========================================
  # 4. Security & Sudo Rules
  # ==========================================
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
        {
          # Added umount to prevent password prompts when the service stops
          command = "${pkgs.util-linux}/bin/umount";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # ==========================================
  # 5. Waydroid System Properties (tmpfiles)
  # ==========================================
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

  # ==========================================
  # 6. Shared Folders (Automount Service)
  # ==========================================

  /*
    ❌ COMMENTED OUT: Declarative fileSystems mounts ❌
    Reason: These execute at system boot BEFORE Waydroid starts. When Android
    boots, its own internal FUSE filesystem mounts over /data/media/0, which
    hides or deletes these host mounts. We now handle this dynamically below.

    fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Documents" = {
      device = "/home/${username}/Documents";
      fsType = "none";
      options = [ "bind" "x-systemd.after=waydroid-container.service" ];
    };
    fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Download" = {
      device = "/home/${username}/Downloads";
      fsType = "none";
      options = [ "bind" "x-systemd.after=waydroid-container.service" ];
    };
    fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Music" = {
      device = "/home/${username}/Music";
      fsType = "none";
      options = [ "bind" "x-systemd.after=waydroid-container.service" ];
    };
    fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Pictures" = {
      device = "/home/${username}/Pictures";
      fsType = "none";
      options = [ "bind" "x-systemd.after=waydroid-container.service" ];
    };
    fileSystems."/home/${username}/.local/share/waydroid/data/media/0/Movies" = {
      device = "/home/${username}/Videos";
      fsType = "none";
      options = [ "bind" "x-systemd.after=waydroid-container.service" ];
    };
  */

  systemd.services.waydroid-mounts = {
    description = "Automount host directories into Waydroid with UID translation";
    wantedBy = [ "waydroid-container.service" ];
    after = [ "waydroid-container.service" ];
    bindsTo = [ "waydroid-container.service" ];

    path = with pkgs; [
      waydroid-nftables
      util-linux
      gnugrep
      coreutils
      bindfs # <-- Added bindfs to translate permissions for Android
    ];

    script = ''
      echo "Waiting for Waydroid to fully boot..."
      until [ "$(${pkgs.waydroid-nftables}/bin/waydroid shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
        sleep 2
      done

      # Give Android's FUSE wrapper a moment to fully initialize
      sleep 2

      echo "Waydroid is booted. Applying mounts..."
      MEDIA_DIR="/home/${username}/.local/share/waydroid/data/media/0"

      # 1. Create directories natively inside Android
      ${pkgs.waydroid-nftables}/bin/waydroid shell -- mkdir -p /data/media/0/Documents /data/media/0/Download /data/media/0/Music /data/media/0/Pictures /data/media/0/Movies

      # 2. Assign ownership to Android's native media_rw group (UID 1023)
      ${pkgs.waydroid-nftables}/bin/waydroid shell -- chown 1023:1023 /data/media/0/Documents /data/media/0/Download /data/media/0/Music /data/media/0/Pictures /data/media/0/Movies

      # 3. Get Host User IDs (Usually 1000 and 100)
      HOST_UID=$(id -u ${username})
      HOST_GID=$(id -g ${username})

      # 4. Use bindfs for intelligent permission mapping (Host User <-> Android media_rw)
      mount_shared() {
        HOST_PATH=$1
        ANDROID_PATH=$2
        grep -q "$ANDROID_PATH" /proc/mounts || bindfs --force-user=1023 --force-group=1023 --create-for-user=$HOST_UID --create-for-group=$HOST_GID "$HOST_PATH" "$ANDROID_PATH"
      }

      mount_shared "/home/${username}/Documents" "$MEDIA_DIR/Documents"
      mount_shared "/home/${username}/Downloads" "$MEDIA_DIR/Download"
      mount_shared "/home/${username}/Music" "$MEDIA_DIR/Music"
      mount_shared "/home/${username}/Pictures" "$MEDIA_DIR/Pictures"
      mount_shared "/home/${username}/Videos" "$MEDIA_DIR/Movies"
    '';

    preStop = ''
      MEDIA_DIR="/home/${username}/.local/share/waydroid/data/media/0"
      umount "$MEDIA_DIR/Documents" || true
      umount "$MEDIA_DIR/Download" || true
      umount "$MEDIA_DIR/Music" || true
      umount "$MEDIA_DIR/Pictures" || true
      umount "$MEDIA_DIR/Movies" || true
    '';

    serviceConfig = {
      Type = "simple";
      RemainAfterExit = true;
    };
  };

  # ==========================================
  # 7. Packages & Utilities
  # ==========================================
  environment.systemPackages = with pkgs; [
    wl-clipboard # Required for Waydroid clipboard sync
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
        echo "Fetching Google Services Framework Android ID..."
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell -- sh -c "sqlite3 /data/data/*/*/gservices.db 'select * from main where name = \"android_id\";'" | awk -F '|' '{print $2}' | wl-copy
        echo "Paste clipboard in this website below:"
        echo "https://www.google.com/android/uncertified"

        /*
        ❌ COMMENTED OUT: Redundant Mount Logic ❌
        Reason: Having this inside your manual script conflicts with the new,
        robust `waydroid-mounts` systemd service running in the background.

        echo "Waiting for Android to fully boot before mounting shared directories..."
        until [ "$(sudo ${pkgs.waydroid-nftables}/bin/waydroid shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
          sleep 2
        done
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell -- mkdir -p /data/media/0/Documents /data/media/0/Download /data/media/0/Music /data/media/0/Pictures /data/media/0/Movies
        MEDIA_DIR="$HOME/.local/share/waydroid/data/media/0"
        grep -q "$MEDIA_DIR/Documents" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Documents" "$MEDIA_DIR/Documents"
        grep -q "$MEDIA_DIR/Download" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Downloads" "$MEDIA_DIR/Download"
        grep -q "$MEDIA_DIR/Music" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Music" "$MEDIA_DIR/Music"
        grep -q "$MEDIA_DIR/Pictures" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Pictures" "$MEDIA_DIR/Pictures"
        grep -q "$MEDIA_DIR/Movies" /proc/mounts || sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Videos" "$MEDIA_DIR/Movies"
        echo "Shared directories mounted successfully!"
        */
      '';
    })
  ];
}
