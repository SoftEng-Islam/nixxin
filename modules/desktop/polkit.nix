{ settings, inputs, lib, pkgs, ... }:
lib.mkIf (settings.modules.desktop.polkit.enable or true) {

  # -----------------------------------
  # hyprpolkitagent
  # -----------------------------------
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # -----------------------------------
    # hyprpolkitagent
    # -----------------------------------
    inputs.hyprpolkitagent.packages."${pkgs.stdenv.hostPlatform.system}".hyprpolkitagent
    # inputs.hyprutils
    # inputs.hyprland-qt-support
    # hyprpolkitagent # Polkit authentication agent written in QT/QML
    polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  ];

}
