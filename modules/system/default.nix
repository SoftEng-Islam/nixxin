# ---- docs.nix ---- #
{ pkgs, ... }: {
  imports = [
    ./configuration.nix
    ./nixos.nix

    ./opengl.nix

    #  Optional If using Radeon drivers
    ./radeon.nix

    ./systemd.nix
  ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
  ];
}
