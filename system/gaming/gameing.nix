{ pkgs, ... }: {
  imports = [ ./aagl.nix ./lutris.nix ./steam.nix ];
  environment.systemPackages = with pkgs; [
    nethack # Rogue-like game
    zeroad # Free, open-source game of ancient warfare
    steam
    steam-run # Run commands in the same FHS environment that is used for Steam
    protonup
    retroarch # Multi-platform emulator frontend for libretro cores
    retroarch-assets
    retroarch-joypad-autoconfig
  ];
}
