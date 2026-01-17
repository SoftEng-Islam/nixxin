{
  description = "DevDocs flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      ruby = pkgs.ruby_3_3;

      gems = pkgs.bundlerEnv {
        name = "devdocs-env";
        inherit ruby;
        gemdir = ./.;
        groups = [ "default" ];
      };
    in {
      packages.${system}.default = gems;

      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ gems ];
        packages = [
          ruby
          pkgs.nodejs
          pkgs.pngquant
          pkgs.jpegoptim
          pkgs.optipng
          pkgs.gifsicle
          pkgs.svgo
        ];
      };
    };
}
