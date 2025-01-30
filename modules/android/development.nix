{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    jdk # Open-source Java Development Kit
    sdkmanager # Drop-in replacement for sdkmanager from the Android SDK written in Python
    gradle # Enterprise-grade build system
  ];
}
