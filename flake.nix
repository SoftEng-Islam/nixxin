{
  description = "Nixxin Configuration.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # 1. Add the older nixpkgs input for ROCm 5.6
    nixpkgs-older.url = "github:nixos/nixpkgs/nixos-23.11";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts"; # Flake parts for easy flake management
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Google Antigravity — auto-updating, FHS-wrapped, version-pinned
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixos Home-Manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # To use cahsyOs Kernel Packages
    # Use the release branch for guaranteed binary cache availability
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Polkit
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # Codez Desktop
    chatgpt-desktop-app.url = "github:poeck/chatgpt-desktop-app-nix-flake";

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
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
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
      nixpkgs-older,
      unstable,
      nix-cachyos-kernel,
      sops-nix,
      antigravity-nix,
      chatgpt-desktop-app,
      ...
    }@inputs:
    let
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
      pkgs-older = import nixpkgs-older {
        system = arch; # Map your 'arch' variable to the 'system' key
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      # NixOS configuration entrypoint.
      # sudo nixos-rebuild switch --flake .#YourHostname
      nixosConfigurations = {
        "${settings.system.hostName}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              self
              inputs
              _SETTINGS
              settings
              pkgs-older
              ;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            chatgpt-desktop-app.nixosModules.default

            {
              imports = [
                ./pkgs/default.nix
              ];
              nixpkgs.overlays = [
                # Use pinned overlay for binary cache hits (avoids local kernel compilation)
                nix-cachyos-kernel.overlays.pinned

                (final: prev: {
                  unstable = import unstable {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })

                inputs.nix-vscode-extensions.overlays.default

                # Provides pkgs.google-antigravity and pkgs.google-antigravity-no-fhs
                antigravity-nix.overlays.default

                # nixos-26.05 ships fzf 0.72.0 but home-manager's fzf module now
                # requires ≥ 0.73.0 for nushell integration. Pull fzf from unstable.
                (_final: _prev: {
                  fzf = unstable.legacyPackages.${arch}.fzf;
                  libplacebo = _prev.libplacebo.overrideAttrs (old: {
                    postPatch = (old.postPatch or "") + ''
                      # Only patch if the old VkXML(ET.parse(xmlfile)) pattern is present
                      if [ -f src/vulkan/utils_gen.py ]; then
                        sed -i 's/VkXML(ET.parse(xmlfile))/VkXML(ET.parse(xmlfile).getroot())/g' src/vulkan/utils_gen.py || true
                      fi
                    '';
                  });
                })

              ];

            }
            ./users/configuration.nix
          ];
        };
      };
    };
}
