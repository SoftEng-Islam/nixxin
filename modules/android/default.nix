{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = lib.optionals (settings.modules.android.enable or false) [
    ./android-studio.nix
    ./scrcpy.nix
    ./waydroid.nix
  ];

  config = mkIf (settings.modules.android.enable or false) {
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [
      libusb1

      # Display and control Android devices over USB or TCP/IP
      android-tools

      # Reverse tethering over ADB for Android.
      gnirehtet

      # Implementation of Microsoft's Media Transfer Protocol.
      libmtp

      # FUSE Filesystem providing access to MTP devices
      mtpfs

      # Android's repo management tool
      git-repo
    ];
  };
  # Adds the current user to the ADB users group.
  # users.users.${settings.user.username}.extraGroups = [ "adbusers" ];
}
