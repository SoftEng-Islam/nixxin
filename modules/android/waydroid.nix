{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  username = settings.user.username;

in
lib.mkIf (settings.modules.android.waydroid.enable or false) {
  # Additional configurations, notes and post-installation steps
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
  system.activationScripts.waydroid-lxc-cgroup-rw = ''
    config=/var/lib/waydroid/lxc/waydroid/config
    if [ -f "$config" ]; then
      ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
    fi
  '';

  # systemd.services.waydroid-container.preStart = lib.mkBefore ''
  #   config=/var/lib/waydroid/lxc/waydroid/config
  #   if [ -f "$config" ]; then
  #     ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
  #   fi
  # '';

  # Waydroid needs these kernel environment settings
  boot.kernelParams = [
    "psi=1"

    # NixOS does not officially support this configuration and might cause your system to be unbootable in future versions. You are on your own.
    # "systemd.unified_cgroup_hierarchy=0"
    # "SYSTEMD_CGROUP_ENABLE_LEGACY_FORCE=1"
  ];
  boot.kernelModules = [
    "uhid"
    "binder_linux"
  ];

  # Fix for Magisk/LXC: Allow nested mounts and unprivileged user namespaces
  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = lib.mkDefault 1;
  };

  systemd.services.waydroid-container.preStart = lib.mkBefore ''
    config=/var/lib/waydroid/lxc/waydroid/config
    nodes=/var/lib/waydroid/lxc/waydroid/config_nodes

    # 1. Fix cgroups (Your existing fix)
    # if [ -f "$config" ]; then
    #    ${pkgs.gnused}/bin/sed -i -E '/^lxc\.mount\.auto = / s/cgroup:ro/cgroup:rw/' "$config"
    # fi

    # 2. Fix the missing card0 issue!
    # if [ -f "$nodes" ]; then
    #   # Replace card0 with card1
    #   ${pkgs.gnused}/bin/sed -i 's|/dev/dri/card0|/dev/dri/card1|g' "$nodes"
    # fi

    # Optionally, disable unnecessary desktop files
    sed -i 's|(\[Desktop Entry\])|$1\nNoDisplay=true|' ~/.local/share/applications/waydroid.*.desktop
  '';

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  environment.sessionVariables.WLR_DRM_DEVICES = "/dev/dri/card1";
  environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";
  # environment.sessionVariables.WAYDROID_DISABLE_GBM = "1"; # For NVIDIA and AMD RX 6800 series, disable GBM and mesa-drivers

  environment.etc."gbinder.d/waydroid.conf".source = pkgs.writeText "waydroid.conf" ''
    [Protocol]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl

    [ServiceManager]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl
  '';

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
        ro.hardware.gralloc=gbm
        ro.hardware.egl=mesa
        ro.hardware.vulkan=radeon

        # --- GPU Binding ---
        # Ensure this matches your GPU (ls -l /dev/dri/by-path/ to check)
        gralloc.gbm.device=/dev/dri/renderD128

        # --- Video Playback Fixes for R7 Graphics ---
        # We allow software codecs (ccodec=4) because your GPU
        # lacks hardware support for HEVC/AV1.
        debug.stagefright.ccodec=4

        # --- Camera & Compatibility ---
        ro.hardware.camera=v4l2
        ro.opengles.version=196610
        ro.vndk.lite=true

        # --- OTA Updates ---
        waydroid.system_ota=https://ota.waydro.id/system/lineage/waydroid_x86_64/GAPPS.json
        waydroid.vendor_ota=https://ota.waydro.id/vendor/waydroid_x86_64/MAINLINE.json
        waydroid.tools_version=1.5.4

        # Disables multisample anti-aliasing
        debug.egl.hw_msaa=0

        # Force the 2D renderer to be as fast as possible
        ro.hwui.disable_scissor_opt=true

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
    wl-clipboard

    (pkgs.writeShellApplication {
      name = "waydroid-aid";
      runtimeInputs = with pkgs; [
        waydroid-nftables
        # waydroid-helper
        wl-clipboard
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
      # 1. Clean up
      waydroid session stop || true

      # 2. Local Performance Overrides (Bypasses your heavy global settings)
      export RADV_TEX_ANISO=0
      export AMD_TEX_ANISO=0
      export mesa_glthread=true
      export vblank_mode=0

      # 3. Set Android Properties
      waydroid prop set persist.waydroid.width 1280
      waydroid prop set persist.waydroid.height 720
      # 240 or 160
      waydroid prop set persist.waydroid.dpi 160

      # 4. Start Weston
      # We use --backend=wayland-backend.so to force it to connect to your desktop
      ${pkgs.weston}/bin/weston -Swayland-waydroid \
        --backend=wayland-backend.so \
        --width=1280 --height=720 \
        --fullscreen \
        --shell="kiosk-shell.so" &
      WESTON_PID=$!

      # Wait for socket with a timeout so it doesn't hang forever
      for i in {1..20}; do
        [ -S "$XDG_RUNTIME_DIR/wayland-waydroid" ] && break
        echo "Waiting for Weston... $i"
        sleep 0.5
      done

      # 5. Start Android
      export WAYLAND_DISPLAY=wayland-waydroid
      waydroid session start &

      # Wait for Android to be ready
      until waydroid status | grep -q "RUNNING"; do
        sleep 2
      done

      # Small extra sleep to let the GPU drivers 'settle'
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
