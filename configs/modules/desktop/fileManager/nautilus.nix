{ pkgs, lib, config, ... }:
let
  nautEnv = pkgs.buildEnv {
    name = "nautilus-env";
    paths = with pkgs; [ nautilus nautilus-python nautilus-open-any-terminal ];
  };
in {
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  environment = {
    systemPackages =
      [ nautEnv pkgs.gvfs pkgs.dconf pkgs.xdg-desktop-portal pkgs.file-roller ];
    pathsToLink = [ "/share/nautilus-python/extensions" ];
    sessionVariables = {
      FILE_MANAGER = "nautilus";
      NAUTILUS_EXTENSION_DIR =
        lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
    };
  };
}
