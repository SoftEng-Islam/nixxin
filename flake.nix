{
  description = "NIXXIN Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixGL.url = "github:nix-community/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    nixGL.inputs.flake-utils.follows = "flake-utils";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # nixpkgs-waydroid.url = "github:NixOS/nixpkgs/pull/455257/head";

    # ashell.url = "github:MalpenZibo/ashell";
    # ashell.flake = true;

    yt-dlp-src.url = "path:./pkgs/yt-dlp";
    clvk-pkg.url = "path:./pkgs/clvk";

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # illogical-impulse.url = "github:xBLACKICEx/end-4-dots-hyprland-nixos";
    # illogical-impulse.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      # _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      # settings = _SETTINGS.profile;
      # pkgs = nixpkgs.legacyPackages.${settings.system.architecture};

      # 1. Import with empty pkgs just to read static system config
      _bootstrap = import (./. + "/_settings.nix") { pkgs = { }; };
      arch = _bootstrap.profile.system.architecture;
      # 2. Define pkgs using the extracted architecture
      pkgs = nixpkgs.legacyPackages.${arch};
      # 3. Import settings again with real pkgs for full usage
      _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      settings = _SETTINGS.profile;

    in {
      # NixOS configuration entrypoint.
      # sudo nixos-rebuild switch --flake .#YourHostname
      nixosConfigurations = {
        "${settings.system.hostName}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit inputs;
            inherit _SETTINGS;
            inherit settings;
          };
          modules = [
            # inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            (./. + _SETTINGS.path + "/configuration.nix")
          ];
        };
      };
    };
}
