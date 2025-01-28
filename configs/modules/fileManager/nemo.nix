{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nemo
    nemo-with-extensions
    nemo-python
    nemo-qml-plugin-dbus
    nemo-fileroller
  ];
}
