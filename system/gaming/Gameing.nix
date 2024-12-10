{ pkgs, ... }: {
  gamemode.enable = true;
  steam.enable = true;
  steam.gamescopeSession.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    zeroad
    steam
    steam-run # Run commands in the same FHS environment that is used for Steam
    # protonup
  ];
}
