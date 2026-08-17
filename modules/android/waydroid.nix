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

  # Let NixOS handle Binderfs natively.
  # Manual mounts are no longer needed on modern NixOS and can cause conflicts.

  systemd.services.waydroid-container.wantedBy = [ "multi-user.target" ];

  system.activationScripts.waydroid-lxc-cgroup-rw = ''
    config=/var/lib/waydroid/lxc/waydroid/config
    if [ -f "$config" ]; then
      ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
    fi
  '';

  boot.kernelParams = [
    "psi=1"
  ];

  boot.kernelModules = [
    "uhid"
  ];

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = lib.mkDefault 1;
  };

  systemd.services.waydroid-container.preStart = lib.mkBefore ''
    waydroid_cfg=/var/lib/waydroid/waydroid.cfg

    # Disable force_gles so Waydroid can use the native Vulkan/Mesa path.
    if [ -f "$waydroid_cfg" ]; then
      ${pkgs.gnused}/bin/sed -i 's/^force_gles = 1/force_gles = 0/' "$waydroid_cfg"
    fi
  '';

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";

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

  systemd.tmpfiles.settings."99-waydroid-settings"."/var/lib/waydroid/waydroid_base.prop".C = {
    user = "root";
    group = "root";
    mode = "0644";
    argument = builtins.toString (
      pkgs.writeText "waydroid_base.prop" ''
        # --- Performance Core ---
        sys.use_memfd=true
        ro.hardware.gralloc=minigbm_gbm_mesa
        ro.hardware.egl=mesa
        ro.hardware.vulkan=radv

        # --- GPU Binding ---
        # Render node D128 is correct for a primary Vega 11 APU
        gralloc.gbm.device=/dev/dri/renderD128

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

        # --- Dalvik Heap Tuning (Optimized for 16GB Host RAM) ---
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

  fileSystems."/home/${username}/Waydroid" = {
    device = "/home/${username}/.local/share/waydroid/data/media/0/Shared";
    fsType = "none";
    options = [
      "bind"
      "create"
      "rw"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/misc 0755 root root -"
    "d /home/${username}/Waydroid 0755 ${username} users -"
  ];

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "waydroid-aid";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        wl-clipboard-rs
      ];
      text = ''
        sudo waydroid shell -- sh -c "sqlite3 /data/data/*/*/gservices.db 'select * from main where name = \"android_id\";'" | awk -F '|' '{print $2}' | wl-copy
        echo "Paste clipboard in this website below"
        echo "https://www.google.com/android/uncertified"
        echo "Then run"
        echo "waydroid session stop"
        sudo mount --bind ~/Documents ~/.local/share/waydroid/data/media/0/Documents
        sudo mount --bind ~/Downloads ~/.local/share/waydroid/data/media/0/Download
        sudo mount --bind ~/Music ~/.local/share/waydroid/data/media/0/Music
        sudo mount --bind ~/Pictures ~/.local/share/waydroid/data/media/0/Pictures
        sudo mount --bind ~/Videos ~/.local/share/waydroid/data/media/0/Movies
      '';
    })

    (pkgs.writeShellScriptBin "waydroid-ui" ''
      # 1. Clean up any stale session
      waydroid session stop 2>/dev/null || true

      # 2. Modern Mesa thread optimizations
      export mesa_glthread=true
      export vblank_mode=0

      # 3. Android display props (Unlocked for smooth 60 FPS)
      waydroid prop set persist.waydroid.width 1920
      waydroid prop set persist.waydroid.height 1080
      waydroid prop set persist.waydroid.dpi 240
      waydroid prop set persist.waydroid.fps 60

      # Restore standard Android animation speeds
      adb -s 192.168.240.112:5555 shell settings put global window_animation_scale 1.0 2>/dev/null || true
      adb -s 192.168.240.112:5555 shell settings put global transition_animation_scale 1.0 2>/dev/null || true
      adb -s 192.168.240.112:5555 shell settings put global animator_duration_scale 1.0 2>/dev/null || true

      # 4. Start Weston at Full HD natively
      ${pkgs.weston}/bin/weston -Swayland-waydroid \
        --backend=wayland-backend.so \
        --width=1920 --height=1080 \
        --fullscreen \
        --shell="kiosk-shell.so" &
      WESTON_PID=$!

      # Wait for Weston socket with a timeout
      for i in {1..20}; do
        [ -S "$XDG_RUNTIME_DIR/wayland-waydroid" ] && break
        echo "Waiting for Weston... $i"
        sleep 0.5
      done

      # 5. Start Android session
      export WAYLAND_DISPLAY=wayland-waydroid
      waydroid session start &

      # Wait for Android to be fully ready
      until waydroid status | grep -q "RUNNING"; do
        sleep 2
      done

      sleep 2

      waydroid show-full-ui &

      wait $WESTON_PID
      waydroid session stop
    '')
  ];

  home-manager.users.${username} = {
    xdg.desktopEntries."Waydroid" = {
      name = "Waydroid";
      genericName = "Full Android OS on a regular GNU/Linux System.";
      exec = "waydroid-ui";
      icon = "waydroid";
      categories = [
        "System"
        "Emulator"
        "X-Android"
      ];
    };
  };
}
