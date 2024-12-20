{
  description = "Softeng Nixxin Configuration";
  inputs = {
    # channels
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

    # others
    retroarch-shaders.url = "github:libretro/glsl-shaders";
    retroarch-shaders.flake = false;

    # terminal tools
    fuzzy-sys.url = "github:NullSense/fuzzy-sys";
    fuzzy-sys.flake = false;

    kitty-scrollback-nvim.url = "github:mikesmithgh/kitty-scrollback.nvim";
    kitty-scrollback-nvim.flake = false;

    kitty-smart-scroll.url = "github:yurikhan/kitty-smart-scroll";
    kitty-smart-scroll.flake = false;

    kitty-smart-tab.url = "github:yurikhan/kitty-smart-tab";
    kitty-smart-tab.flake = false;

    smart-splits-nvim.url = "github:mrjones2014/smart-splits.nvim";
    smart-splits-nvim.flake = false;

    zsh-autocomplete.url = "github:wochap/zsh-autocomplete";
    zsh-autocomplete.flake = false;

    zsh-defer.url = "github:romkatv/zsh-defer";
    zsh-defer.flake = false;

    zsh-history-substring-search.url =
      "github:zsh-users/zsh-history-substring-search";
    zsh-history-substring-search.flake = false;

    zsh-notify.url = "github:marzocchi/zsh-notify";
    zsh-notify.flake = false;

    zsh-vi-mode.url = "github:wochap/zsh-vi-mode";
    zsh-vi-mode.flake = false;

    zsh-pnpm-shell-completion.url = "github:g-plane/pnpm-shell-completion";
    zsh-pnpm-shell-completion.flake = false;

    figlet-fonts.url = "github:wochap/figlet-fonts";
    figlet-fonts.flake = false;

    ipwebcam-gst.url = "github:agarciadom/ipwebcam-gst";
    ipwebcam-gst.flake = false;

    tmux-sessionx.url = "github:omerxx/tmux-sessionx";

    nnn-cppath.url = "github:raffaem/nnn-cppath";
    nnn-cppath.flake = false;

  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = import nixpkgs { system = settings.system; };
      settings = import (./. + "/settings.nix") { inherit pkgs; };
    in {
      nixosConfigurations = {
        # NixOS configuration entrypoint.
        # 'nixos-rebuild switch --flake .#hostname
        ${settings.hostName} = nixpkgs.lib.nixosSystem {
          modules = [
            inputs.stylix.nixosModules.stylix
            # inputs.chaotic.nixosModules.default
            inputs.ucodenix.nixosModules.default
            # inputs.nur.nixosModules.nur
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
            inputs.home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              # nixpkgs.config.permittedInsecurePackages = [ "nodejs-14.21.3" ];
              networking.hostName = settings.hostName;
            }
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
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = settings;
              home-manager.users.${settings.username} =
                import ./profiles/${settings.profile}/home.nix;
            }
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit settings;
          };
        };
      };
    };
}
