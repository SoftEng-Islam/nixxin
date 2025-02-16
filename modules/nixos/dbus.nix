{ pkgs, ... }: {
  services = {
    dbus.enable = true;
    dbus.packages = [ pkgs.dconf ];
    dbus.implementation = "broker";
    accounts-daemon.enable = true;
    fwupd.enable = false;
    udisks2.enable = true;
  };

  # Hackity HACK for working D-Bus activation
  # systemd.user.services.dbus.environment.DISPLAY = ":0";

  environment.systemPackages = with pkgs; [
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker
    d-spy # D-Bus exploration tool
    libdbusmenu # Library for passing menu structures across DBus
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
  ];
}
