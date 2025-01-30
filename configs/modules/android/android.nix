{ pkgs, ... }: {
  programs.adb.enable = true;
  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    scrcpy # Display and control Android devices over USB or TCP/IP
    android-tools
    # sdkmanager
    # gradle
    # android-studio
    # androidsdk
    jdk
  ];
}
