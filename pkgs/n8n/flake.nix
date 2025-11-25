{
  description = "DevDocs As a Package For Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    n8n-src = {
      url = "github:n8n/n8n";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, n8n-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Build your app here
        n8n = "";

      in {
        packages.default = n8n;
        apps.default = {
          type = "app";
          program = "${n8n}/bin/n8n";
        };
      });
}
