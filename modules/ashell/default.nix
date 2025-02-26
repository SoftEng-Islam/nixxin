{ settings, lib, config, inputs, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {

  # imports = optionals (settings.modules.ashell.enable) [ ./ashell.nix ];

  config = mkIf (settings.modules.ashell.enable) {
    home-manager.users.${settings.user.username} = {
      systemd.user.services.ashell = {
        Unit = {
          Description = "Ashell shell";
          PartOf = [ "hyprland-session.target" ];
          After = [ "hyprland-session.target" ];
        };
        Install = { WantedBy = [ "hyprland-session.target" ]; };
        Service = {
          ExecStart =
            "${inputs.ashell.defaultPackage.${pkgs.system}}/bin/ashell";
          Restart = "on-failure";
          Type = "simple";
        };
      };

      # Ashell Configs
      home.file.".config/ashell.yml".source = ./ashell.yml;

    };

    environment.systemPackages = with pkgs;
      [
        inputs.ashell.defaultPackage.${pkgs.system}

        # (import (pkgs.callPackage (pkgs.fetchFromGitHub {
        #   owner = "MalpenZibo";
        #   repo = "ashell";
        #   rev = "refs/heads/main"; # Or specify the branch/tag you need
        #   # nix-prefetch-git https://github.com/MalpenZibo/ashell
        #   sha256 =
        #     "1fvk3yl5z1sirm6ngi45j59r5b0raa5xszjbh23bkc389sbkzxiv"; # Replace with the correct hash
        # }) { }))
      ];
  };
}
