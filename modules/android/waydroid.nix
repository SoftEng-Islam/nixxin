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

  services.geoclue2.enable = false;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  # environment.sessionVariables.WAYDROID_BRIDGE_IP = "192.168.241.1";

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
    waydroid-nftables
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
