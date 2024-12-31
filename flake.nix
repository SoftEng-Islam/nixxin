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
    impurity.url = "github:outfoxxed/impurity.nix";
    thorium.url = "github:end-4/nix-thorium";
    hyprland = {
      url = "github:hyprwm/Hyprland/?submodules=true";
      inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      # inputs.hyprland.follows = "hyprland";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    gross = {
      url = "github:fufexan/gross";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    matugen = {
      url = "github:/InioX/Matugen";
      # ref = "refs/tags/matugen-v0.10.0"
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
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      settings = import (./. + "/settings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = settings.system; };
    in {
      # NixOS configuration entrypoint.
      # 'sudo nixos-rebuild switch --flake .#YourHostname
      nixosConfigurations = {
        ${settings.hostName} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit settings;
            inherit self;
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
            {
              environment.systemPackages = with pkgs; [
                inputs.ignis.packages.${system}.ignis
                inputs.ags.packages.${system}.default
              ];
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                  inherit settings;
                  inherit self;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                verbose = true;
                backupFileExtension = "old";
                users.${settings.username} = import
                  (./. + "/profiles" + ("/" + settings.profile) + "/home.nix");
              };

              stylix = {
                image = settings.themeDetails.wallpaper;
                base16Scheme =
                  "${pkgs.base16-schemes}/share/themes/${settings.themeDetails.themeName}.yaml";
                targets.grub.enable = true;
                targets.plymouth.enable = true;
              };
            }
          ];
        };
      };
    };
}
