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

      # Function to generate NixOS configurations
      mkNixosSystem = system: hostName:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Enable home-manager as part of NixOS
            inputs.home-manager.nixosModules.home-manager
            # Optional modules
            inputs.stylix.nixosModules.stylix
            # inputs.nur.nixosModules.nur
            # inputs.chaotic.nixosModules.default
            # inputs.ucodenix.nixosModules.default
            # Include NixOS configuration
            (./. + "/profiles" + ("/" + mySettings.profile)
              + "/configuration.nix")
          ];

          specialArgs = {
            inherit inputs;
            inherit system;
            inherit mySettings;
            nixpkgs = pkgs;
          };
        };

      # Function to generate home-manager configuration
      mkHomeManagerSystem = pkgs: system: user:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit system;

          home.username = user;
          home.stateVersion = "23.05"; # Adjust to your NixOS version
          modules =
            [ (./. + "/profiles" + ("/" + mySettings.profile) + "/home.nix") ];
        };

    in {
      nixosConfigurations = {
        "${mySettings.hostName}" =
          mkNixosSystem pkgs mySettings.system mySettings.hostName;
      };

      homeConfigurations = {
        # Example: Generate home-manager for the `softeng` user
        softeng = mkHomeManagerSystem pkgs mySettings.system "softeng";
      };
    };
}

