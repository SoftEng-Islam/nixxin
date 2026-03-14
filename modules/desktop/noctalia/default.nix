{
  settings,
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  noctaliaShellPkg =
    inputs.noctalia.packages.${system}.default
      or inputs.noctalia.packages.${system}."noctalia-shell";
in
{
  imports = [
    inputs.noctalia.nixosModules.default
    ./appLauncher.nix
    ./audio.nix
    ./bar.nix
    ./battery.nix
    ./brightness.nix
    ./calendar.nix
    ./colors.nix
    ./colorSchemes.nix
    ./controlCenter.nix
    ./desktopWidgets.nix
    ./dock.nix
    ./general.nix
    ./hooks.nix
    ./location.nix
    ./lockScreen.nix
    ./network.nix
    ./notifications.nix
    ./osd.nix
    ./plugins.nix
    ./systemMonitor.nix
    ./templates.nix
    ./ui.nix
    ./wallpaper.nix
  ];
  environment.systemPackages = with pkgs; [
    # Noctalia Shell
    noctaliaShellPkg

    # Noctalia Shell screenshot plugin need this package
    hyprshot

  ];
}
