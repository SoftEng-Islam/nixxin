{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake.url = "github:xremap/nix-flake";

    #nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # only needed if you use as a package set:
    #nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

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
    ignis = {
      url = "github:linkfrg/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/?submodules=true";
      inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # hyprspace.url = "github:hyprspace/hyprspace";
    # hyprspace.inputs.flake-parts.follows = "flake-parts";
    # hyprspace.inputs.nixpkgs.follows = "nixpkgs";

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    anyrun.url = "github:Kirottu/anyrun";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      settings = import (./. + "/settings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = settings.system; };
    in {
      # NixOS configuration entrypoint.
      # 'nixos-rebuild switch --flake .#hostname
      nixosConfigurations = {
        ${settings.hostName} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
            inputs.home-manager.nixosModules.home-manager
            {
              environment.systemPackages = with pkgs; [
                inputs.ignis.packages.${system}.ignis
              ];
              # use it as an overlay
              #nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit settings;
              };
              # home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = false;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${settings.username} = import
                (./. + "/profiles" + ("/" + settings.profile) + "/home.nix");

              stylix.image = settings.themeDetails.wallpaper;
              stylix.base16Scheme =
                "${pkgs.base16-schemes}/share/themes/${settings.themeDetails.themeName}.yaml";
              stylix.targets.grub.enable = true;
              stylix.targets.plymouth.enable = true;
            }
          ];

        };
      };

      # Standalone home-manager configuration entrypoint.
      # 'home-manager switch --flake .#username
      homeConfigurations = {
        ${settings.username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${settings.system};
          modules = [
            (./. + "/profiles" + ("/" + settings.profile) + "/home.nix")
            inputs.plasma-manager.homeManagerModules.plasma-manager
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
