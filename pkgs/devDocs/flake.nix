{
  description = "devdocs";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      packages.x86_64-linux.default = pkgs.bundlerEnv {
        name = "devdocs-env";
        ruby = pkgs.ruby_3_4;
        gemfile = ./Gemfile;
        lockfile = ./Gemfile.lock;
      };
    };
}
