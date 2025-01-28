{ settings, pkgs, ... }: {
  imports = [ ];
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
    stateVersion = settings.systemStateVersion;
  };
}
