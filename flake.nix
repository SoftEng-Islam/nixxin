{
  description = "Nixxin Configuration.";

  inputs = {
    # ---------------------------------------------------------------------
    # Nixpkgs channels
    # ---------------------------------------------------------------------

    # Primary channel — everything resolves against this unless stated otherwise.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Rolling channel, exposed as `pkgs.unstable.*` through an overlay below.
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Older pin for ROCm 5.7 (HIP/OpenCL on Picasso/Raven APUs, gfx902).
    # Current nixpkgs ships ROCm 7.x, which dropped these integrated GPUs.
    nixpkgs-older.url = "github:nixos/nixpkgs/nixos-23.11";

    # Extra pin kept around for packages that broke after 24.05.
    nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";

    # ---------------------------------------------------------------------
    # Flake framework and repo tooling
    # ---------------------------------------------------------------------

    # Flake parts for easy flake management.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # Auto-imports a directory tree of modules instead of listing each file.
    import-tree.url = "github:denful/import-tree";

    # git hooks (formatting/linting on commit).
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Supported system list for per-system outputs.
    systems.url = "github:nix-systems/default-linux";

    # One formatter entrypoint for the whole repo (`nix fmt`).
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ---------------------------------------------------------------------
    # System layer: kernel, home-manager, secrets
    # ---------------------------------------------------------------------

    # Home-Manager, kept on the same release as nixpkgs.
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # CachyOS kernel packages.
    # The release branch is used so the binary cache actually has builds;
    # tracking master would mean compiling the kernel locally.
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # age/sops-encrypted secrets, decrypted at activation time.
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    # ---------------------------------------------------------------------
    # Desktop: polkit, Quickshell, Noctalia shell
    # ---------------------------------------------------------------------

    # Polkit authentication agent for Hyprland.
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # Quickshell — QtQuick-based shell toolkit.
    # Upstream lives on outfoxxed's Forgejo instance, not GitHub.
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Overview/workspace widget built on Quickshell.
    # Plain source checkout (flake = false) — consumed as files, not as a flake.
    quickshell-overview = {
      url = "github:Shanu-Kumawat/quickshell-overview";
      flake = false;
    };

    # Noctalia shell and its companion pieces.
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      # Optional: avoids a second nixpkgs copy, at the cost of upstream's cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plugin sources — source-only checkouts.
    noctalia-community-plugins = {
      url = "github:noctalia-dev/community-plugins";
      flake = false;
    };

    noctalia-official-plugins = {
      url = "github:noctalia-dev/official-plugins";
      flake = false;
    };

    # Third-party plugin set; pinned to the same inputs as the rest of the tree.
    noctalia-plugins = {
      url = "github:jechton/noctalia-plugins";
      inputs = {
        noctalia.follows = "noctalia";
        noctalia-official-plugins.follows = "noctalia-official-plugins";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    # ---------------------------------------------------------------------
    # Applications
    # ---------------------------------------------------------------------

    # Google Antigravity — auto-updating, FHS-wrapped, version-pinned.
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ChatGPT desktop client.
    chatgpt-desktop-app.url = "github:poeck/chatgpt-desktop-app-nix-flake";

    wezterm.url = "github:wezterm/wezterm?dir=nix";

    # Local override for yt-dlp (kept in-tree so it can be bumped independently).
    yt-dlp-src.url = "path:./pkgs/yt-dlp";
    yt-dlp-src.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # ---------------------------------------------------------------------
    # Yazi file manager: plugin and theme sources (all source-only)
    # ---------------------------------------------------------------------

    yazi-plugins.url = "github:yazi-rs/plugins";
    yazi-plugins.flake = false;

    yazi-augment-command.url = "github:hankertrix/augment-command.yazi";
    yazi-augment-command.flake = false;

    yazi-hexyl.url = "github:Reledia/hexyl.yazi";
    yazi-hexyl.flake = false;

    yazi-what-size.url = "github:pirafrank/what-size.yazi";
    yazi-what-size.flake = false;

    yazi-flexoki-dark.url = "github:gosxrgxx/flexoki-dark.yazi";
    yazi-flexoki-dark.flake = false;

    yazi-flexoki-light.url = "github:gosxrgxx/flexoki-light.yazi";
    yazi-flexoki-light.flake = false;

    # ---------------------------------------------------------------------
    # Extra package sets (consumed as overlays)
    # ---------------------------------------------------------------------

    # Latest VSCode extensions packaged for Nix.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository — community packages.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    # OpenCL packages for NixOS (disabled).
    # nixos-opencl.url = "path:./pkgs/nixos-opencl";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-older,
      nixpkgs-2405, # pinned channel, available to modules via `inputs`
      unstable,
      nix-cachyos-kernel,
      sops-nix,
      antigravity-nix,
      chatgpt-desktop-app,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;

      # Repo-local helper library (custom builders, lib extensions, etc.).
      forge = import ./forge { inherit inputs lib; };

      # -------------------------------------------------------------------
      # Two-pass settings bootstrap
      #
      # _settings.nix needs `pkgs`, but `pkgs` needs to know the target
      # architecture, which is itself declared in _settings.nix. So it gets
      # imported twice: once with `lib` only to read the architecture, then
      # again with a real `pkgs` for full evaluation.
      # -------------------------------------------------------------------

      # 1. Read the selected user profile to discover the target architecture.
      _bootstrap = import (./. + "/_settings.nix") { lib = nixpkgs.lib; };
      arch = _bootstrap.architecture;

      # 2. Define pkgs using the extracted architecture, with the kernel overlay
      #    applied so settings can reference CachyOS kernel packages.
      pkgs_for_settings = (nixpkgs.legacyPackages.${arch}).extend nix-cachyos-kernel.overlays.pinned;

      # 3. Import settings again with real pkgs for full usage.
      _SETTINGS = import (./. + "/_settings.nix") {
        inherit (nixpkgs) lib;
        pkgs = pkgs_for_settings;
      };
      settings = _SETTINGS.profile;

      # Legacy package set for ROCm 5.7 and anything else that needs 23.11.
      pkgs-older = import nixpkgs-older {
        system = arch; # map the local `arch` variable onto the `system` key
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      # -------------------------------------------------------------------
      # NixOS configuration entrypoint
      # sudo nixos-rebuild switch --flake .#YourHostname
      # -------------------------------------------------------------------
      nixosConfigurations = {
        "${settings.system.hostName}" = nixpkgs.lib.nixosSystem {
          # Values threaded into every module in the tree.
          specialArgs = {
            inherit
              self
              inputs
              _SETTINGS
              settings
              pkgs-older
              forge
              ;
          };

          modules = [
            # External NixOS modules.
            inputs.home-manager.nixosModules.home-manager
            inputs.noctalia-greeter.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
            sops-nix.nixosModules.sops
            chatgpt-desktop-app.nixosModules.default

            # Inline module: local package set + global overlays.
            {
              imports = [
                ./pkgs/default.nix
              ];

              nixpkgs.overlays = [
                # CachyOS kernel. The *pinned* overlay is used deliberately so
                # builds hit the binary cache instead of compiling locally.
                nix-cachyos-kernel.overlays.pinned

                # Expose the unstable channel as `pkgs.unstable.*`.
                (final: prev: {
                  unstable = import unstable {
                    inherit (final) config;
                    inherit (final.stdenv.hostPlatform) system;
                  };
                })

                # VSCode extensions from nix-community.
                inputs.nix-vscode-extensions.overlays.default

                # Provides pkgs.google-antigravity and pkgs.google-antigravity-no-fhs.
                antigravity-nix.overlays.default

                # Local fixups.
                (_final: _prev: {
                  # nixos-26.05 ships fzf 0.72.0 but home-manager's fzf module now
                  # requires >= 0.73.0 for nushell integration. Pull fzf from unstable.
                  fzf = unstable.legacyPackages.${arch}.fzf;

                  # libplacebo's Vulkan codegen passes an ElementTree instead of its
                  # root element, which breaks with newer Python. Patch it in place.
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

            # The rest of the configuration tree.
            ./users/configuration.nix
          ];
        };
      };

      # Cheap check that forces `settings` to evaluate, so a malformed
      # _settings.nix fails in `nix flake check` rather than mid-rebuild.
      checks.${arch}.schema-conformance = builtins.seq settings (
        pkgs_for_settings.writeText "schema-conformance-ok" "ok"
      );
    };
}
