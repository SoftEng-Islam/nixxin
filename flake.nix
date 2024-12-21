{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # `ucodenix` is a Nix flake providing AMD microcode updates for unsupported CPUs.
    ucodenix.url = "github:e-tho/ucodenix";
    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";
    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";
    # superfile.url = "github:yorukot/superfile";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  };

  outputs = { pkgs, system, ... }@inputs:
    let
      mySettings = import (./. + "/mySettings.nix") {
        pkgs = import pkgs { inherit system; };
        inherit inputs;
      };
      mkLib = pkgs: system:
        let
          lib = pkgs.lib.extend
            (final: prev: { home-manager = inputs.home-manager.lib.hm; });
        in lib;
      mkNixosSystem = pkgs: system: hostName:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            # inputs.nur.nixosModules.nur
            # inputs.chaotic.nixosModules.default
            # inputs.ucodenix.nixosModules.default
            # ./packages
            # (./. + "/hosts/${hostName}")
            (./. + "/profiles" + ("/" + mySettings.profile)
              + "/configuration.nix")
            (./. + "/profiles" + ("/" + mySettings.profile) + "/home.nix")

            {
              nixpkgs.config.allowUnfree = true;
              networking.hostName = mySettings.hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.extraSpecialArgs = { inherit mySettings; };
              home-manager.users.${mySettings.username} =
                import ./profiles/${mySettings.profile}/home.nix {
                  inherit pkgs;
                  mySettings = mySettings; # Explicitly pass it
                };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit system;
            lib = mkLib pkgs system;
            nixpkgs = pkgs;
          };
        };

    in {
      nixosConfigurations = {
        ${mySettings.hostName} =
          mkNixosSystem inputs.nixpkgs mySettings.hostName;
      };
    };
}
