{ lib, settings, pkgs, ... }: {
  imports = [ ./albert.nix ]
    ++ lib.optional settings.system.features.apps_launcher.albert ./albert.nix
    ++ lib.optional settings.system.features.apps_launcher.ulauncher
    ./ulauncher.nix;
}
