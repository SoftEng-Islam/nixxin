{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.desktop.polkit.enable or false) (
  let
    system = pkgs.stdenv.hostPlatform.system;
    hyprpolkitagentPkg =
      inputs.hyprpolkitagent.packages.${system}.hyprpolkitagent
        or inputs.hyprpolkitagent.packages.${system}.default or pkgs.update.hyprpolkitagent
          or pkgs.hyprpolkitagent;
  in
  {
    # -----------------------------------
    # hyprpolkitagent
    # -----------------------------------
    security.polkit.enable = true;

    home-manager.users.${settings.user.username} = {
      services.hyprpolkitagent = {
        enable = true;
        package = hyprpolkitagentPkg;
      };
    };

    environment.systemPackages = with pkgs; [
      # -----------------------------------
      # hyprpolkitagent
      # -----------------------------------
      hyprpolkitagentPkg # Polkit authentication agent written in QT/QML
      polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    ];

  }
)
