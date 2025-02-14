{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.corectrl.enable) {
  environment.systemPackages = with pkgs;
    [
      corectrl # Control your computer hardware via application profiles
    ];
  programs.corectrl = {
    # corectrl to overclock your CPU APU GPU
    enable = true;
    gpuOverclock.enable = true;
    gpuOverclock.ppfeaturemask = "0xfff7ffff";
  };
}
