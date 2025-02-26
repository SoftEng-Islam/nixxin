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
        # nix-prefetch-git https://github.com/MalpenZibo/ashell
        sha256 =
          "1fvk3yl5z1sirm6ngi45j59r5b0raa5xszjbh23bkc389sbkzxiv"; # Replace with the correct hash
      }) { }))
      # inputs.ashell.defaultPackage.x86_64-linux
    ];
}
