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

  # environment.etc."gbinder.d/waydroid.conf".source = lib.mkForce (
  #   pkgs.writeText "waydroid.conf" ''
  #     [Protocol]
  #     /dev/binder = aidl3
  #     /dev/vndbinder = aidl3
  #     /dev/hwbinder = hidl

  #     [ServiceManager]
  #     /dev/binder = aidl3
  #     /dev/vndbinder = aidl3
  #     /dev/hwbinder = hidl
  #   ''
  # );

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
      ];

      text = ''
        # 1. Determine the currently focused monitor.
        MONITORS_JSON=$(hyprctl monitors -j)

        read -r MON_W MON_H < <(
          echo "$MONITORS_JSON" | jq -r '
            .[]
            | select(.focused == true)
            | "\(.width) \(.height)"
          '
        )

        MON_W=''${MON_W:-1920}
        MON_H=''${MON_H:-1080}

        echo "Waydroid target resolution: ''${MON_W}x''${MON_H}"

        # 2. Stop any existing session.
        waydroid session stop 2>/dev/null || true

        # 3. Configure Android's virtual display.
        waydroid prop set persist.waydroid.width "$MON_W"
        waydroid prop set persist.waydroid.height "$MON_H"
        waydroid prop set persist.waydroid.dpi 240
        waydroid prop set persist.waydroid.fps 60

        # 4. Start Waydroid.
        waydroid session start >/dev/null 2>&1 &

        # 5. Wait until the Waydroid session is running.
        until waydroid status | grep -q 'Session:[[:space:]]*RUNNING'; do
          sleep 1
        done

        # Give Android a moment to initialize.
        sleep 2

        # 6. Launch Waydroid.
        waydroid show-full-ui

        # 7. Clean up when the window closes.
        waydroid session stop 2>/dev/null || true
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
