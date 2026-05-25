{
  description = "Nixxin Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts"; # Flake parts for easy flake management
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # I will use this input to update some packages that are not yet updated in nixos-unstable, such as nodejs 20 and pnpm 8
    to-update.url = "github:NixOS/nixpkgs/master";

    # Google Antigravity — auto-updating, FHS-wrapped, version-pinned
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kiro-flake.url = "github:connerohnesorge/kiro-flake";
    kiro-flake.inputs.nixpkgs.follows = "nixpkgs";

    # Nixos Home-Manager
    # Using release-24.11 instead of master due to a bug in master
    # where services-modular references non-existent lib/services/lib.nix
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # To use cahsyOs Kernel Packages
    # Use the release branch for guaranteed binary cache availability
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Polkit
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # -----------------------------
    # needed by "https://github.com/Shanu-Kumawat/quickshell-overview"
    quickshell = {
      # Updated the URL to match the new repository location
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v5";
      # https://docs.noctalia.dev/v5/getting-started/nixos/
      # To use the binary cache, you have to omit inputs.nixpkgs.follows from the Noctalia input.
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # -----------------------------

    yt-dlp-src.url = "path:./pkgs/yt-dlp";
    yt-dlp-src.inputs.nixpkgs.follows = "nixpkgs";

    # OpenCL Packages for Nixos
    # nixos-opencl.url = "path:./pkgs/nixos-opencl";

    # Zen Web Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Yazi File Manager
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

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions"; # Grab latest VScode extensions as a package;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository, for community packages
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      to-update,
      nix-cachyos-kernel,
      sops-nix,
      antigravity-nix,
      kiro-flake,
      ...
    }@inputs:
    let
      # _SETTINGS = import (./. + "/_settings.nix") { inherit pkgs; };
      # settings = _SETTINGS.profile;
      # pkgs = nixpkgs.legacyPackages.${settings.system.architecture};

      # 1. Read the selected user profile to discover the target architecture.
      _bootstrap = import (./. + "/_settings.nix") { lib = nixpkgs.lib; };
      arch = _bootstrap.architecture;
      # 2. Define pkgs using the extracted architecture with overlays
      pkgs_for_settings = (nixpkgs.legacyPackages.${arch}).extend nix-cachyos-kernel.overlays.pinned;
      # 3. Import settings again with real pkgs for full usage
      _SETTINGS = import (./. + "/_settings.nix") {
        inherit (nixpkgs) lib;
        pkgs = pkgs_for_settings;
      };
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
            sops-nix.nixosModules.sops

            {
              imports = [
                ./pkgs/default.nix
              ];
              nixpkgs.overlays = [
                # Use pinned overlay for binary cache hits (avoids local kernel compilation)
                nix-cachyos-kernel.overlays.pinned

                (final: prev: {
                  update = import to-update {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })

                inputs.nix-vscode-extensions.overlays.default

                # Provides pkgs.google-antigravity and pkgs.google-antigravity-no-fhs
                antigravity-nix.overlays.default

              ];
            }
            ./users/configuration.nix
          ];
        };
      };
    };
}
