{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = inputs@{ self, nixpkgs, home-manager }:
    let
      mySettings = import (./. + "/mySettings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = mySettings.system; };
    in {
      nixosConfigurations = {
        # Define your NixOS host configuration
        ${mySettings.hostName} = nixpkgs.lib.nixosSystem {
          system = mySettings.system;
          modules = [
            inputs.stylix.nixosModules.stylix
            # Include the NixOS configuration
            (./. + "/profiles" + ("/" + mySettings.profile)
              + "/configuration.nix")

            # Add the Home Manager module for system-level Home Manager
            home-manager.nixosModules.home-manager

            # Define Home Manager settings here
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # User-specific Home Manager configuration
              users.users.${mySettings.username} = {
                isNormalUser = true;
                home = "/home/${mySettings.username}";
                extraGroups = [ "wheel" "video" "audio" ];
                shell = "/bin/zsh";

                home-manager = {
                  user = "${mySettings.username}";
                  home.stateVersion =
                    "24.11"; # Update this to match your Home Manager version
                  imports = [
                    (./. + "/profiles" + ("/" + mySettings.profile)
                      + "/home.nix")
                    # Include user-level Home Manager configuration
                  ];
                };
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit mySettings;
          };
        };
      };
    };
}
