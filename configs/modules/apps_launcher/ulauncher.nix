{ settings, pkgs, ... }: {
  # https://ulauncher.io/
  environment.systemPackages = with pkgs; [ ulauncher ];
}
