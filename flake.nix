{
  description = "Softeng Nixxin Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # third party nixpkgs|overlays|modules
    chaotic.url = "github:chaotic-cx/nyx";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";

    matcha.url = "git+https://codeberg.org/QuincePie/matcha";
    matcha.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url =
      "github:fufexan/nix-gaming?rev=1e435616e688c2b9125cd5282febcad3ab981d5e";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-wayland.url =
      "github:nix-community/nixpkgs-wayland?rev=52b72b12c456a5c0c87c40941ef79335e8d61104"; # master (03 sep 2024)
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

    android-nixpkgs.url =
      "github:tadfisher/android-nixpkgs?rev=e2aec559a903ee1d94fd9935b4d558803adaf5a4";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nixos-hardware.url =
      "github:NixOS/nixos-hardware?rev=672ac2ac86f7dff2f6f3406405bddecf960e0db6"; # master (22 nov 2024)

    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    swww.url = "github:LGFae/swww";
    # superfile.url = "github:yorukot/superfile";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lobster = {
      url = "github:justchokingaround/lobster";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scenefx.url =
      "github:wlrfx/scenefx?rev=7a7c35750239bd117931698b121a072f30bc1cbe";
    scenefx.inputs.nixpkgs.follows = "nixpkgs";
    wayfreeze.url =
      "github:Jappie3/wayfreeze?rev=37ef9e456c87601ed4e06f36f437f688083d61cf";
    wayfreeze.inputs.nixpkgs.follows = "nixpkgs";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    arkenfox.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url =
      "github:MarceColl/zen-browser-flake?rev=96dffb45b36141261e97a8f83438e4c88911fefa";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    ucodenix.url =
      "github:e-tho/ucodenix?rev=7d7586d3fcd07e147c0dba9291b2473e060c4c98";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay?rev=9822e0611d49ae70278ac20c9d7b68e4797b2fab";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      settings = import (./. + "/settings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = settings.system; };
    in {
      # NixOS configuration entrypoint.
      # 'nixos-rebuild switch --flake .#hostname
      nixosConfigurations = {
        ${settings.hostname} = nixpkgs.lib.nixosSystem {
          modules = [
            inputs.stylix.nixosModules.stylix
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
        };
      };

      # Standalone home-manager configuration entrypoint.
      # 'home-manager switch --flake .#username
      homeConfigurations = {
        ${settings.username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${settings.system};
          modules = [
            (./. + "/profiles" + ("/" + settings.profile) + "/home.nix")
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit settings;
          };
        };
      };
    };
}
