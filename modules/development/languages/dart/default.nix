{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ dart flutter ];
}
