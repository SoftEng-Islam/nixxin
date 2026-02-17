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
    lxc.unprivilegedContainers = true;

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
  systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];
  # Keeping the container running in the background makes Waydroid launch much faster when you click your UI script because the Android "hardware" is already warmed up.
  # systemd.services.waydroid-container.wantedBy = [ "multi-user.target" ];

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

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

  # security.sudo.extraRules = [
  #   {
  #     users = [ "${username}" ];
  #     commands = [
  #       {
  #         command = "${pkgs.waydroid-nftables}/bin/waydroid";
  #         options = [ "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];

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

  # ---- Installation & Useful Inforamtion ---- #
  # 1- After you have downloaded both "system" and "vendor" image, extract them.
  # 2- Now move both "vendor.img" and "system.img" to `/etc/waydroid-extra/images/`
  # -- sudo mkdir -p /etc/waydroid-extra/images/
  # -- sudo mv system.img vendor.img /etc/waydroid-extra/images/
  # 3- Lastly, in your terminal enter this command `sudo waydroid init -f`
  # https://sourceforge.net/projects/waydroid/files/images/
  # https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_x86_64/
  # wget https://netix.dl.sourceforge.net/project/waydroid/images/vendor/waydroid_x86_64/lineage-20.0-20250809-MAINLINE-waydroid_x86_64-vendor.zip?viasf=1
  # wget https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-18.1-20250201-GAPPS-waydroid_x86_64-system.zip/download

  # Additional configurations and notes:
  # 1. You may need to adjust settings if you have an NVIDIA card or an RX 6800 series:
  #    - Edit /var/lib/waydroid/waydroid_base.prop and set:
  #      ro.hardware.gralloc=default
  #      ro.hardware.egl=swiftshader
  # 2. For Linux kernel 5.18 and later, set sys.use_memfd=true in waydroid_base.prop
  # 3. Add wl-clipboard to system packages for clipboard support:
  #    environment.systemPackages = with pkgs; [ wl-clipboard ];

  # Post-installation steps:
  # - Run 'sudo waydroid init' to fetch WayDroid images.
  # - You can add "-s GAPPS -f" to the init command for GApps support.
  # - Start the WayDroid container with 'sudo systemctl start waydroid-container'.
  # - Begin a WayDroid session with 'waydroid session start'.

  # Fixing Waydroid Binder Issues on NixOS
  # Step 1: Manually Mount binderfs
  # sudo mkdir -p /dev/binderfs
  # sudo mount -t binder none /dev/binderfs
  # ls /dev/binderfs/
  # It should show:
  # binder  hwbinder  vndbinder

  # ---- Start the container ---- #
  # Start the Waydroid LXC container
  # $ sudo systemctl start waydroid-container
  #
  # You'll know it worked by checking the journal You should see "Started Waydroid Container".
  # $ sudo journalctl -u waydroid-container
  #
  # Start Waydroid session
  # You'll know it is finished when you see the message "Android with user 0 is ready".
  # $ waydroid session start

  # ------------------------------- #
  # ------------------------------- #

  # ---- General usage ---- #
  # Start Android UI
  # $ waydroid show-full-ui
  #
  # List Android apps
  # $ waydroid app list
  #
  # Start an Android app
  # $ waydroid app launch <application name>
  #
  # Install an Android app
  # $ waydroid app install </path/to/app.apk>
  #
  # Enter the LXC shell
  # $ sudo waydroid shell
  #
  # Overrides the full-ui width
  # $ waydroid prop set persist.waydroid.width 608

  # ------------------------------- #
  # ------------------------------- #

  # ---- Update Android ---- #
  # $ sudo waydroid upgrade

  # ------------------------------- #
  # ------------------------------- #

  # ---- GPU Adjustments ---- #
  # In case you have an NVIDIA card or an RX 6800 series, you'll need to disable GBM and mesa-drivers:
  # /var/lib/waydroid/waydroid_base.prop
  #- ro.hardware.gralloc=default
  #- ro.hardware.egl=swiftshader

  # ------------------------------- #
  # ------------------------------- #

  # ---- Linux 5.18+ ---- #
  # Linux 5.18 and later removed ashmem in favor of memfd, so you may need to tell Waydroid (1.2.1 and later) to use the new module:
  # /var/lib/waydroid/waydroid_base.prop
  #- sys.use_memfd=true

  # https://wiki.nixos.org/wiki/WayDroid
  # https://wiki.archlinux.org/title/Waydroid

  # Optionally update image
  # sudo waydroid upgrade

  # Install image
  #?? sudo waydroid init --system_type <FOSS|GAPPS>

  # Start session
  #?? waydroid session start &

  # Optionally certify with Google for the Play Store
  #?? sudo waydroid shell
  #?? ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"
  #?? https://www.google.com/android/uncertified

  # Enable windowed applications
  #?? waydroid prop set persist.waydroid.multi_windows true

  # Set window size
  #?? waydroid prop set persist.waydroid.width WIDTH
  #?? waydroid prop set persist.waydroid.height HEIGHT
  #?? sudo waydroid shell
  #?? wm size reset

  # Optionally, run waydroid on the same GPU as the compositor
  # https://wiki.archlinux.org/title/Waydroid#Graphical_Corruption_on_multi-gpu_systems
  # https://github.com/Quackdoc/waydroid-scripts/blob/main/waydroid-choose-gpu.sh

  #!! Rerun after each waydroid_script invocation
  #> sudo sed -i 's|/dev/dri/card0|/dev/dri/card1|' /var/lib/waydroid/lxc/waydroid/config_nodes
  #> sudo sed -i 's|/dev/dri/renderD128|/dev/dri/renderD128|' /var/lib/waydroid/lxc/waydroid/config_nodes

  # Some games like Arknights do not use the proper storage mechanism and need insecure permissions
  # https://github.com/casualsnek/waydroid_script?tab=readme-ov-file#granting-full-permission-for-apps-data-hack
  # sudo waydroid shell
  #> chmod 777 -R /sdcard/Android
  #> chmod 777 -R /data/media/0/Android
  #> chmod 777 -R /sdcard/Android/data
  #> chmod 777 -R /data/media/0/Android/obb
  #> chmod 777 -R /mnt/*/*/*/*/Android/data
  #> chmod 777 -R /mnt/*/*/*/*/Android/obb

  # Optionally, disable unnecessary desktop files
  # sed -i 's|(\[Desktop Entry\])|$1\nNoDisplay=true|' ~/.local/share/applications/waydroid.*.desktop
}
