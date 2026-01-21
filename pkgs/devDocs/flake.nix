{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    { } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        targetRuby = pkgs.ruby_3_4;
        myBundler = pkgs.bundler.override { ruby = targetRuby; };
        gems = pkgs.bundlerEnv {
          name = "devdocs-env";
          ruby = targetRuby;
          bundler = myBundler;
          gemdir = ./.;
          extraConfigPaths = [ "${./.}/.ruby-version" ];
        };
      in {
        packages.default = gems;
        # devShell = with pkgs; mkShell { buildInputs = [ nodejs ]; } // gems.env;
      });
}
