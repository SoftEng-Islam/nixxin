{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # superfile.url = "github:yorukot/superfile";
    xremap-flake.url = "github:xremap/nix-flake";

    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";

    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    ignis.url = "github:linkfrg/ignis";
    ignis.inputs.nixpkgs.follows = "nixpkgs";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    impurity.url = "github:outfoxxed/impurity.nix";
    thorium.url = "github:end-4/nix-thorium";

    hyprland.url = "github:hyprwm/Hyprland/?submodules=true";
    hyprland.inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";

    # A material you color generation tool
    matugen.url = "github:/InioX/Matugen";

    # hyprspace.url = "github:hyprspace/hyprspace";
    # hyprspace.inputs.flake-parts.follows = "flake-parts";
    # hyprspace.inputs.nixpkgs.follows = "nixpkgs";

    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprpicker.inputs.nixpkgs.follows = "nixpkgs";

    pyprland.url = "github:hyprland-community/pyprland";
    pyprland.inputs.nixpkgs.follows = "nixpkgs";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ignis, ... }@inputs:
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
            (./. + "/configs/configuration.nix")
          ];
        };
      };
    };
}
