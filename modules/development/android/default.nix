{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.development.android.enable) {
  environment.systemPackages = with pkgs; [
    jdk # Open-source Java Development Kit
    sdkmanager # Drop-in replacement for sdkmanager from the Android SDK written in Python
    gradle # Enterprise-grade build system
    dart
    flutter
    (androidenv.composeAndroidPackages {
      toolsVersion = "26.1.1";
      platformToolsVersion = "34.0.4";
      buildToolsVersions = [ "30.0.3" ];
      includeEmulator = false;
      platformVersions = [ "34" ];
      abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
    })
  ];
}
