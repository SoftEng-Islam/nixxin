{ settings, pkgs, lib, ... }: {
  imports = lib.optionals (settings.modules.overclock.enable or false) [
    ./corectrl.nix
    ./lactd.nix
  ];
  programs.tuxclocker.enable = true;
  programs.tuxclocker.useUnfree = true;

  environment.systemPackages = with pkgs; [ tuxclocker ];
}
