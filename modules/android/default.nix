{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  imports = lib.optionals (settings.modules.android.enable or false) [
    ./android-studio.nix
    ./scrcpy.nix
    ./waydroid.nix
    ./waydroid-media.nix
  ];
  services.udev.packages = [ pkgs.heimdall ]; # USB permissions for download mode
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", TAG+="uaccess"
  '';

  environment.systemPackages = with pkgs; [
    libusb1

    # Display and control Android devices over USB or TCP/IP
    android-tools

    # Reverse tethering over ADB for Android.
    gnirehtet

    # Implementation of Microsoft's Media Transfer Protocol.
    libmtp

    # Android's repo management tool
    git-repo

    heimdall
    heimdall-gui # optional GUI

    samloader-rs
  ];
  # Adds the current user to the ADB users group.
  # users.users.${settings.user.username}.extraGroups = [ "adbusers" ];
}
