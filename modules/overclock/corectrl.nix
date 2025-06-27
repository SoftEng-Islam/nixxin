{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.corectrl.enable or false) {
  # Control your computer hardware via application profiles
  environment.systemPackages = with pkgs; [ corectrl ];

  # corectrl to overclock your CPU APU GPU
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
    gpuOverclock.ppfeaturemask = "0xfff7ffff";
  };
}
