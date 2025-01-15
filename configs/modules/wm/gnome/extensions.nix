{ settings, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.net-speed-simplified # A Net Speed extension With Loads of Customization. Fork of simplenetspeed
  ];

  # To list your enabled GNOME Shell extensions, you can use the gnome-extensions command-line tool, which provides various options for managing extensions.
  # gnome-extensions list --enabled
  home-manager.users.${settings.username}.dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "appindicatorsupport@rgcjonas.gmail.com"
        "pomodoro@arun.codito.in"
        "netspeedsimplified@prateekmedia.extension"
      ];
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      style-components = 3;
    };
  };
}

