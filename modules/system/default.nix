# ---- docs.nix ---- #
{ pkgs, ... }: {
  imports = [
    ./brightness_control.nix

    ./configuration.nix

    ./nixos.nix

    ./opengl.nix

    #  Optional If using Radeon drivers
    ./radeon.nix

    ./ROCM.nix

    ./systemd.nix
  ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
  ];
}
