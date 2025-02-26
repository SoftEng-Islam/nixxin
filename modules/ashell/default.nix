{ settings, lib, inputs, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.ashell.enable) {
  # home-manager.users.${settings.user.username} = {
  #   systemd.user.services = {
  #     ashell = {
  #       Unit = {
  #         Description = "ashell status bar";
  #         PartOf = [ "hyprland-session.target" ];
  #       };

  #       Service = {
  #         ExecStart = "${inputs.ashell.defaultPackage.x86_64-linux}/bin/ashell";
  #         Restart = "on-failure";
  #       };

  #       Install.WantedBy = [ "hyprland-session.target" ];
  #     };
  #   };
  # };
  environment.systemPackages = with pkgs;
    [
      (import (pkgs.callPackage (pkgs.fetchFromGitHub {
        owner = "MalpenZibo";
        repo = "ashell";
        rev = "refs/heads/main"; # Or specify the branch/tag you need
        sha256 =
          "4a1c9e0c788e0e1c4aac9522d39a44cce7c24ef2"; # Replace with the correct hash
      }) { }).defaultPackage.x86_64-linux)
      # inputs.ashell.defaultPackage.x86_64-linux
    ];
}
