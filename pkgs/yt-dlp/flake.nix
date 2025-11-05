{
  description = "yt-dlp upstream";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    yt-dlp-src = {
      url = "github:yt-dlp/yt-dl/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, yt-dlp-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        yt-dlp = pkgs.python313Packages.buildPythonApplication {
          pname = "yt-dlp";
          version = "latest";
          src = yt-dlp-src;

          pyproject = true;
          build-system = [ pkgs.python313Packages.hatchling ];

          propagatedBuildInputs = with pkgs.python313Packages; [
            brotli
            certifi
            mutagen
            pycryptodomex
            websockets
            requests
          ];

          docheck = false;
        };
      in {
        packages.default = yt-dlp;
        apps.default = {
          type = "app";
          program = "${yt-dlp}/bin/yt-dlp";
        };
      });
}
