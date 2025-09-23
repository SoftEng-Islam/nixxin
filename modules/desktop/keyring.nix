{ settings, lib, inputs, pkgs, ... }:
lib.mkIf (settings.modules.desktop.keyring.enable or true) {
  security.pam.services.${settings.user.username} = { enable = true; };

  # Gnome polkit and keyring are used for hyprland sessions
  services.gnome.gnome-keyring.enable = true; # User's credentials manager
  security.pam.services.greetd.enableGnomeKeyring = true;

  # -----------------------------------
  # hyprpolkitagent
  # -----------------------------------
  security.polkit.enable = true;
  security.polkit.package = pkgs.polkit;
  systemd.services.polkit = { serviceConfig.NoNewPrivileges = false; };

  environment.systemPackages = with pkgs; [
    linux-pam # Pluggable Authentication Modules, a flexible mechanism for authenticating user

    # -----------------------------------
    # hyprpolkitagent
    # -----------------------------------
    inputs.hyprpolkitagent.packages."${pkgs.system}".hyprpolkitagent
    # inputs.hyprutils
    # inputs.hyprland-qt-support
    # hyprpolkitagent # Polkit authentication agent written in QT/QML
    polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  ];
}
