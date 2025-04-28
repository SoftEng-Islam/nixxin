{
  description = "NIXXIN DOTFILES.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # impermanence.url = "github:nix-community/impermanence";

    ignis.url = "git+https://github.com/linkfrg/ignis?submodules=1";
    ignis.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/oxalica/rust-overlay
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    # aagl.inputs.nixpkgs.follows = "nixpkgs";

    # nix-ld.url = "github:Mic92/nix-ld";
    # nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # impurity.url = "github:outfoxxed/impurity.nix";

    # A Material You Color Generation Tool
    # matugen.url = "github:/InioX/Matugen";

    # anytype.url = "github:/anyproto/anytype-ts";
    # anytype.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      settings = _SETTINGS.profile;
      pkgs = import nixpkgs { system = settings.system.architecture; };
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
