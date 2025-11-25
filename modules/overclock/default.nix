{ settings, lib, ... }: {
  imports = lib.optionals (settings.modules.overclock.enable or false) [
    ./corectrl.nix
    ./lactd.nix
  ];
}
