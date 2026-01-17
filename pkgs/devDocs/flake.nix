{
  description = "DevDocs flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby_3_3;

        gems = pkgs.bundlerEnv {
          name = "devdocs-env";
          inherit ruby;
          gemdir = ./.;
          env = { NIX_BUILD = "1"; };
          groups = [ "default" ];
        };
      in {
        packages.default = gems;

        devShells.default = pkgs.mkShell {
          inputsFrom = [ gems ];
          packages = [ pkgs.nodejs ruby ];
        };
      });
}
