{
  # Set Gnome Settings and Shortcuts
  services = {
    gnome = {
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      gnome-settings-daemon.enable = true;
      localsearch.enable = true;
      tinysparql.enable = true;
    };
    xserver.desktopManager.gnome.extraGSettingsOverrides = ''
      # Define Custom Keybindings
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
    '';
  };
}
