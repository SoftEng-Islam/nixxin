{
  description = "NIXXIN Configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:nix-community/nixGL";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    yt-dlp-src.url = "path:./pkgs/yt-dlp";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixgl, ... }@inputs:
    let
      settingsFile = import ./_settings.nix;
      settings = settingsFile.profile;
      system = settings.system.architecture;
    in {
      nixosConfigurations = {
        "${settings.system.hostName}" = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = { inherit self inputs settings; };

          modules = [
            # Apply nixpkgs config + overlays HERE (correct place)
            ({ ... }: {
              nixpkgs = {
                overlays = [ nixgl.overlay ];
                config.allowUnfree = true;
              };
            })

            inputs.home-manager.nixosModules.home-manager

            (./. + settingsFile.path + "/configuration.nix")
          ];
        };
      };
    };
}
