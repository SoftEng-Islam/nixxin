# ---- docs.nix ---- #
{ pkgs, ... }: {
  imports = [ ./configuration.nix ./nixos.nix ./radeon.nix ./systemd.nix ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
  ];
}
