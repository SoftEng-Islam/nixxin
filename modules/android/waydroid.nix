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
  };

  boot.kernelParams = [
    "psi=1"
  ];

  boot.kernelModules = [
    "uhid"
  ];

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

  # Waydroid base properties
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

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "waydroid-aid";
      runtimeInputs = with pkgs; [
        waydroid
        wl-clipboard-rs
        sqlite
      ];
      text = ''
        sudo waydroid shell -- sh -c "sqlite3 /data/data/*/*/gservices.db 'select * from main where name = \"android_id\";'" | awk -F '|' '{print $2}' | wl-copy
        echo "Paste clipboard in this website below:"
        echo "https://www.google.com/android/uncertified"
        echo "Then run: waydroid session stop"

        # Dynamically mount folders after initialization
        sudo mount --bind ~/Documents ~/.local/share/waydroid/data/media/0/Documents
        sudo mount --bind ~/Downloads ~/.local/share/waydroid/data/media/0/Download
        sudo mount --bind ~/Music ~/.local/share/waydroid/data/media/0/Music
        sudo mount --bind ~/Pictures ~/.local/share/waydroid/data/media/0/Pictures
        sudo mount --bind ~/Videos ~/.local/share/waydroid/data/media/0/Movies
      '';
    })

    (pkgs.writeShellApplication {
      name = "waydroid-ui";
      runtimeInputs = with pkgs; [
        jq
        hyprland
        android-tools
        waydroid
      ];
      text = ''
        # 1. Clean up any stale session
        waydroid session stop 2>/dev/null || true

        # 2. Detect the currently focused monitor's resolution
        MONITORS_JSON=''$(hyprctl monitors -j 2>/dev/null || echo '[]')

        read -r MON_W MON_H < <(
          echo "''$MONITORS_JSON" | jq -r '
            map(select(.focused == true))[0]
            | if . then "\(.width) \(.height)" else empty end
          ' 2>/dev/null
        )

        MON_W=''${MON_W:-1920}
        MON_H=''${MON_H:-1080}

        # 3. Apply properties with sudo (required to modify /var/lib/waydroid/waydroid.cfg)
        sudo waydroid prop set persist.waydroid.width "''$MON_W"
        sudo waydroid prop set persist.waydroid.height "''$MON_H"
        sudo waydroid prop set persist.waydroid.dpi 240
        sudo waydroid prop set persist.waydroid.fps 60

        # 4. Start container session
        waydroid session start &

        until waydroid status | grep -q "RUNNING"; do
          sleep 1
        done

        # 5. Force Android WindowManager to resize the frame buffer live
        sudo waydroid shell wm size "''${MON_W}x''${MON_H}"

        # 6. Reset animation speeds via ADB
        adb -s 192.168.240.112:5555 shell settings put global window_animation_scale 1.0 2>/dev/null || true
        adb -s 192.168.240.112:5555 shell settings put global transition_animation_scale 1.0 2>/dev/null || true
        adb -s 192.168.240.112:5555 shell settings put global animator_duration_scale 1.0 2>/dev/null || true

        # 7. Launch UI surface
        waydroid show-full-ui

        # 8. Reset wm size and stop session on exit
        # sudo waydroid shell wm size reset 2>/dev/null || true
        # waydroid session stop
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
