{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ radeon-profile radeontools ];
}
