{ settings, pkgs, ... }: {
  imports = [
    ./albert.nix
    (if settings.system.features.apps_launcher.albert then
      ./albert.nix
    else
      null)
    (if settings.system.features.apps_launcher.ulauncher then
      ./ulauncher.nix
    else
      null)
  ];
}
