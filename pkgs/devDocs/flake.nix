{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    { } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gems = pkgs.bundlerEnv {
          name = "devdocs-env";
          ruby = pkgs.ruby_3_4;
          gemfile = ./Gemfile;
          lockfile = ./Gemfile.lock;
        };
      in {
        packages.default = gems;
        devShell = with pkgs; mkShell { buildInputs = [ nodejs ]; } // gems.env;
      });
}
