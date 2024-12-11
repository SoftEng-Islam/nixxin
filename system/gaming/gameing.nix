{ pkgs, ... }: {
  # imports = [ ./aagl.nix ./lutris.nix ./steam.nix ];
  environment.systemPackages = with pkgs;
    [
      zeroad # Free, open-source game of ancient warfare
      # protonup
      # retroarch # Multi-platform emulator frontend for libretro cores
      # retroarch-assets
      # retroarch-joypad-autoconfig
    ];
}
