{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      icon-library # Symbolic icons for your apps
    ];
}
