{
  description = "NIXXIN DOTFILES.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ashell = {
      # url = "path:/home/softeng/nixxin/modules/widgets/ashell/main";
      url = "github:MalpenZibo/ashell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis.url = "git+https://github.com/linkfrg/ignis?submodules=1";
    ignis.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/oxalica/rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    # aagl.inputs.nixpkgs.follows = "nixpkgs";

    # nix-ld.url = "github:Mic92/nix-ld";
    # nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # impurity.url = "github:outfoxxed/impurity.nix";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # A Material You Color Generation Tool
    # matugen.url = "github:/InioX/Matugen";

    # anytype.url = "github:/anyproto/anytype-ts";
    # anytype.inputs.nixpkgs.follows = "nixpkgs";

    # ---- Terminals ---- #
    smart-splits-nvim.url = "github:mrjones2014/smart-splits.nvim";
    smart-splits-nvim.flake = false;

    kitty-scrollback-nvim.url = "github:mikesmithgh/kitty-scrollback.nvim";
    kitty-scrollback-nvim.flake = false;

    kitty-smart-scroll.url = "github:yurikhan/kitty-smart-scroll";
    kitty-smart-scroll.flake = false;

    kitty-smart-tab.url = "github:yurikhan/kitty-smart-tab";
    kitty-smart-tab.flake = false;

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
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
