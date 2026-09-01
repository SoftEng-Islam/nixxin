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

  systemd.services.waydroid-container = {
    preStart = ''
      if [ ! -e /var/lib/waydroid/lxc/waydroid/config_nodes ]; then
        ${pkgs.waydroid-nftables}/bin/waydroid upgrade -o
      fi

      HOME_DIR="/home/${username}"
      MEDIA_DIR="$HOME_DIR/.local/share/waydroid/data/media/0"

      # Ensure host source directories exist with correct ownership
      ${pkgs.coreutils}/bin/mkdir -p \
        "$HOME_DIR/Documents" \
        "$HOME_DIR/Downloads" \
        "$HOME_DIR/Music" \
        "$HOME_DIR/Pictures" \
        "$HOME_DIR/Videos"

      # Ensure Android-side mount target directories exist and are owned by
      # media_rw (uid=1023, gid=1023) so the Android MediaStore can scan them.
      ${pkgs.coreutils}/bin/mkdir -p \
        "$MEDIA_DIR/Documents" \
        "$MEDIA_DIR/Download" \
        "$MEDIA_DIR/Music" \
        "$MEDIA_DIR/Pictures" \
        "$MEDIA_DIR/Movies"

      ${pkgs.coreutils}/bin/chown -R 1023:1023 \
        "$MEDIA_DIR/Documents" \
        "$MEDIA_DIR/Download" \
        "$MEDIA_DIR/Music" \
        "$MEDIA_DIR/Pictures" \
        "$MEDIA_DIR/Movies"

      # Apply GID 1023 (media_rw) and setgid to host dirs so Android can
      # read/write files created on the host side without permission errors.
      ${pkgs.coreutils}/bin/chgrp -R 1023 \
        "$HOME_DIR/Documents" \
        "$HOME_DIR/Downloads" \
        "$HOME_DIR/Music" \
        "$HOME_DIR/Pictures" \
        "$HOME_DIR/Videos" || true

      ${pkgs.coreutils}/bin/chmod -R g+rwX \
        "$HOME_DIR/Documents" \
        "$HOME_DIR/Downloads" \
        "$HOME_DIR/Music" \
        "$HOME_DIR/Pictures" \
        "$HOME_DIR/Videos" || true

      # setgid on directories: new files inherit the group automatically
      ${pkgs.findutils}/bin/find \
        "$HOME_DIR/Documents" \
        "$HOME_DIR/Downloads" \
        "$HOME_DIR/Music" \
        "$HOME_DIR/Pictures" \
        "$HOME_DIR/Videos" \
        -type d -exec ${pkgs.coreutils}/bin/chmod g+s {} + || true

      # Bind-mount host dirs onto the MEDIA_DIR targets.
      # These mounts happen in the *host* mount namespace before the LXC
      # container starts, so LXC inherits them via BindPaths propagation.
      mount_shared() {
        local source="$1" target="$2"
        ${pkgs.util-linux}/bin/mountpoint -q "$target" || \
          ${pkgs.util-linux}/bin/mount --bind "$source" "$target"
      }

      mount_shared "$HOME_DIR/Documents" "$MEDIA_DIR/Documents"
      mount_shared "$HOME_DIR/Downloads" "$MEDIA_DIR/Download"
      mount_shared "$HOME_DIR/Music"     "$MEDIA_DIR/Music"
      mount_shared "$HOME_DIR/Pictures"  "$MEDIA_DIR/Pictures"
      mount_shared "$HOME_DIR/Videos"    "$MEDIA_DIR/Movies"
    '';

    # Clean up bind mounts when the container stops so they don't pile up
    postStop = ''
      HOME_DIR="/home/${username}"
      MEDIA_DIR="$HOME_DIR/.local/share/waydroid/data/media/0"

      for dir in Documents Download Music Pictures Movies; do
        ${pkgs.util-linux}/bin/mountpoint -q "$MEDIA_DIR/$dir" && \
          ${pkgs.util-linux}/bin/umount "$MEDIA_DIR/$dir" || true
      done
    '';

    # Propagate the bind mounts into the LXC container namespace.
    serviceConfig = {
      BindPaths = [
        "/home/${username}/Documents:/home/${username}/Documents"
        "/home/${username}/Downloads:/home/${username}/Downloads"
        "/home/${username}/Music:/home/${username}/Music"
        "/home/${username}/Pictures:/home/${username}/Pictures"
        "/home/${username}/Videos:/home/${username}/Videos"
      ];
    };
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
    wl-clipboard      # Required for Waydroid clipboard sync
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
          echo "⚠ Some mounts are missing. Restarting waydroid-container..."
          sudo systemctl restart waydroid-container
          echo "Wait a moment, then launch Waydroid UI again."
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
  ];

}
