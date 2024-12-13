{
  description = "Softeng Nixxin Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    # superfile.url = "github:yorukot/superfile";
    stylix.url = "github:danth/stylix";
    swww.url = "github:LGFae/swww";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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
            (./. + "/profiles" + ("/" + settings.profile) + "/configuration.nix")
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
