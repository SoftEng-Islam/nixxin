{ settings, pkgs, ... }: {
  services = {
    dbus.enable = true;
    dbus.packages = [ pkgs.dconf ];
    dbus.implementation = "broker";
  };
  environment.systemPackages = with pkgs; [
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker
    libdbusmenu # Library for passing menu structures across DBus
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
  ];
}
