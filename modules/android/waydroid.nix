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
  # Additional configurations, notes and post-installation steps
  # in ./waydroid.readme.md
  # in https://nixos.wiki/wiki/WayDroid or https://wiki.nixos.org/wiki/Waydroid
  # or https://docs.waydro.id/usage/install-on-desktops

  virtualisation = {
    #? Is This Needed?
    lxc.enable = true;
    # lxc.unprivilegedContainers = true;

    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
  };

  fileSystems."/dev/binderfs" = {
    device = "none";
    fsType = "binder";
    options = [ "defaults" ];
  };

  # Mount host directories to waydroid
  # systemd.packages = with pkgs; [ waydroid-helper ];
  # systemd.services.waydroid-mount.wantedBy = [ "multi-user.target" ];

  # Force disable waydroid service so that it is not started at boot
  # systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];
  # Keeping the container running in the background makes Waydroid launch much faster when you click your UI script because the Android "hardware" is already warmed up.
  systemd.services.waydroid-container.wantedBy = [ "multi-user.target" ];

  # Waydroid's default LXC config mounts cgroups read-only:
  #   lxc.mount.auto = cgroup:ro sys:ro proc
  # Android init/libprocessgroup then spams errors because it can't create
  # cgroup directories (uid_0, uid_1000, etc.).
  #
  # We patch the generated config in two places:
  # - activation: fixes existing configs after `nixos-rebuild switch`
  # - preStart: ensures config is corrected right before the container starts
  # system.activationScripts.waydroid-lxc-cgroup-rw = ''
  # config=/var/lib/waydroid/lxc/waydroid/config
  # if [ -f "$config" ]; then
  # ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
  # fi
  # '';

  # systemd.services.waydroid-container.preStart = lib.mkBefore ''
  #   config=/var/lib/waydroid/lxc/waydroid/config
  #   if [ -f "$config" ]; then
  #     ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
  #   fi
  # '';

  # Waydroid needs these kernel environment settings
  boot.kernelParams = [
    "psi=1"

    # Switch to cgroup v1 (legacy) so Android's libprocessgroup can mount
    # blkio, cpu, cpuset, memory, and schedtune controllers inside the container.
    # Without this, waydroid spams "Failed to mount/setup <cgroup>" errors.
    # NOTE: NixOS does not officially support this; if a future NixOS update
    # breaks boot, remove these two lines and accept cosmetic cgroup errors.
    # "systemd.unified_cgroup_hierarchy=0"
    # "SYSTEMD_CGROUP_ENABLE_LEGACY_FORCE=1"
  ];
  boot.kernelModules = [
    "uhid"
  ];

  # Fix for Magisk/LXC: Allow nested mounts and unprivileged user namespaces
  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = lib.mkDefault 1;
  };

  systemd.services.waydroid-container.preStart = lib.mkBefore ''
    config=/var/lib/waydroid/lxc/waydroid/config
    nodes=/var/lib/waydroid/lxc/waydroid/config_nodes
    waydroid_cfg=/var/lib/waydroid/waydroid.cfg
    waydroid_prop=/var/lib/waydroid/waydroid.prop

    # 1. Fix the missing card0 issue (card0 doesn't exist, only card1)
    if [ -f "$nodes" ]; then
      ${pkgs.gnused}/bin/sed -i 's|/dev/dri/card0|/dev/dri/card1|g' "$nodes"
    fi

    # 2. Disable force_gles so Waydroid can use the native Vulkan/Mesa path.
    #    waydroid regenerates waydroid.cfg on each session start, so we patch
    #    it here (preStart runs after the file is written).
    if [ -f "$waydroid_cfg" ]; then
      ${pkgs.gnused}/bin/sed -i 's/^force_gles = 1/force_gles = 0/' "$waydroid_cfg"
    fi

    # 3. Remove the hard-coded ccodec=0 override that waydroid injects into
    #    waydroid.prop, so our waydroid_base.prop value of ccodec=4 wins.
    if [ -f "$waydroid_prop" ]; then
      ${pkgs.gnused}/bin/sed -i '/^debug\.stagefright\.ccodec=0$/d' "$waydroid_prop"
    fi
  '';

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  environment.sessionVariables.WLR_DRM_DEVICES = "/dev/dri/card1";
  environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";
  # environment.sessionVariables.WAYDROID_DISABLE_GBM = "1"; # For NVIDIA and AMD RX 6800 series, disable GBM and mesa-drivers

  environment.etc."gbinder.d/waydroid.conf".source = lib.mkForce (pkgs.writeText "waydroid.conf" ''
    [Protocol]
    /dev/binder = aidl3
    /dev/vndbinder = aidl3
    /dev/hwbinder = hidl

    [ServiceManager]
    /dev/binder = aidl3
    /dev/vndbinder = aidl3
    /dev/hwbinder = hidl
  '');

  # Tell waydroid to use memfd and not ashmem
  # cat /var/lib/waydroid/waydroid_base.prop
  systemd.tmpfiles.settings."99-waydroid-settings"."/var/lib/waydroid/waydroid_base.prop".C = {
    user = "root";
    group = "root";
    mode = "0644";
    argument = builtins.toString (
      pkgs.writeText "waydroid_base.prop" ''
        # --- Performance Core ---
        sys.use_memfd=true
        # Must match what waydroid auto-detects at runtime (minigbm_gbm_mesa, not gbm)
        ro.hardware.gralloc=minigbm_gbm_mesa
        ro.hardware.egl=mesa
        ro.hardware.vulkan=radeon

        # --- GPU Binding ---
        # Ensure this matches your GPU (ls -l /dev/dri/by-path/ to check)
        gralloc.gbm.device=/dev/dri/renderD128

        # --- Video Playback Fixes for R7 Graphics ---
        # Software codecs (ccodec=4) because the iGPU lacks HW HEVC/AV1 decode.
        # NOTE: waydroid.prop overrides this with ccodec=0 at runtime;
        # that override is patched away in the preStart hook below.
        debug.stagefright.ccodec=4

        # --- Camera & Compatibility ---
        ro.hardware.camera=v4l2
        ro.opengles.version=196610
        ro.vndk.lite=true

        # --- OTA Updates ---
        waydroid.system_ota=https://ota.waydro.id/system/lineage/waydroid_x86_64/GAPPS.json
        waydroid.vendor_ota=https://ota.waydro.id/vendor/waydroid_x86_64/MAINLINE.json
        waydroid.tools_version=1.5.4

        # --- Rendering ---
        # Disables multisample anti-aliasing (expensive on iGPU)
        debug.egl.hw_msaa=0
        # Force 2D renderer to skip scissor optimisation overhead
        ro.hwui.disable_scissor_opt=true

        # --- Dalvik Heap Tuning (reduces GC pauses on 16 GB host) ---
        dalvik.vm.heapstartsize=16m
        dalvik.vm.heapgrowthlimit=256m
        dalvik.vm.heapsize=512m
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

  # Setting up a shared folder
  # sudo mount --bind <source> ~/.local/share/waydroid/data/media/0/<target>
  # Then verify that the target folder exists:
  # sudo ls ~/.local/share/waydroid/data/media/0/
  # Examples:
  # sudo mount --bind ~/Documents ~/.local/share/waydroid/data/media/0/Documents
  # sudo mount --bind ~/Downloads ~/.local/share/waydroid/data/media/0/Download
  # sudo mount --bind ~/Music ~/.local/share/waydroid/data/media/0/Music
  # sudo mount --bind ~/Pictures ~/.local/share/waydroid/data/media/0/Pictures
  # sudo mount --bind ~/Videos ~/.local/share/waydroid/data/media/0/Movies

  # Mount a shared folder from the host to the waydroid container under /Shared
  # Change [user] to your username
  # sudo chown [user]:wheel /home/[user]/Waydroid
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
    "d /var/lib/misc 0755 root root -" # for dnsmasq.leases

    # Set proper permissions for the shared folder
    "d /home/${username}/Waydroid 0755 ${username} users -"
  ];

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "waydroid-aid";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        # waydroid-helper
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

      # 2. Mesa / AMD performance env vars for the Kaveri iGPU
      export RADV_TEX_ANISO=0
      export AMD_TEX_ANISO=0
      export mesa_glthread=true      # async GL dispatch -> less CPU stall
      export vblank_mode=0           # disable vsync on host side (wayland handles it)
      export MESA_NO_ERROR=1         # skip expensive GL error checking

      # 3. Android display props
      #    1280x720 @ 160dpi is the sweet spot for Kaveri R7 iGPU.
      #    At 1920x1080 the GPU can't keep up (100% janky frames observed).
      waydroid prop set persist.waydroid.width 1280
      waydroid prop set persist.waydroid.height 720
      waydroid prop set persist.waydroid.dpi 160

      # 4. Halve animation durations so the UI feels snappier
      adb -s 192.168.240.112:5555 shell settings put global window_animation_scale 0.5 2>/dev/null || true
      adb -s 192.168.240.112:5555 shell settings put global transition_animation_scale 0.5 2>/dev/null || true
      adb -s 192.168.240.112:5555 shell settings put global animator_duration_scale 0.5 2>/dev/null || true

      # 5. Start Weston at the reduced resolution
      ${pkgs.weston}/bin/weston -Swayland-waydroid \
        --backend=wayland-backend.so \
        --width=1280 --height=720 \
        --fullscreen \
        --shell="kiosk-shell.so" &
      WESTON_PID=$!

      # Wait for Weston socket with a timeout
      for i in {1..20}; do
        [ -S "$XDG_RUNTIME_DIR/wayland-waydroid" ] && break
        echo "Waiting for Weston... $i"
        sleep 0.5
      done

      # 6. Start Android session
      export WAYLAND_DISPLAY=wayland-waydroid
      waydroid session start &

      # Wait for Android to be fully ready
      until waydroid status | grep -q "RUNNING"; do
        sleep 2
      done

      # Small extra sleep to let Mesa/gralloc settle
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
      icon = "waydroid"; # Note: usually lowercase is safer for icon names
      # "System" is a main category, "Emulator" is additional,
      # and "X-Android" is your custom tag.
      categories = [
        "System"
        "Emulator"
        "X-Android"
      ];
    };
  };
}
