{
  pkgs,
  config,
  ...
}: {
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = "${config.home.homeDirectory}/nix-config";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
