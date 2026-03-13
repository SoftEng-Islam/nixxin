{
  description = "NIXXIN Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # I will use this input to update some packages that are not yet updated in nixos-unstable, such as nodejs 20 and pnpm 8
    to-update.url = "github:NixOS/nixpkgs/master";
    systems.url = "github:nix-systems/default-linux";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yt-dlp-src.url = "path:./pkgs/yt-dlp";
    yt-dlp-src.inputs.nixpkgs.follows = "nixpkgs";

    nixos-opencl.url = "path:./pkgs/nixos-opencl";

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    yazi-compress = {
      url = "github:v3natio/compress.yazi";
      flake = false;
    };

    yazi-hexyl = {
      url = "github:Reledia/hexyl.yazi";
      flake = false;
    };

    yazi-augment-command = {
      url = "github:hankertrix/augment-command.yazi";
      flake = false;
    };

    yazi-what-size = {
      url = "github:pirafrank/what-size.yazi";
      flake = false;
    };

    yazi-flexoki-light = {
      url = "github:gosxrgxx/flexoki-light.yazi";
      flake = false;
    };

    yazi-flexoki-dark = {
      url = "github:gosxrgxx/flexoki-dark.yazi";
      flake = false;
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      to-update,
      ...
    }@inputs:
    let
      # _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      # settings = _SETTINGS.profile;
      # pkgs = nixpkgs.legacyPackages.${settings.system.architecture};

      # 1. Import with empty pkgs just to read static system config
      _bootstrap = import (./. + "/_settings.nix") { pkgs = { }; };
      arch = _bootstrap.profile.system.architecture;
      # 2. Define pkgs using the extracted architecture
      pkgs = nixpkgs.legacyPackages.${arch};
      # 3. Import settings again with real pkgs for full usage
      _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      settings = _SETTINGS.profile;
    in
    {
      # NixOS configuration entrypoint.
      # sudo nixos-rebuild switch --flake .#YourHostname
      nixosConfigurations = {
        "${settings.system.hostName}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit inputs;
            inherit _SETTINGS;
            inherit settings;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            {
              imports = [
                ./pkgs/default.nix
              ];
              nixpkgs.overlays = [
                (final: prev: {
                  update = import to-update {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })
              ];
            }
            (./. + _SETTINGS.path + "/configuration.nix")
          ];
        };
      };
    };
}
