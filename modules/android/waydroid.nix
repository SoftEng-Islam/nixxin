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
    "cgroup_enable=cpuset"
    "cgroup_enable=memory"
    "cgroup_memory=1"
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

  # environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";

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

    # writeShellApplication so `jq`/`hyprctl`/`adb` are guaranteed on PATH
    # via runtimeInputs. No Weston/kiosk-shell anymore: waydroid show-full-ui
    # is a native Wayland client, so Hyprland's own fullscreen windowrule
    # (match:class ^(Waydroid)$) handles placement/sizing directly.
    (pkgs.writeShellApplication {
      name = "waydroid-ui";
      runtimeInputs = with pkgs; [
        jq
        hyprland
        android-tools
      ];
      text = ''
        # 1. Clean up any stale session
        waydroid session stop 2>/dev/null || true

        # 2. Detect the target monitor's native resolution. This still
        # matters even without Weston: persist.waydroid.width/height
        # controls the resolution of Android's internal virtual display,
        # which the native Wayland surface then presents at. If this is
        # wrong, the windowrule will still fullscreen the *window*, but
        # the Android content rendered inside it will be the wrong size.
        #
        # We prefer a hardcoded target monitor name (your Odyssey G5,
        # normally HDMI-A-1) over Hyprland's "focused" state, since
        # "focused" reflects wherever your cursor/keyboard happened to be
        # when this script launched, not necessarily the screen you want
        # Waydroid on. Falls back to "focused" if the name isn't found
        # (e.g. cable moved to a different port), then to 1080p if
        # hyprctl/jq are unavailable entirely.
        #
        # Verify the correct name any time with:
        #   hyprctl monitors -j | jq -r '.[] | {name, width, height, focused}'
        TARGET_MONITOR="HDMI-A-1"

        MONITORS_JSON=$(hyprctl monitors -j 2>/dev/null || echo '[]')

        read -r MON_W MON_H < <(
          echo "$MONITORS_JSON" | jq -r --arg mon "$TARGET_MONITOR" '
            (map(select(.name == $mon)) + map(select(.focused == true)))
            | .[0]
            | if . then "\(.width) \(.height)" else empty end
          ' 2>/dev/null
        )

        MON_W=''${MON_W:-1920}
        MON_H=''${MON_H:-1080}

        # 3. Android display props (Unlocked for smooth 60 FPS)
        waydroid prop set persist.waydroid.width "$MON_W"
        waydroid prop set persist.waydroid.height "$MON_H"
        waydroid prop set persist.waydroid.dpi 240
        waydroid prop set persist.waydroid.fps 60

        # 4. Start the Android container session
        waydroid session start &

        # Wait for Android to be fully ready
        until waydroid status | grep -q "RUNNING"; do
          sleep 2
        done

        sleep 2

        # Restore standard Android animation speeds
        adb -s 192.168.240.112:5555 shell settings put global window_animation_scale 1.0 2>/dev/null || true
        adb -s 192.168.240.112:5555 shell settings put global transition_animation_scale 1.0 2>/dev/null || true
        adb -s 192.168.240.112:5555 shell settings put global animator_duration_scale 1.0 2>/dev/null || true

        # 5. Launch the native Wayland UI directly. This blocks until the
        # user closes the window, at which point we tear the session down.
        waydroid show-full-ui

        waydroid session stop
      '';
    })
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
