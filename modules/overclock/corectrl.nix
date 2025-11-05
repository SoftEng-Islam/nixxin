{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.overclock.corectrl.enable or false) {
  # Control your computer hardware via application profiles
  environment.systemPackages = with pkgs; [ corectrl ];

  # corectrl to overclock your CPU APU GPU
  programs.corectrl.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  # "0xfffd7fff" or "0xffffffff"
  hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
}
