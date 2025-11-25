{
  description = "DevDocs As a Package For Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devDocs-src = {
      url = "github:yt-dlp/yt-dlp";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, devDocs-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Build your app here
        devDocs = "";

      in {
        packages.default = devDocs;
        apps.default = {
          type = "app";
          program = "${devDocs}/bin/devDocs";
        };
      });
}
