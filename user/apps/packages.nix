{ pkgs, config, lib, ... }: {
  options.packages = with lib;
    let
      packagesType = mkOption {
        type = types.listOf types.package;
        default = [ ];
      };
    in {
      linux = packagesType;
      darwin = packagesType;
      cli = packagesType;
    };

  config = {
    home.packages = with config.packages;
      if pkgs.stdenv.isDarwin then cli ++ darwin else cli ++ linux;
  };

  packages = with pkgs; {
    linux = [
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      spotify
      # gnome-secrets
      fragments
      figma-linux
      # yabridge
      # yabridgectl
      # wine-staging
      nodejs
    ];
    cli = [ bat eza fd ripgrep fzf lazydocker lazygit btop ];
  };
}
