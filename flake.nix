{
  description = "Nixxin Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis.url = "git+https://github.com/linkfrg/ignis?submodules=1";
    ignis.inputs.nixpkgs.follows = "nixpkgs";

    # superfile.url = "github:yorukot/superfile";
    xremap-flake.url = "github:xremap/nix-flake";

    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";

    # Efficient Animated Wallpaper Daemon For Wayland, controlled at runtime
    swww.url = "github:LGFae/swww";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    # aagl.inputs.nixpkgs.follows = "nixpkgs";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # impurity.url = "github:outfoxxed/impurity.nix";
    # thorium.url = "github:end-4/nix-thorium";

    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround

    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland.git";
    #   submodules = true;
    #   # git ls-remote https://github.com/hyprwm/Hyprland.git refs/tags/v0.46.2
    #   ref = "refs/tags/v0.46.2";
    #   inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    # };

    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    # hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # hyprlock.url = "github:hyprwm/hyprlock";
    # hyprlock.inputs.hyprland.follows = "hyprland";

    # Hyprspace.url = "github:KZDKM/Hyprspace";
    # Hyprspace.url = "github:ReshetnikovPavel/Hyprspace";
    # Hyprspace.inputs.hyprland.follows = "hyprland";

    #hyprpicker.url = "github:hyprwm/hyprpicker";
    #hyprpicker.inputs.nixpkgs.follows = "nixpkgs";

    #pyprland.url = "github:hyprland-community/pyprland";
    #pyprland.inputs.nixpkgs.follows = "nixpkgs";

    # A Material You Color Generation Tool
    # matugen.url = "github:/InioX/Matugen";

    anytype.url = "github:/anyproto/anytype-ts";
    anytype.inputs.nixpkgs.follows = "nixpkgs";

    # ---- Terminals ---- #
    smart-splits-nvim.url = "github:mrjones2014/smart-splits.nvim";
    smart-splits-nvim.flake = false;

    kitty-scrollback-nvim.url = "github:mikesmithgh/kitty-scrollback.nvim";
    kitty-scrollback-nvim.flake = false;

    kitty-smart-scroll.url = "github:yurikhan/kitty-smart-scroll";
    kitty-smart-scroll.flake = false;

    kitty-smart-tab.url = "github:yurikhan/kitty-smart-tab";
    kitty-smart-tab.flake = false;

    ashell = {
      url = "github:MalpenZibo/ashell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        ${settings.system.hostName} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit inputs;
            inherit _SETTINGS;
            inherit settings;
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            (./. + _SETTINGS.path + "/configuration.nix")
          ];
        };
      };
    };
}
