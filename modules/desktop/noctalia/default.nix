{
  settings,
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.noctalia.nixosModules.default
    ./colors.nix
    ./plugins.nix
    ./appLauncher.nix
    ./audio.nix
    ./bar.nix
    ./battery.nix
    ./brightness.nix
    ./calendar.nix
    ./colorSchemes.nix
    ./controlCenter.nix
    ./desktopWidgets.nix
    ./dock.nix
    ./general.nix
    ./hooks.nix
    ./location.nix
    ./network.nix
    ./notifications.nix
    ./osd.nix
    ./systemMonitor.nix
    ./templates.nix
    ./ui.nix
    ./wallpaper.nix
  ];
  environment.systemPackages = with pkgs; [
    # Noctalia Shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Noctalia Shell screenshot plugin need this package
    hyprshot

  ];
}
