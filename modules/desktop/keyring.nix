# keyring.nix
# Handles credential/key storage for apps (GNOME Keyring for now, but could be extended later for KeePassXC or pass).
{ settings, lib, inputs, pkgs, ... }:
lib.mkIf (settings.modules.desktop.keyring.enable or false) {
  # Make sure user and greetd PAM can unlock the keyring
  security.pam.services.${settings.user.username} = { enable = true; };
  security.pam.services.greetd.enableGnomeKeyring = true;

  # GNOME Keyring (default secret service provider)
  services.gnome.gnome-keyring.enable = true; # User's credentials manager

  environment.systemPackages = with pkgs; [
    # Tools to manage/view secrets if you want them
    seahorse # optional: GUI for managing secrets in gnome-keyring
    bitwarden-cli
    bitwarden-desktop
    keepassxc
  ];
}
