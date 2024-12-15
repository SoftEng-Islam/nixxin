{ pkgs, ... }: {
  # imports = [  ./lutris.nix ./steam.nix ];
  # hardware.xpadneo.enable = true; # Whether to enable the xpadneo driver for Xbox One wireless controllers.

  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 20; }; };
    };
  };
  environment.systemPackages = with pkgs; [
    gamemode # Optimise Linux system performance on demand
    zeroad # Free, open-source game of ancient warfare
    # protonup
    # retroarch # Multi-platform emulator frontend for libretro cores
    # retroarch-assets
    # retroarch-joypad-autoconfig
  ];
}
