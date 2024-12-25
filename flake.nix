{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";
    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";
    # superfile.url = "github:yorukot/superfile";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mySettings = import (./. + "/mySettings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = mySettings.system; };
    in {
      # NixOS configuration entrypoint.
      # 'nixos-rebuild switch --flake .#hostname
      nixosConfigurations = {
        ${mySettings.hostName} = nixpkgs.lib.nixosSystem {
          modules = [
            inputs.stylix.nixosModules.stylix
            (./. + "/profiles" + ("/" + mySettings.profile)
              + "/configuration.nix")
            {
              stylix.image = mySettings.themeDetails.wallpaper;
              stylix.base16Scheme =
                "${pkgs.base16-schemes}/share/themes/${mySettings.themeDetails.themeName}.yaml";
              stylix.targets.grub.enable = true;
              stylix.targets.plymouth.enable = true;
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit mySettings;
          };
        };
      };

      home-manager.settings = {
        useGlobalPkgs = true;
        useUserPackages = true; # Install user packages to /etc/profiles
      };

      # Standalone home-manager configuration entrypoint.
      # 'home-manager switch --flake .#username
      homeConfigurations = {
        ${mySettings.username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${mySettings.system};
          modules = [
            (./. + "/profiles" + ("/" + mySettings.profile) + "/home.nix")
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit mySettings;
          };
        };
      };
    };

}
