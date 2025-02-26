{ settings, lib, config, inputs, pkgs, ... }:
let
  inherit (lib) optionals mkIf;

  ashellSrc = pkgs.fetchFromGitHub {
    owner = "MalpenZibo";
    repo = "ashell";
    rev = "4a1c9e0c788e0e1c4aac9522d39a44cce7c24ef2"; # From nix-prefetch-git
    sha256 = "1fvk3yl5z1sirm6ngi45j59r5b0raa5xszjbh23bkc389sbkzxiv";
  };
  ashell = import ashellSrc { inherit pkgs; }; # Import properly

in {

  # imports = optionals (settings.modules.ashell.enable) [ ./ashell.nix ];

  config = mkIf (settings.modules.ashell.enable) {
    home-manager.users.${settings.user.username} = {
      # systemd.user.services.ashell = {
      #   Unit = {
      #     Description = "Ashell shell";
      #     PartOf = [ "hyprland-session.target" ];
      #     After = [ "hyprland-session.target" ];
      #   };
      #   Install = { WantedBy = [ "hyprland-session.target" ]; };
      #   Service = {
      #     ExecStart =
      #       "${inputs.ashell.defaultPackage.${pkgs.system}}/bin/ashell";
      #     Restart = "on-failure";
      #     Type = "simple";
      #   };
      # };

      # Ashell Configs
      home.file.".config/ashell.yml".source = ./ashell.yml;

    };

    environment.systemPackages = with pkgs;
      [
        ashell.defaultPackage.${pkgs.system}
        # inputs.ashell
        # (import (pkgs.callPackage (pkgs.fetchFromGitHub {
        #   owner = "MalpenZibo";
        #   repo = "ashell";
        #   rev = "refs/heads/main"; # Or specify the branch/tag you need
        #   # nix-prefetch-git https://github.com/MalpenZibo/ashell
        #   sha256 =
        #     "1fvk3yl5z1sirm6ngi45j59r5b0raa5xszjbh23bkc389sbkzxiv"; # Replace with the correct hash
        # }) { }).packages.${settings.system.architecture})
      ];
  };
}
