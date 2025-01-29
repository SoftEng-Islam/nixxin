{ settings, pkgs, ... }: {
  imports = [ ];
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
    stateVersion = settings.systemStateVersion;
  };
}
