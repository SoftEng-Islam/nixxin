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
        adb-sync
      ];
      text = ''
        echo "Fetching Google Services Framework Android ID..."
        sudo ${pkgs.waydroid-nftables}/bin/waydroid shell -- sh -c "sqlite3 /data/data/*/*/gservices.db 'select * from main where name = \"android_id\";'" | awk -F '|' '{print $2}' | wl-copy
        echo "Paste clipboard in this website below:"
        echo "https://www.google.com/android/uncertified"
        echo ""

        echo "Waiting for Android to fully boot before mounting shared directories..."
        until [ "$(sudo ${pkgs.waydroid-nftables}/bin/waydroid shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; do
          sleep 2
        done

        echo "Applying native Android group permissions (GID 1023) to host folders..."
        # 1. Apply native group ownership so Android's internal scanner can read/write them seamlessly
        sudo chgrp -R 1023 "$HOME/Documents" "$HOME/Downloads" "$HOME/Music" "$HOME/Pictures" "$HOME/Videos" || true
        sudo chmod -R g+rwX "$HOME/Documents" "$HOME/Downloads" "$HOME/Music" "$HOME/Pictures" "$HOME/Videos" || true

        # 2. Apply 'setgid' so any new files you create on your host automatically inherit the group
        find "$HOME/Documents" "$HOME/Downloads" "$HOME/Music" "$HOME/Pictures" "$HOME/Videos" -type d -exec sudo chmod g+s {} + || true

        MEDIA_DIR="$HOME/.local/share/waydroid/data/media/0"
        mkdir -p "$MEDIA_DIR/Documents" "$MEDIA_DIR/Download" "$MEDIA_DIR/Music" "$MEDIA_DIR/Pictures" "$MEDIA_DIR/Movies"

        echo "Mounting folders into Waydroid..."

        # 3. Mount natively, checking the actual mount point rather than parsing /proc/mounts.
        mount_shared() {
          source="$1"
          target="$2"
          mountpoint -q "$target" || sudo ${pkgs.util-linux}/bin/mount --bind "$source" "$target"
        }

        mount_shared "$HOME/Documents" "$MEDIA_DIR/Documents"
        mount_shared "$HOME/Downloads" "$MEDIA_DIR/Download"
        mount_shared "$HOME/Music" "$MEDIA_DIR/Music"
        mount_shared "$HOME/Pictures" "$MEDIA_DIR/Pictures"
        mount_shared "$HOME/Videos" "$MEDIA_DIR/Movies"

        echo "Shared directories successfully mounted with native performance!"
      '';
    })
  ];

}
