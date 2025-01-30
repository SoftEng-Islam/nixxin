{ settings, pkgs, ... }: {
  imports = [
    ./albert.nix
    (if settings.system.features.apps_launcher then ./albert.nix else null)
    (if settings.system.features.apps_launcher then ./ulauncher.nix else null)
  ];
}
