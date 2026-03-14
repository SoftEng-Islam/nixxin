{
  description = "NIXXIN Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";

    # I will use this input to update some packages that are not yet updated in nixos-unstable, such as nodejs 20 and pnpm 8
    to-update.url = "github:NixOS/nixpkgs/master";

    # Nixos Home-Manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # To use cahsyOs Kernel Packages
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    # Polkit
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    # Noctalia Shell
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.inputs.noctalia-qs.follows = "noctalia-qs";
    noctalia-qs.url = "github:noctalia-dev/noctalia-qs";
    noctalia-qs.inputs.nixpkgs.follows = "nixpkgs";

    yt-dlp-src.url = "path:./pkgs/yt-dlp";
    yt-dlp-src.inputs.nixpkgs.follows = "nixpkgs";

    # OpenCL Packages for Nixos
    nixos-opencl.url = "path:./pkgs/nixos-opencl";

    # Zen Web Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # yazi File Manager
    yazi-plugins.url = "github:yazi-rs/plugins";
    yazi-plugins.flake = false;
    yazi-compress.url = "github:v3natio/compress.yazi";
    yazi-compress.flake = false;
    yazi-hexyl.url = "github:Reledia/hexyl.yazi";
    yazi-hexyl.flake = false;
    yazi-augment-command.url = "github:hankertrix/augment-command.yazi";
    yazi-augment-command.flake = false;
    yazi-what-size.url = "github:pirafrank/what-size.yazi";
    yazi-what-size.flake = false;
    yazi-flexoki-light.url = "github:gosxrgxx/flexoki-light.yazi";
    yazi-flexoki-light.flake = false;
    yazi-flexoki-dark.url = "github:gosxrgxx/flexoki-dark.yazi";
    yazi-flexoki-dark.flake = false;
  };
  outputs =
    {
      self,
      nixpkgs,
      to-update,
      nix-cachyos-kernel,
      ...
    }@inputs:
    let
      # _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      # settings = _SETTINGS.profile;
      # pkgs = nixpkgs.legacyPackages.${settings.system.architecture};

      # 1. Import with empty pkgs just to read static system config
      _bootstrap = import (./. + "/_settings.nix") { pkgs = { }; };
      arch = _bootstrap.profile.system.architecture;
      # 2. Define pkgs using the extracted architecture with overlays
      pkgs_for_settings = (nixpkgs.legacyPackages.${arch}).extend nix-cachyos-kernel.overlays.default;
      # 3. Import settings again with real pkgs for full usage
      _SETTINGS = import (./. + "/_settings.nix") { pkgs = pkgs_for_settings; };
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
                nix-cachyos-kernel.overlays.default

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
