{
  settings,
  lib,
  pkgs,
  ...
}:

let
  username = settings.user.username;
  homeDir = "/home/${username}";
  mediaDir = "${homeDir}/.local/share/waydroid/data/media/0";
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

  # Ensure host source directories exist, owned by the user, group-writable
  # and setgid to waydroid_media (gid 1023 / media_rw, see section 6) so
  # Android's MediaStore can read/write through the bind mount without
  # permission errors. A bind mount shows the *source* directory's
  # permissions, so this is what actually governs what Android sees.
  systemd.tmpfiles.rules = [
    "d ${homeDir}/Documents 2775 ${username} waydroid_media -"
    "d ${homeDir}/Downloads 2775 ${username} waydroid_media -"
    "d ${homeDir}/Music 2775 ${username} waydroid_media -"
    "d ${homeDir}/Pictures 2775 ${username} waydroid_media -"
    "d ${homeDir}/Videos 2775 ${username} waydroid_media -"
  ];

  systemd.services.waydroid-container = {
    preStart = ''
      if [ ! -e /var/lib/waydroid/lxc/waydroid/config_nodes ]; then
        ${pkgs.waydroid-nftables}/bin/waydroid upgrade -o
      fi
    '';
  };

  boot.kernelParams = [ "psi=1" ];
  boot.kernelModules = [
    "uhid"
  ];

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
        ro.hardware.vulkan=radeon

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

  # ==========================================
  # 6. Shared Folders (Native Group Mapping)
  # ==========================================

  # Map Android's internal media group (media_rw, GID 1023) to your host user
  users.groups.waydroid_media = {
    gid = 1023;
  };
  users.users.${username}.extraGroups = [ "waydroid_media" ];

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
      ];
      text = ''
        echo "=== Waydroid Shared Directories Health Check ==="
        echo ""

        # ── Verify bind mounts are live ────────────────────────────────────────
        MEDIA_DIR="$HOME/.local/share/waydroid/data/media/0"
        all_ok=true
        for pair in "Documents:Documents" "Downloads:Download" "Music:Music" "Pictures:Pictures" "Videos:Movies"; do
          host_dir="$HOME/''${pair%%:*}"
          android_dir="$MEDIA_DIR/''${pair##*:}"
          if mountpoint -q "$android_dir"; then
            echo "  ✓ $host_dir  →  $android_dir"
          else
            echo "  ✗ NOT mounted: $android_dir"
            all_ok=false
          fi
        done

        if ! $all_ok; then
          echo ""
          echo "⚠ Some mounts are missing. They are now managed as system fileSystems"
          echo "  entries — try: sudo systemctl restart <mount-unit> or"
          echo "  sudo mount -a, then restart waydroid-container:"
          echo "  sudo systemctl restart waydroid-container"
          exit 0
        fi

        echo ""
        echo "✓ All shared directories are properly mounted."
        echo ""
        echo "Your files are accessible in Waydroid at:"
        echo "  /sdcard/Documents"
        echo "  /sdcard/Download"
        echo "  /sdcard/Music"
        echo "  /sdcard/Pictures"
        echo "  /sdcard/Movies"
        echo ""
        echo "Open the Files app in Android to browse them."
        echo "Gallery apps may need to be restarted to refresh their cache."
        echo ""

        # ── Google Device Registration (bonus) ────────────────────────────────
        if command -v sqlite3 >/dev/null 2>&1; then
          echo "Attempting to fetch Google Services Framework Android ID..."
          GSF_DB="$HOME/.local/share/waydroid/data/data/com.google.android.gsf/databases/gservices.db"
          if [ -f "$GSF_DB" ]; then
            ANDROID_ID=$(sqlite3 "$GSF_DB" "select value from main where name = 'android_id';" 2>/dev/null || true)
            if [ -n "$ANDROID_ID" ]; then
              echo "$ANDROID_ID" | wl-copy 2>/dev/null && \
                echo "✓ Android ID copied to clipboard: $ANDROID_ID" || \
                echo "Android ID: $ANDROID_ID"
              echo "Register at: https://www.google.com/android/uncertified"
            else
              echo "(Android ID not found in database)"
            fi
          else
            echo "(Google Services Framework not installed or not yet initialized)"
          fi
        fi
      '';
    })

    # --- Start script: mounts to the TRUE source directory ---
    (pkgs.writeShellApplication {
      name = "waydroid-start-shared";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        util-linux
      ];
      text = ''
        echo "Starting Waydroid session..."
        waydroid session start &

        echo "Waiting for Android container to initialize..."
        # Check if the real data directory is available via the container shell
        while ! sudo ${pkgs.waydroid-nftables}/bin/waydroid shell test -d /data/media/0 2>/dev/null; do
          sleep 0.5
        done

        # Use Waydroid's shell to create the directories inside Android.
        # This avoids needing to add `mkdir` to your sudo extraRules.
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell mkdir -p /data/media/0/Documents /data/media/0/Download /data/media/0/Music /data/media/0/Pictures /data/media/0/Movies

        # Target the REAL source directory, not the ~/.local/share mirror!
        REAL_MEDIA_DIR="/var/lib/waydroid/data/media/0"

        echo "Applying bind mounts to the core data image..."
        sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Documents" "$REAL_MEDIA_DIR/Documents"
        sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Downloads" "$REAL_MEDIA_DIR/Download"
        sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Music" "$REAL_MEDIA_DIR/Music"
        sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Pictures" "$REAL_MEDIA_DIR/Pictures"
        sudo ${pkgs.util-linux}/bin/mount --bind "$HOME/Videos" "$REAL_MEDIA_DIR/Movies"

        echo "Waiting for Android system to finish booting..."
        while [ "$(sudo ${pkgs.waydroid-nftables}/bin/waydroid shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
          sleep 1
        done

        echo "Triggering MediaStore scan..."
        echo "content call --uri content://media/ --method scan_volume --arg external_primary" | sudo ${pkgs.waydroid-nftables}/bin/waydroid shell > /dev/null 2>&1

        echo "Shared directories mounted and scanned! Launching UI..."
        waydroid show-full-ui
      '';
    })

    # --- Stop script: unmounts from the TRUE source directory ---
    (pkgs.writeShellApplication {
      name = "waydroid-stop-shared";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        util-linux
      ];
      text = ''
        REAL_MEDIA_DIR="/var/lib/waydroid/data/media/0"

        echo "Unmounting shared directories from the core data image..."
        sudo ${pkgs.util-linux}/bin/umount "$REAL_MEDIA_DIR/Documents" 2>/dev/null || true
        sudo ${pkgs.util-linux}/bin/umount "$REAL_MEDIA_DIR/Download" 2>/dev/null || true
        sudo ${pkgs.util-linux}/bin/umount "$REAL_MEDIA_DIR/Music" 2>/dev/null || true
        sudo ${pkgs.util-linux}/bin/umount "$REAL_MEDIA_DIR/Pictures" 2>/dev/null || true
        sudo ${pkgs.util-linux}/bin/umount "$REAL_MEDIA_DIR/Movies" 2>/dev/null || true

        echo "Stopping Waydroid session..."
        waydroid session stop
      '';
    })
  ];

}
