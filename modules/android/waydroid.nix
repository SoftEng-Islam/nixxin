{ settings, pkgs, ... }:
let
  waydroid-ui = pkgs.writeShellScriptBin "waydroid-ui" ''
    export WAYLAND_DISPLAY=wayland-0
    ${pkgs.weston}/bin/weston -Swayland-1 --width=600 --height=1000 --shell="kiosk-shell.so" &
    WESTON_PID=$!

    export WAYLAND_DISPLAY=wayland-1
    ${pkgs.waydroid}/bin/waydroid show-full-ui &

    wait $WESTON_PID
    waydroid session stop
  '';
  waydroidGbinderConf = pkgs.writeText "waydroid.conf" ''
    [Protocol]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl

    [ServiceManager]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl
  '';
in {
  # Additional configurations, notes and post-installation steps
  # in https://nixos.wiki/wiki/WayDroid or https://wiki.nixos.org/wiki/Waydroid
  virtualisation = {
    waydroid.enable = true;
    # a daemon that manages containers. Users in the “lxd” group can interact with the daemon (e.g. to start or stop containers) using the lxc command line tool, among others.
    lxd.enable = true;
    # a daemon that manages containers. Users in the “lxd” group can interact with the daemon (e.g. to start or stop containers) using the lxc command line tool, among others.
    lxc.enable = true;
    lxc.unprivilegedContainers = true;
  };

  # ---- Installation ---- #
  # After you have downloaded both system and vendor image, extract them.
  # Now move both vendor.img and system.img to `/etc/waydroid-extra/images/`
  # Lastly, in your terminal enter this command `sudo waydroid init -f`
  # https://sourceforge.net/projects/waydroid/files/images/
  # aria2c https://sourceforge.net/projects/waydroid/files/images/vendor/waydroid_x86_64/lineage-18.1-20250201-MAINLINE-waydroid_x86_64-vendor.zip/download
  # aria2c https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-18.1-20250201-GAPPS-waydroid_x86_64-system.zip/download

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
  #!! Configuration is imperative
  # Optionally update image
  #?? sudo waydroid upgrade

  # Install image
  #?? sudo waydroid init --system_type <FOSS|GAPPS>

  # Optional helper script
  # https://github.com/casualsnek/waydroid_script
  #?? git clone https://github.com/casualsnek/waydroid_script.git
  #?? cd waydroid_script
  #?? python -m venv .venv
  #?? source .venv/bin/activate.fish
  #?? pip install -r requirements.txt
  #?? sudo python main.py install microg
  #?? sudo python main.py install libndk
  #?? sudo python main.py hack hidestatusbar

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
  #?? sudo sed -i 's|/dev/dri/card0|/dev/dri/card1|' /var/lib/waydroid/lxc/waydroid/config_nodes
  #?? sudo sed -i 's|/dev/dri/renderD128|/dev/dri/renderD129|' /var/lib/waydroid/lxc/waydroid/config_nodes

  # Some games like Arknights do not use the proper storage mechanism and need insecure permissions
  # https://github.com/casualsnek/waydroid_script?tab=readme-ov-file#granting-full-permission-for-apps-data-hack
  #?? sudo waydroid shell
  #?? chmod 777 -R /sdcard/Android
  #?? chmod 777 -R /data/media/0/Android
  #?? chmod 777 -R /sdcard/Android/data
  #?? chmod 777 -R /data/media/0/Android/obb
  #?? chmod 777 -R /mnt/*/*/*/*/Android/data
  #?? chmod 777 -R /mnt/*/*/*/*/Android/obb

  # Optionally, disable unnecessary desktop files
  #?? sed -i 's|(\[Desktop Entry\])|$1\nNoDisplay=true|' ~/.local/share/applications/waydroid.*.desktop

  fileSystems."/dev/binderfs" = {
    device = "none";
    fsType = "binder";
    options = [ "defaults" ];
  };

  environment.etc."gbinder.d/waydroid.conf".source = waydroidGbinderConf;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  systemd.services.waydroid-container = {
    description = "Waydroid Container";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.waydroid}/bin/waydroid -w container start";
      ExecStop = "${pkgs.waydroid}/bin/waydroid container stop";
      ExecStopPost = "${pkgs.waydroid}/bin/waydroid session stop";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/misc 0755 root root -" # for dnsmasq.leases
  ];
  environment.systemPackages = with pkgs; [
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    wl-clipboard
    waydroid-ui
    weston
    (writeShellScriptBin "waydroid-choose-gpu" ''
      lspci="$(lspci -nn | grep '\[03')" # https://pci-ids.ucw.cz/read/PD/03

      echo -e "Please enter the GPU number you want to pass to WayDroid:\n"
      gpus=()
      i=0
      while IFS= read lspci; do
        gpus+=("$lspci")
        echo "  $((++i)). $lspci"
      done < <(echo "$lspci")
      echo ""
      while [ -z "$gpuchoice" ]; do
        read -erp ">> Number of GPU to pass to WayDroid (1-''${#gpus[@]}): " ans
        if [[ "$ans" =~ [0-9]+ && $ans -ge 1 && $ans -le ''${#gpus[@]} ]]; then
          gpuchoice="''${gpus[$((ans-1))]%% *}" # e.g. "26:00.0"
        fi
      done
      echo ""
      echo "Confirm that these belong to your GPU:"
      echo ""
      ls -l /dev/dri/by-path/ | grep -i $gpuchoice
      echo ""
      card=$(ls -l /dev/dri/by-path/ | grep -i $gpuchoice | grep -o "card[0-9]")
      rendernode=$(ls -l /dev/dri/by-path/ | grep -i $gpuchoice | grep -o "renderD[1-9][1-9][1-9]")

      echo /dev/dri/$card
      echo /dev/dri/$rendernode

      cp /var/lib/waydroid/lxc/waydroid/config_nodes /var/lib/waydroid/lxc/waydroid/config_nodes.bak
      #lxc.mount.entry = /dev/dri dev/dri none bind,create=dir,optional 0 0
      sed -i '/dri/d' /var/lib/waydroid/lxc/waydroid/config_nodes
      echo "lxc.mount.entry = /dev/dri/$card dev/dri/card0 none bind,create=file,optional 0 0" >> /var/lib/waydroid/lxc/waydroid/config_nodes
      echo "lxc.mount.entry = /dev/dri/$rendernode dev/dri/renderD128 none bind,create=file,optional 0 0" >> /var/lib/waydroid/lxc/waydroid/config_nodes
    '')
  ];
}
