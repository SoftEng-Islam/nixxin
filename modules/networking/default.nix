{ pkgs, ... }: {
  imports = [
    ./networking.nix
    ./dnsmasq.nix
    # ./rtw.nix
    ./RTL8188EUS.nix
  ];
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  environment.variables = {
    #? What is GIO_EXTRA_MODULES?
    #* It’s an environment variable used by GIO, a core part of the GLib/GTK stack.
    #>> GIO provides things like:
    #>> File system abstraction (opening FTP, HTTP, Google Drive, etc.)
    #>> Network file access
    #>> GVfs (GNOME Virtual file system)
    #>> Proxy support
    #>> TLS support
    # GIO_EXTRA_MODULES = with pkgs; [ "${glib-networking}/lib/gio/modules" ];
    #! error: The option `environment.variables.GIO_EXTRA_MODULES' is defined multiple times while it's expected to be unique.
  };
}
