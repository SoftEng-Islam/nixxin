# keyring.nix
# Handles credential/key storage for apps (GNOME Keyring for now, but could be extended later for KeePassXC or pass).
{
  settings,
  lib,
  inputs,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.desktop.keyring.enable or false) {
  # Make sure user and display manager PAM can unlock the keyring
  security.pam.services.${settings.user.username} = {
    enable = true;
  };
  security.pam.services.greetd.enableGnomeKeyring = true;
  # Don't enable gnome-keyring PAM helper for the SDDM greeter; the greeter
  # runs before a per-user systemd session exists and gkr-pam can fail
  # with "unable to locate daemon control file". Let the user's PAM
  # session handle unlocking the keyring instead.
  security.pam.services.sddm.enableGnomeKeyring = false;

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
