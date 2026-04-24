{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.desktop.file_manager.nemo) {
  home-manager.users.${settings.user.username} = {
    home = {
      file = {
        ".local/share/nemo/actions/aunpack.nemo_action".text = ''
          [Nemo Action]
          Name=Extract here
          Comment=Extract the selected archive(s) using aunpack
          Exec=${pkgs.atool}/bin/aunpack -X %P %F
          Icon=package-x-generic
          Selection=Any
          Extensions=zip;tar;gz;bz2;7z;rar;
          Quote=double
        '';
      };
    };
    dconf.settings = {
      "org/nemo/preferences" = {
        click-double-parent-folder = true;
        click-policy = "single";
        show-hidden-files = true;
        size-prefixes = "base-2";
        thumbnail-limit = "68719476735";
      };
    };
  };

  services.desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
    nemo
    nemo-seahorse
  ];

  environment.systemPackages = with pkgs; [
    # File browser for Cinnamon
    nemo
    nemo-emblems
    nemo-fileroller
    nemo-preview
    nemo-python
    nemo-qml-plugin-dbus

    (nemo-with-extensions.override {
      extensions = [ nemo-seahorse ];
    })
  ];
}
