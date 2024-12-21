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

  outputs = inputs:
    let
      pkgs = import inputs.nixpkgs { system = mySettings.system; };
      mySettings = import (./. + "/mySettings.nix") { inherit pkgs; };
      mkLib = pkgs: system:
        let
          lib = pkgs.lib.extend (final: prev: {
            home-manager = inputs.home-manager.lib.hm;
            _custom = import ./lib {
              pkgs = import pkgs { inherit system; };
              inherit inputs;
              inherit lib;
            };
          });
        in lib;
      mkNixosSystem = pkgs: system: hostName:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.stylix.homeManagerModules.stylix
            (./. + "/profiles" + ("/" + mySettings.profile)
              + "/configuration.nix")
            inputs.home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.users.${mySettings.username} = import ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit mySettings;
            lib = mkLib pkgs system;
            nixpkgs = pkgs;
          };
        };
    in {
      nixosConfigurations = {
        ${mySettings.hostName} =
          mkNixosSystem inputs.nixpkgs mySettings.system mySettings.hostName;
      };
    };
}
