{ pkgs, ... }: {
  imports = [ ./aagl.nix ./lutris.nix ./steam.nix ];
  environment.systemPackages = with pkgs; [
    nethack
    zeroad
    steam
    steam-run # Run commands in the same FHS environment that is used for Steam
    protonup
    retroarch
    retroarch-assets
    retroarch-joypad-autoconfig
  ];
}
