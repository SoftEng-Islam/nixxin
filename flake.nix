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

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      settings = import (./. + "/settings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = settings.system; };

      mkLib = pkgs: system:
        let
          lib = pkgs.lib.extend
            (final: prev: { home-manager = inputs.home-manager.lib.hm; });
        in lib;
      mkNixosSystem = pkgs: system: hostName:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.ucodenix.nixosModules.default
            home-manager.nixosModules.home-manager
            # ./packages
            # (./. + "/hosts/${hostName}")
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
            # (./. + "/profiles" + ("/" + settings.profile) + "/home.nix")
            {
              nixpkgs.config.allowUnfree = true;
              # nixpkgs.config.permittedInsecurePackages = [ "nodejs-14.21.3" ];
              networking.hostName = settings.hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = settings;
              home-manager.users.softeng = import ./profiles/desktop/home.nix;
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
            inherit system;
            lib = mkLib pkgs system;
            nixpkgs = pkgs;
          };
        };
    in {
      nixosConfigurations = {
        ${settings.hostName} = mkNixosSystem inputs.nixpkgs "${settings.system}"
          "${settings.hostName}";
      };
    };
}
