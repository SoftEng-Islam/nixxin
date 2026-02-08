{ settings, pkgs, lib, ... }: {
  imports = lib.optionals (settings.modules.overclock.enable or false) [
    ./corectrl.nix
    ./lactd.nix
  ];

  programs.tuxclocker.enable = false;
  programs.tuxclocker.useUnfree = true;
}
