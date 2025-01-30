{ settings, pkgs, ... }: {
  imports =
    [ ./dircolors.nix ./files.nix ./nautilus.nix ./nemo.nix ./thunar.nix ];
  # services.gvfs.enable = true; # Mount, trash, and other functionalities
  # services.gvfs.package = pkgs.gnome.gvfs;
  services.tumbler.enable = true; # Thumbnail support for images
  home-manager.users.${settings.users.selected.username} = { };
}
