{ settings, pkgs, ... }: {
  # https://albertlauncher.github.io/gettingstarted/
  environment.systemPackages = with pkgs; [ albert ];
}
