# ---- docs.nix ---- #
{ ... }: {
  imports = [ ./configuration.nix ./nixos.nix ./radeon.nix ./systemd.nix ];
}
